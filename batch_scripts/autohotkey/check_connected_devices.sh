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

echo "Überprüfe USB-Geräte..."

# Schleife durch alle definierten Geräte
for ID in "${!TARGET_DEVICES[@]}"; do
    NAME="${TARGET_DEVICES[$ID]}"
    
    # lsusb sucht nach der ID (Kleinbuchstaben erzwingen)
    if ! lsusb -d "${ID,,}" > /dev/null 2>&1; then
        MISSING_DEVICES="${MISSING_DEVICES}• ${NAME}\n  [ID: ${ID^^}]\n\n"
        ALL_CONNECTED=0
    fi
done

# Wenn Geräte fehlen, grafische Warnung anzeigen (falls zenity installiert ist)
if [ $ALL_CONNECTED -eq 0 ]; then
    ERROR_MSG="Die folgenden USB-Geräte fehlen:\n\n${MISSING_DEVICES}"
    
    # Prüfen, ob eine Benutzeroberfläche und 'zenity' verfügbar sind
    if [ -n "$DISPLAY" ] && command -v zenity &> /dev/null; then
        zenity --error --title="USB Verbindungsfehler" --text="$(printf "$ERROR_MSG")" --width=400
    else
        # Fallback für das Terminal
        printf "\e[1;31mERROR: USB Verbindungsfehler\e[0m\n\n$ERROR_MSG"
    fi
    exit 0
fi

echo "Alle Geräte verbunden! Starte X-Plane 12..."
exit 1
