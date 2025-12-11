@echo off

REM copy x-plane_install directories
REM ---------------------------------
copy "x-plane_install_12.txt" "C:\Users\Pilot\AppData\Local\"

REM copy WeisAir streamdeck icon library
REM ------------------------------------

REM generic
if not exist "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_generic" mkdir "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_generic"
copy "streamdeck_icons\weisair_generic\*" "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_generic"

if not exist "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_generic" mkdir "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_generic"
copy "streamdeck_icons\weisair_generic\*" "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_generic"

REM 737
if not exist "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_737" mkdir "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_737"
copy "streamdeck_icons\weisair_737\*" "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_737"

if not exist "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_737" mkdir "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_737"
copy "streamdeck_icons\weisair_737\*" "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_737"

REM 747
if not exist "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_747" mkdir "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_747"
copy "streamdeck_icons\weisair_747\*" "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_747"

if not exist "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_747" mkdir "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_747"
copy "streamdeck_icons\weisair_747\*" "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_747"

REM S340A
if not exist "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_s340a" mkdir "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_s340a"
copy "streamdeck_icons\weisair_s340a\*" "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_s340a"

if not exist "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_s340a" mkdir "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_s340a"
copy "streamdeck_icons\weisair_s340a\*" "C:\Users\Pilot\AppData\Roaming\Elgato\StreamDeck\Plugins\com.extension.pilotsdeck.sdPlugin\Images\weisair_s340a"