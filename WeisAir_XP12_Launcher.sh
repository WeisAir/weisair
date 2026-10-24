#!/usr/bin/env bash

# Configurable application paths and commands.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
USB_CHECK_SCRIPT="${SCRIPT_DIR}/check_usb_devices.sh"
LITTLENAVMAP_EXECUTABLE="/home/stephan/X-Plane-12-Assets/tools/LittleNavmap-linux-ubuntu-24.04-3.0.18/littlenavmap"
UDP_LOGGER_SCRIPT="${SCRIPT_DIR}/xplane_udp_csv.py"
PYTHON_EXECUTABLE="python3"
SIMBRIEF_SCRIPT="/home/stephan/X-Plane-12-Assets/tools/SimbriefPyDownloader/SimBriefPyDownloader/SimBriefPyDownloader.py"
XPLANE_EXECUTABLE="/home/stephan/X-Plane 12/X-Plane-x86_64"
STATUS_LOG="${SCRIPT_DIR}/WeisAir_XP12_Launcher_status.log"
APPLICATION_OUTPUT_LOG="${SCRIPT_DIR}/WeisAir_XP12_Launcher_applications.log"

FAILURES=0

log_status() {
    printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" | tee -a "$STATUS_LOG"
}

record_failure() {
    log_status "FAILED: $*"
    FAILURES=$((FAILURES + 1))
}

run_usb_check() {
    if [[ ! -f "$USB_CHECK_SCRIPT" || ! -x "$USB_CHECK_SCRIPT" ]]; then
        record_failure "USB check script is missing or not executable: $USB_CHECK_SCRIPT"
        return
    fi

    log_status "Running USB device check: $USB_CHECK_SCRIPT"
    "$USB_CHECK_SCRIPT" 2>&1 | tee -a "$STATUS_LOG"
    local result=${PIPESTATUS[0]}
    if (( result == 0 )); then
        log_status "USB device check completed successfully"
    else
        record_failure "USB device check exited with status $result"
    fi
}

launch_background() {
    local label="$1"
    local working_directory="$2"
    shift 2

    if [[ ! -d "$working_directory" ]]; then
        record_failure "$label working directory does not exist: $working_directory"
        return
    fi

    if ! command -v -- "$1" >/dev/null 2>&1; then
        record_failure "$label command was not found: $1"
        return
    fi

    log_status "Starting $label"
    (cd -- "$working_directory" && exec nohup "$@") >>"$APPLICATION_OUTPUT_LOG" 2>&1 &
    local process_id=$!
    sleep 3
    local process_state
    process_state="$(ps -o stat= -p "$process_id" 2>/dev/null || true)"
    if [[ -n "$process_state" && "$process_state" != Z* ]]; then
        log_status "$label started successfully (PID $process_id)"
    else
        local result=0
        wait "$process_id" || result=$?
        record_failure "$label exited during startup with status $result"
    fi
}

launch_native_application() {
    local label="$1"
    local executable="$2"

    if [[ ! -x "$executable" ]]; then
        record_failure "$label is missing or not executable: $executable"
        return
    fi

    launch_background "$label" "$(dirname -- "$executable")" "$executable"
}

launch_littlenavmap() {
    if [[ ! -x "$LITTLENAVMAP_EXECUTABLE" ]]; then
        record_failure "Little Navmap is missing or not executable: $LITTLENAVMAP_EXECUTABLE"
        return
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
        return
    fi

    launch_background "$label" "$(dirname -- "$script")" "$PYTHON_EXECUTABLE" "$script"
}

if ! touch "$STATUS_LOG"; then
    printf 'Cannot write status log: %s\n' "$STATUS_LOG" >&2
    exit 1
fi

log_status "===== WeisAir X-Plane 12 launcher started ====="
run_usb_check
launch_python_script "X-Plane UDP data logger" "$UDP_LOGGER_SCRIPT"
launch_python_script "SimBrief PyDownloader" "$SIMBRIEF_SCRIPT"
launch_native_application "X-Plane 12" "$XPLANE_EXECUTABLE"
launch_littlenavmap

if (( FAILURES == 0 )); then
    log_status "All launcher steps completed successfully"
    exit 0
fi

log_status "Launcher completed with $FAILURES failed step(s)"
exit 1
