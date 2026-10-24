#!/bin/bash

# Definition der USB-Geräte (Format: "VID:PID" -> "Anzeigename")
declare -A TARGET_DEVICES
TARGET_DEVICES=(
    ["06a3:0c2d"]="Throttle Quadrant (Left/Right)"
    ["1690:fe13"]="WeisAir Switch Panel"
    ["05e3:0626"]="Saitek Rudder Pedals"
    ["294b:1900"]="Honeycomb Alpha Yoke"
)

# Liste für fehlende Geräte
MISSING_DEVICES=""
ALL_CONNECTED=1

echo "Check connectivity of USB Devices..."

# Schleife durch alle definierten Geräte
for ID in "${!TARGET_DEVICES[@]}"; do
    NAME="${TARGET_DEVICES[$ID]}"
    
    # lsusb sucht nach der ID (Kleinbuchstaben erzwingen)
    if ! lsusb -d "${ID,,}" > /dev/null 2>&1; then
        MISSING_DEVICES="${MISSING_DEVICES}• ${NAME}\n  [ID: ${ID^^}]\n\n"
        ALL_CONNECTED=0
    fi
done

# Wenn Geräte fehlen, eine grafische Warnung anzeigen
if [ $ALL_CONNECTED -eq 0 ]; then
    ERROR_MSG="The following USB Devices are not connected:\n\n${MISSING_DEVICES}"
    ERROR_TEXT="$(printf '%b' "$ERROR_MSG")"
    
    if [ -n "$DISPLAY" ] && command -v xmessage &> /dev/null; then
        xmessage -title "USB device connection test failed" -center -buttons OK:0 "$ERROR_TEXT"
    else
        printf "\e[1;31mERROR: USB device connection test failed\e[0m\n\n%s\n" "$ERROR_TEXT"
    fi
    exit 1
fi

echo "All relevant USB devices are connected, ready to start X-Plane 12..."
exit 0
