#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
XPLANE_DIR="/home/stephan/X-Plane 12"
KML_SOURCE_DIR="${XPLANE_DIR}/KML"
SCREENSHOT_DIRECTORY="${XPLANE_DIR}/Output/screenshots"
KMZ_GENERATOR_SCRIPT="/home/stephan/dev/weisair/batch_scripts/kmz_generator/combine_to_kmz.py"
UDP_LOGGER_CSV="/home/stephan/dev/weisair/batch_scripts/udpLogger/xplane_log.csv"
FLIGHT_PLOT_SCRIPT="/home/stephan/dev/weisair/analysis/plot_xplane_flight.py"
PYTHON_EXECUTABLE="python3"
SOURCE_FILE="/home/stephan/X-Plane 12/FlightLog1.0.csv"
DESTINATION_FILE="${SCRIPT_DIR}/FlightLog1.0.csv"
LOG_FILE="${SCRIPT_DIR}/LinuxXPDebrief.log"
POLL_INTERVAL=5
FLIGHT_DIRECTORY=""

log_status() {
    printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" | tee -a "$LOG_FILE"
}

process_is_active() {
    local process_state
    process_state="$(ps -p "$1" -o stat= 2>/dev/null || true)"
    [[ -n "$process_state" && "$process_state" != Z* ]]
}

stop_udp_logger() {
    local process_pattern='(^|[[:space:]/])xplane_udp_csv\.py([[:space:]]|$)'
    local process_ids process_id process_name process_arguments result
    local stopped_processes=0

    if process_ids="$(pgrep -f -- "$process_pattern")"; then
        :
    else
        result=$?
        if (( result == 1 )); then
            log_status "xplane_udp_csv.py is not running; no process to stop"
            return 0
        fi

        log_status "ERROR: Failed to search for xplane_udp_csv.py processes (pgrep status $result)"
        return 1
    fi

    for process_id in $process_ids; do
        process_name="$(ps -p "$process_id" -o comm= 2>/dev/null || true)"
        process_arguments="$(ps -p "$process_id" -o args= 2>/dev/null || true)"
        if [[ ! "$process_name" =~ ^python([0-9]+([.][0-9]+)*)?$ ||
              "$process_arguments" != *xplane_udp_csv.py* ]]; then
            continue
        fi

        stopped_processes=$((stopped_processes + 1))
        if kill -TERM "$process_id" 2>/dev/null; then
            local attempt
            for attempt in 1 2 3 4 5; do
                if ! process_is_active "$process_id"; then
                    log_status "Stopped xplane_udp_csv.py process $process_id with SIGTERM"
                    break
                fi
                sleep 1
            done

            if process_is_active "$process_id"; then
                if ! kill -KILL "$process_id" 2>/dev/null; then
                    log_status "ERROR: Could not force-stop xplane_udp_csv.py process $process_id"
                    return 1
                fi
                for attempt in 1 2 3 4 5; do
                    if ! process_is_active "$process_id"; then
                        log_status "Stopped unresponsive xplane_udp_csv.py process $process_id with SIGKILL"
                        break
                    fi
                    sleep 1
                done
                if process_is_active "$process_id"; then
                    log_status "ERROR: xplane_udp_csv.py process $process_id remained active after SIGKILL"
                    return 1
                fi
            fi
        elif process_is_active "$process_id"; then
            log_status "ERROR: Could not stop xplane_udp_csv.py process $process_id"
            return 1
        else
            log_status "xplane_udp_csv.py process $process_id exited before it could be stopped"
        fi
    done

    if (( stopped_processes == 0 )); then
        log_status "xplane_udp_csv.py is not running; no process to stop"
    fi
}

create_flight_directories() {
    if [[ ! "$ACF" =~ ^[[:alnum:]_-]+$ ||
          ! "$ICAO_D" =~ ^[[:alnum:]_-]+$ ||
          ! "$ICAO_A" =~ ^[[:alnum:]_-]+$ ||
          ! "$DATE_FLIGHT" =~ ^[0-9]{8}$ ||
          ! "$TIME_FLIGHT" =~ ^[0-9]{4}$ ]]; then
        log_status "ERROR: Flight details contain invalid characters for directory names"
        return 1
    fi

    FLIGHT_DIRECTORY="${SCRIPT_DIR}/flights/${DATE_FLIGHT}_${TIME_FLIGHT}_${ACF}_${ICAO_D}_${ICAO_A}"
    if ! mkdir -p -- \
        "${FLIGHT_DIRECTORY}/xp_logs_stats" \
        "${FLIGHT_DIRECTORY}/geo" \
        "${FLIGHT_DIRECTORY}/data" \
        "${FLIGHT_DIRECTORY}/capture"; then
        log_status "ERROR: Failed to create flight directory structure at $FLIGHT_DIRECTORY"
        return 1
    fi

    log_status "Created flight directory structure: $FLIGHT_DIRECTORY/{xp_logs_stats,geo,data,capture}"
}

copy_udp_logger_csv() {
    local destination_file
    destination_file="${FLIGHT_DIRECTORY}/data/$(basename -- "$FLIGHT_DIRECTORY").csv"

    if [[ ! -f "$UDP_LOGGER_CSV" || ! -r "$UDP_LOGGER_CSV" ]]; then
        log_status "ERROR: UDP logger CSV is missing or unreadable: $UDP_LOGGER_CSV"
        return 1
    fi

    if ! cp -- "$UDP_LOGGER_CSV" "$destination_file"; then
        log_status "ERROR: Failed to copy UDP logger CSV to $destination_file"
        return 1
    fi

    log_status "Copied UDP logger CSV to $destination_file"
}

plot_flight_csv() {
    local data_directory csv_filename
    data_directory="${FLIGHT_DIRECTORY}/data"
    csv_filename="$(basename -- "$FLIGHT_DIRECTORY").csv"

    if [[ ! -f "$FLIGHT_PLOT_SCRIPT" || ! -r "$FLIGHT_PLOT_SCRIPT" ]]; then
        log_status "ERROR: Flight plot script is missing or unreadable: $FLIGHT_PLOT_SCRIPT"
        return 1
    fi
    if [[ ! -r "${data_directory}/${csv_filename}" ]]; then
        log_status "ERROR: Flight CSV is missing or unreadable: ${data_directory}/${csv_filename}"
        return 1
    fi
    if ! command -v -- "$PYTHON_EXECUTABLE" >/dev/null 2>&1; then
        log_status "ERROR: Python executable was not found: $PYTHON_EXECUTABLE"
        return 1
    fi

    log_status "Running flight plot script for $csv_filename"
    if ! (
        cd -- "$data_directory" &&
        "$PYTHON_EXECUTABLE" "$FLIGHT_PLOT_SCRIPT" "$csv_filename"
    ) >> "$LOG_FILE" 2>&1; then
        log_status "ERROR: Flight plot script failed for $csv_filename"
        return 1
    fi

    log_status "Flight plot script completed successfully for $csv_filename"
}

copy_xplane_logs() {
    local source_file destination_directory
    destination_directory="${FLIGHT_DIRECTORY}/xp_logs_stats"

    for source_file in \
        "${XPLANE_DIR}/Log.txt" \
        "${XPLANE_DIR}/Output/diagnostic reports/telemetry_0.tlm"; do
        if [[ ! -f "$source_file" || ! -r "$source_file" ]]; then
            log_status "ERROR: X-Plane log file is missing or unreadable: $source_file"
            return 1
        fi

        if ! cp -- "$source_file" "$destination_directory/"; then
            log_status "ERROR: Failed to copy $source_file to $destination_directory"
            return 1
        fi

        log_status "Copied X-Plane log file to $destination_directory/$(basename -- "$source_file")"
    done
}

copy_flight_kml() {
    local kml_filename kml_source kml_destination
    kml_filename="${ICAO_D}-${ICAO_A}_${DATE_FLIGHT}_${TIME_FLIGHT}.kml"
    kml_source="${KML_SOURCE_DIR}/${kml_filename}"
    kml_destination="${FLIGHT_DIRECTORY}/geo/${kml_filename}"

    if [[ ! -f "$kml_source" || ! -r "$kml_source" ]]; then
        log_status "ERROR: Expected flight KML is missing or unreadable: $kml_source"
        return 1
    fi

    if ! cp -- "$kml_source" "$kml_destination"; then
        log_status "ERROR: Failed to copy flight KML from $kml_source to $kml_destination"
        return 1
    fi

    log_status "Copied flight KML to $kml_destination"
}

generate_flight_kmz() {
    local geo_directory kml_filename kmz_filename temporary_kmz
    geo_directory="${FLIGHT_DIRECTORY}/geo"
    kml_filename="${ICAO_D}-${ICAO_A}_${DATE_FLIGHT}_${TIME_FLIGHT}.kml"
    kmz_filename="$(basename -- "$FLIGHT_DIRECTORY").kmz"
    temporary_kmz="${kmz_filename}.tmp.$$"

    if [[ ! -f "$KMZ_GENERATOR_SCRIPT" || ! -r "$KMZ_GENERATOR_SCRIPT" ]]; then
        log_status "ERROR: KMZ generator is missing or unreadable: $KMZ_GENERATOR_SCRIPT"
        return 1
    fi
    if ! command -v -- "$PYTHON_EXECUTABLE" >/dev/null 2>&1; then
        log_status "ERROR: Python executable was not found: $PYTHON_EXECUTABLE"
        return 1
    fi
    if [[ ! -d "$SCREENSHOT_DIRECTORY" || ! -r "$SCREENSHOT_DIRECTORY" ]]; then
        log_status "ERROR: Screenshot directory is missing or unreadable: $SCREENSHOT_DIRECTORY"
        return 1
    fi

    log_status "Running KMZ generator for $kml_filename"
    if ! (
        cd -- "$geo_directory" &&
        "$PYTHON_EXECUTABLE" "$KMZ_GENERATOR_SCRIPT" \
            --flight-log "$DESTINATION_FILE" \
            --capture-output "${FLIGHT_DIRECTORY}/capture" \
            --flight-aircraft "$ACF" \
            --flight-date "$DATE_FLIGHT" \
            --departure-icao "$ICAO_D" \
            --arrival-icao "$ICAO_A" \
            --flight-start-time "$TIME_FLIGHT" \
            "$kml_filename" \
            "$SCREENSHOT_DIRECTORY" \
            "$temporary_kmz"
    ) >> "$LOG_FILE" 2>&1; then
        rm -f -- "${geo_directory}/${temporary_kmz}"
        log_status "ERROR: KMZ generator failed for $kml_filename"
        return 1
    fi

    if [[ ! -s "${geo_directory}/${temporary_kmz}" ]]; then
        log_status "ERROR: KMZ generator did not create a non-empty output for $kml_filename"
        rm -f -- "${geo_directory}/${temporary_kmz}"
        return 1
    fi

    if ! mv -f -- "${geo_directory}/${temporary_kmz}" "${geo_directory}/${kmz_filename}"; then
        log_status "ERROR: Failed to install generated KMZ at ${geo_directory}/${kmz_filename}"
        rm -f -- "${geo_directory}/${temporary_kmz}"
        return 1
    fi

    log_status "Created flight KMZ: ${geo_directory}/${kmz_filename}"
}

if ! touch "$LOG_FILE"; then
    printf 'Cannot write debrief log: %s\n' "$LOG_FILE" >&2
    exit 1
fi

if [[ ! -r "$SOURCE_FILE" ]]; then
    log_status "ERROR: Cannot read X-Plane flight log: $SOURCE_FILE"
    exit 1
fi

last_line_count="$(wc -l < "$SOURCE_FILE")"
log_status "Watcher started; monitoring $SOURCE_FILE every $POLL_INTERVAL seconds"
log_status "Initial flight log record count: $last_line_count"

while true; do
    sleep "$POLL_INTERVAL"

    if [[ ! -r "$SOURCE_FILE" ]]; then
        log_status "ERROR: X-Plane flight log is no longer readable: $SOURCE_FILE"
        exit 1
    fi

    current_line_count="$(wc -l < "$SOURCE_FILE")"
    if (( current_line_count < last_line_count )); then
        log_status "Flight log was shortened from $last_line_count to $current_line_count lines; resetting the baseline"
        last_line_count="$current_line_count"
        continue
    fi

    if (( current_line_count > last_line_count )); then
        if ! cp -- "$SOURCE_FILE" "$DESTINATION_FILE"; then
            log_status "ERROR: Failed to copy flight log to $DESTINATION_FILE"
            exit 1
        fi

        if ! flight_info="$(python3 - "$SOURCE_FILE" 2>&1 <<'PY'
import csv
import sys
from datetime import datetime

source_file = sys.argv[1]
with open(source_file, newline="", encoding="utf-8-sig") as flight_log:
    reader = csv.DictReader(flight_log)
    required_columns = (
        "Aircraft",
        "Departure ICAO",
        "Arrival ICAO",
        "Date",
        "system_time_start",
    )
    if reader.fieldnames is None or any(
        column not in reader.fieldnames for column in required_columns
    ):
        raise ValueError("CSV is missing one or more required columns")

    latest_record = None
    for row in reader:
        if any(value not in (None, "") for value in row.values()):
            latest_record = row

if latest_record is None:
    raise ValueError("CSV contains no flight records")

flight_date = datetime.strptime(latest_record["Date"], "%Y-%m-%d").strftime("%Y%m%d")
flight_start = datetime.strptime(
    latest_record["system_time_start"], "%Y-%m-%d %I.%M.%S %p"
).strftime("%H%M")
values = (
    latest_record["Aircraft"],
    latest_record["Departure ICAO"],
    latest_record["Arrival ICAO"],
    flight_date,
    flight_start,
)
if any(value in (None, "") for value in values):
    raise ValueError("Latest flight record has an empty required value")
print("\t".join(values))
PY
        )"; then
            log_status "ERROR: Failed to read flight details: $flight_info"
            exit 1
        fi

        IFS=$'\t' read -r ACF ICAO_D ICAO_A DATE_FLIGHT TIME_FLIGHT <<< "$flight_info"
        log_status "Detected $((current_line_count - last_line_count)) new line(s); copied $current_line_count lines to $DESTINATION_FILE; ACF=$ACF ICAO_D=$ICAO_D ICAO_A=$ICAO_A DATE_FLIGHT=$DATE_FLIGHT TIME_FLIGHT=$TIME_FLIGHT"
        if ! stop_udp_logger; then
            exit 1
        fi
        if ! create_flight_directories; then
            exit 1
        fi
        if ! copy_udp_logger_csv; then
            exit 1
        fi
        if ! plot_flight_csv; then
            exit 1
        fi
        if ! copy_flight_kml; then
            exit 1
        fi
        if ! generate_flight_kmz; then
            exit 1
        fi
        if ! copy_xplane_logs; then
            exit 1
        fi
        last_line_count="$current_line_count"
    fi
done