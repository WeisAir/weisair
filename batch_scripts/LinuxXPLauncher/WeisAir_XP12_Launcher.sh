#!/usr/bin/env bash

# Configurable application paths and commands.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
USB_CHECK_SCRIPT="${SCRIPT_DIR}/check_connected_devices.sh"
AIRAC_DOWNLOADER_SCRIPT="${SCRIPT_DIR}/../AIRAC_downloader/download_airac.sh"
LITTLENAVMAP_EXECUTABLE="/home/stephan/X-Plane-12-Assets/tools/LittleNavmap-linux-ubuntu-24.04-3.0.18/littlenavmap"
UDP_LOGGER_SCRIPT="../udpLogger/xplane_udp_csv.py"
UDP_LOG_CSV="${SCRIPT_DIR}/../udpLogger/xplane_log.csv"
PYTHON_EXECUTABLE="python3"
STATUS_BAR_SCRIPT="${SCRIPT_DIR}/WeisAir_XP12_Launcher_status.py"
# Set WEISAIR_STATUS_BAR=0 to use the original launcher without the status bar.
STATUS_BAR_ENABLED="${WEISAIR_STATUS_BAR:-1}"
# Set WEISAIR_STATUS_BAR_HEIGHT, WEISAIR_STATUS_BAR_SCREEN, and
# WEISAIR_STATUS_BAR_HOVER_WIDTH, and WEISAIR_STATUS_BAR_CLOSE_ACTION to
# customize the bar. Close actions: "close" or "shutdown_apps".
STATUS_BAR_HEIGHT="${WEISAIR_STATUS_BAR_HEIGHT:-20}"
STATUS_BAR_SCREEN="${WEISAIR_STATUS_BAR_SCREEN:-0}"
STATUS_BAR_HOVER_WIDTH="${WEISAIR_STATUS_BAR_HOVER_WIDTH:-100}"
STATUS_BAR_CLOSE_ACTION="${WEISAIR_STATUS_BAR_CLOSE_ACTION:-shutdown_apps}" 
SIMBRIEF_SCRIPT="/home/stephan/X-Plane-12-Assets/tools/SimbriefPyDownloader/SimBriefPyDownloader/SimBriefPyDownloader.py"
XPLANE_EXECUTABLE="/home/stephan/X-Plane 12/X-Plane-x86_64"
DEBRIEF_SCRIPT="${SCRIPT_DIR}/../LinuxXPDebrief/WeisAir_XP12_Debrief.sh"
XPLANE_ISO="/mnt/B87AB6F57AB6AF8C/XPLANE12_DVD1.ISO"
XPLANE_MOUNT_POINT="/mnt/iso/xp12"
STATUS_LOG="${SCRIPT_DIR}/WeisAir_XP12_Launcher_status.log"
APPLICATION_OUTPUT_LOG="${SCRIPT_DIR}/WeisAir_XP12_Launcher_applications.log"
STATUS_STATE_FILE=""
LAUNCHED_PROCESS_PID=""
DEBRIEF_WATCHER_PID=""
SIMBRIEF_PID=""
LITTLENAVMAP_PID=""
LAUNCHER_FINISHED=0

FAILURES=0
declare -A COMPONENT_STATES=(
    [usb]="not_started"
    [udp_logger]="not_started"
    [littlenavmap]="not_started"
    [debrief]="not_started"
    [xplane]="not_started"
)

log_status() {
    printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" | tee -a "$STATUS_LOG"
}

record_failure() {
    log_status "FAILED: $*"
    FAILURES=$((FAILURES + 1))
}

finish_status_bar() {
    if [[ "$STATUS_BAR_ENABLED" == 1 && -n "$STATUS_STATE_FILE" ]]; then
        LAUNCHER_FINISHED=1
        write_component_states
    fi
}

write_component_states() {
    [[ -n "$STATUS_STATE_FILE" && -e "$STATUS_STATE_FILE" ]] || return 0

    local temporary_file="${STATUS_STATE_FILE}.tmp.$$"
    if ! {
        printf 'usb=%s\n' "${COMPONENT_STATES[usb]}"
        printf 'udp_logger=%s\n' "${COMPONENT_STATES[udp_logger]}"
        printf 'littlenavmap=%s\n' "${COMPONENT_STATES[littlenavmap]}"
        printf 'debrief=%s\n' "${COMPONENT_STATES[debrief]}"
        printf 'xplane=%s\n' "${COMPONENT_STATES[xplane]}"
        printf 'debrief_pid=%s\n' "$DEBRIEF_WATCHER_PID"
        printf 'simbrief_pid=%s\n' "$SIMBRIEF_PID"
        printf 'littlenavmap_pid=%s\n' "$LITTLENAVMAP_PID"
        printf 'launcher_finished=%s\n' "$LAUNCHER_FINISHED"
    } >"$temporary_file" || ! mv -f -- "$temporary_file" "$STATUS_STATE_FILE"; then
        rm -f -- "$temporary_file"
        log_status "ERROR: unable to update launcher status bar state"
        return 1
    fi
}

set_component_state() {
    local component="$1"
    local state="$2"

    [[ "$STATUS_BAR_ENABLED" == 1 ]] || return 0
    COMPONENT_STATES["$component"]="$state"
    write_component_states
}

start_status_bar() {
    if ! command -v -- "$PYTHON_EXECUTABLE" >/dev/null 2>&1; then
        record_failure "Python executable was not found: $PYTHON_EXECUTABLE"
        return 1
    fi

    STATUS_STATE_FILE="$(mktemp "${TMPDIR:-/tmp}/weisair-xplauncher.XXXXXX")" || {
        record_failure "Unable to create launcher status bar state file"
        return 1
    }
    if ! write_component_states; then
        rm -f -- "$STATUS_STATE_FILE"
        return 1
    fi

    (exec setsid --wait nohup "$PYTHON_EXECUTABLE" "$STATUS_BAR_SCRIPT" \
        --height "$STATUS_BAR_HEIGHT" \
        --screen "$STATUS_BAR_SCREEN" \
        --hover-width "$STATUS_BAR_HOVER_WIDTH" \
        --close-action "$STATUS_BAR_CLOSE_ACTION" \
        --state-file "$STATUS_STATE_FILE" \
        --csv-file "$UDP_LOG_CSV") >>"$APPLICATION_OUTPUT_LOG" 2>&1 &
    local process_id=$!
    sleep 1
    local process_state
    process_state="$(ps -o stat= -p "$process_id" 2>/dev/null || true)"
    if [[ -n "$process_state" && "$process_state" != Z* ]]; then
        log_status "Launcher status bar started (PID $process_id)"
        return 0
    fi

    local result=0
    wait "$process_id" || result=$?
    rm -f -- "$STATUS_STATE_FILE"
    record_failure "Launcher status bar exited during startup with status $result"
    return 1
}

run_usb_check() {
    if [[ ! -f "$USB_CHECK_SCRIPT" || ! -x "$USB_CHECK_SCRIPT" ]]; then
        set_component_state usb failed
        record_failure "USB check script is missing or not executable: $USB_CHECK_SCRIPT"
        return 1
    fi

    log_status "Running USB device check: $USB_CHECK_SCRIPT"
    WEISAIR_STATUS_BAR_ENABLED="$STATUS_BAR_ENABLED" \
        "$USB_CHECK_SCRIPT" 2>&1 | tee -a "$STATUS_LOG"
    local result=${PIPESTATUS[0]}
    if (( result == 0 )); then
        set_component_state usb passed
        log_status "USB device check completed successfully"
        return 0
    elif (( result == 2 )); then
        set_component_state usb failed
        log_status "USB device check cancelled by user"
        return 2
    elif (( result == 3 )); then
        set_component_state usb failed
        log_status "USB device check ignored by user"
        return 3
    else
        set_component_state usb failed
        record_failure "USB device check exited with status $result"
        return 1
    fi
}

launch_background() {
    local label="$1"
    local working_directory="$2"
    shift 2
    LAUNCHED_PROCESS_PID=""

    if [[ ! -d "$working_directory" ]]; then
        record_failure "$label working directory does not exist: $working_directory"
        return 1
    fi

    if ! command -v -- "$1" >/dev/null 2>&1; then
        record_failure "$label command was not found: $1"
        return 1
    fi

    log_status "Starting $label"
    (cd -- "$working_directory" && exec setsid --wait nohup "$@") >>"$APPLICATION_OUTPUT_LOG" 2>&1 &
    local process_id=$!
    sleep 3
    local process_state
    process_state="$(ps -o stat= -p "$process_id" 2>/dev/null || true)"
    if [[ -n "$process_state" && "$process_state" != Z* ]]; then
        LAUNCHED_PROCESS_PID="$process_id"
        log_status "$label started successfully (PID $process_id)"
        return 0
    else
        local result=0
        wait "$process_id" || result=$?
        record_failure "$label exited during startup with status $result"
        return 1
    fi
}

launch_native_application() {
    local label="$1"
    local executable="$2"

    if [[ ! -x "$executable" ]]; then
        record_failure "$label is missing or not executable: $executable"
        return 1
    fi

    launch_background "$label" "$(dirname -- "$executable")" "$executable"
}

launch_debrief_watcher() {
    if [[ ! -f "$DEBRIEF_SCRIPT" || ! -r "$DEBRIEF_SCRIPT" ]]; then
        record_failure "X-Plane debrief watcher script is missing or unreadable: $DEBRIEF_SCRIPT"
        return 1
    fi

    if launch_background "X-Plane debrief watcher" "$(dirname -- "$DEBRIEF_SCRIPT")" \
        bash "$DEBRIEF_SCRIPT"; then
        DEBRIEF_WATCHER_PID="$LAUNCHED_PROCESS_PID"
        write_component_states
        return 0
    fi
    return 1
}

launch_littlenavmap() {
    if [[ ! -x "$LITTLENAVMAP_EXECUTABLE" ]]; then
        record_failure "Little Navmap is missing or not executable: $LITTLENAVMAP_EXECUTABLE"
        return 1
    fi

    launch_background "Little Navmap" "$(dirname -- "$LITTLENAVMAP_EXECUTABLE")" \
        env -u XDG_CURRENT_DESKTOP -u DESKTOP_SESSION -u GNOME_DESKTOP_SESSION_ID \
        QT_QPA_PLATFORM=xcb "$LITTLENAVMAP_EXECUTABLE"
}

launch_python_script() {
    local label="$1"
    local script="$2"

    if [[ ! -f "$script" ]]; then
        record_failure "$label script does not exist: $script"
        return 1
    fi

    launch_background "$label" "$(dirname -- "$script")" "$PYTHON_EXECUTABLE" "$script"
}

run_airac_downloader() {
    if [[ ! -f "$AIRAC_DOWNLOADER_SCRIPT" || ! -r "$AIRAC_DOWNLOADER_SCRIPT" ]]; then
        record_failure "AIRAC downloader script is missing or unreadable: $AIRAC_DOWNLOADER_SCRIPT"
        return 1
    fi

    log_status "Running AIRAC downloader before SimBrief PyDownloader"
    (
        cd -- "$(dirname -- "$AIRAC_DOWNLOADER_SCRIPT")" &&
            bash "$(basename -- "$AIRAC_DOWNLOADER_SCRIPT")"
    ) 2>&1 | tee -a "$STATUS_LOG"
    local result=${PIPESTATUS[0]}
    if (( result == 0 )); then
        log_status "AIRAC downloads completed successfully"
        return 0
    fi

    record_failure "AIRAC downloader exited with status $result"
    return 1
}

ensure_xplane_iso_mounted() {
    if ! command -v mountpoint >/dev/null 2>&1; then
        record_failure "mountpoint command was not found"
        return 1
    fi

    if mountpoint -q -- "$XPLANE_MOUNT_POINT"; then
        log_status "X-Plane ISO is already mounted at $XPLANE_MOUNT_POINT"
        return 0
    fi

    log_status "Mounting X-Plane ISO at $XPLANE_MOUNT_POINT"
    if sudo mount -o loop "$XPLANE_ISO" "$XPLANE_MOUNT_POINT"; then
        if mountpoint -q -- "$XPLANE_MOUNT_POINT"; then
            log_status "X-Plane ISO mounted successfully"
            return 0
        fi

        record_failure "Mount command succeeded but $XPLANE_MOUNT_POINT is not mounted"
        return 1
    fi

    record_failure "Failed to mount X-Plane ISO: $XPLANE_ISO"
    return 1
}

if ! touch "$STATUS_LOG"; then
    printf 'Cannot write status log: %s\n' "$STATUS_LOG" >&2
    exit 1
fi

if [[ "$STATUS_BAR_ENABLED" != 0 && "$STATUS_BAR_ENABLED" != 1 ]]; then
    printf 'WEISAIR_STATUS_BAR must be 0 or 1\n' >&2
    exit 2
fi
if [[ "$STATUS_BAR_CLOSE_ACTION" != close &&
      "$STATUS_BAR_CLOSE_ACTION" != shutdown_apps ]]; then
    printf 'WEISAIR_STATUS_BAR_CLOSE_ACTION must be close or shutdown_apps\n' >&2
    exit 2
fi

log_status "===== WeisAir X-Plane 12 launcher started ====="
if [[ "$STATUS_BAR_ENABLED" == 1 ]]; then
    start_status_bar
    if [[ -n "$STATUS_STATE_FILE" && -e "$STATUS_STATE_FILE" ]]; then
        trap finish_status_bar EXIT
    fi
fi
run_usb_check
usb_check_result=$?
if (( usb_check_result == 2 )); then
    log_status "Launcher cancelled by user during USB device check"
    exit 0
elif (( usb_check_result == 1 )); then
    log_status "Launcher stopped because the USB device check did not complete"
    exit 1
fi

if launch_python_script "X-Plane UDP data logger" "$UDP_LOGGER_SCRIPT"; then
    set_component_state udp_logger started
else
    set_component_state udp_logger failed
fi
run_airac_downloader
if launch_python_script "SimBrief PyDownloader" "$SIMBRIEF_SCRIPT"; then
    SIMBRIEF_PID="$LAUNCHED_PROCESS_PID"
    write_component_states
fi
if ensure_xplane_iso_mounted; then
    if launch_native_application "X-Plane 12" "$XPLANE_EXECUTABLE"; then
        set_component_state xplane started
        if launch_debrief_watcher; then
            set_component_state debrief started
        else
            set_component_state debrief failed
        fi
    else
        set_component_state xplane failed
    fi
else
    set_component_state xplane failed
fi
if launch_littlenavmap; then
    LITTLENAVMAP_PID="$LAUNCHED_PROCESS_PID"
    write_component_states
    set_component_state littlenavmap started
else
    set_component_state littlenavmap failed
fi

if (( FAILURES == 0 )); then
    log_status "All launcher steps completed successfully"
    exit 0
fi

log_status "Launcher completed with $FAILURES failed step(s)"
exit 1
