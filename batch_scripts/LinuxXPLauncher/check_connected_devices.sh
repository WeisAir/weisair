#!/bin/bash

# Definition der USB-Geräte (Format: "VID:PID" -> "Anzeigename")
declare -A TARGET_DEVICES
TARGET_DEVICES=(
    ["06a3:0c2d"]="Throttle Quadrant (Left/Right)"
    ["1690:fe13"]="WeisAir Switch Panel"
    ["05e3:0626"]="Saitek Rudder Pedals"
    ["294b:1900"]="Honeycomb Alpha Yoke"
)
declare -A REQUIRED_COUNTS=(["06a3:0c2d"]=2)

echo "Check connectivity of USB Devices..."

while true; do
    MISSING_DEVICES=""
    ALL_CONNECTED=1

    for ID in "${!TARGET_DEVICES[@]}"; do
        NAME="${TARGET_DEVICES[$ID]}"
        REQUIRED_COUNT="${REQUIRED_COUNTS[$ID]:-1}"
        DEVICE_COUNT="$(lsusb -d "${ID,,}" 2>/dev/null | awk 'NF { count++ } END { print count+0 }')"

        if (( DEVICE_COUNT < REQUIRED_COUNT )); then
            MISSING_DEVICES="${MISSING_DEVICES}• ${NAME} (${DEVICE_COUNT}/${REQUIRED_COUNT} connected)\n  [ID: ${ID^^}]\n\n"
            ALL_CONNECTED=0
        fi
    done

    if [ "$ALL_CONNECTED" -eq 1 ]; then
        echo "All relevant USB devices are connected, ready to start X-Plane 12..."
        exit 0
    fi

    ERROR_MSG="The following USB Devices are not connected:\n\n${MISSING_DEVICES}"
    ERROR_TEXT="$(printf '%b' "$ERROR_MSG")"

    if [ -n "$DISPLAY" ] && command -v xmessage &> /dev/null; then
        xmessage -title "USB device connection test failed" -center \
            -buttons "Retry:0,Cancel:1,Ignore:2" -default Retry "$ERROR_TEXT"
        choice=$?

        case "$choice" in
            0) continue ;;
            1) exit 2 ;;
            2) echo "USB device check ignored by user."; exit 0 ;;
            *) exit 2 ;;
        esac
    fi

    printf "\e[1;31mERROR: USB device connection test failed\e[0m\n\n%s\n" "$ERROR_TEXT"
    exit 1
done
