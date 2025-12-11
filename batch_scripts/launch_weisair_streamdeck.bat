@ECHO OFF

rem stop streamdeck default application
rem find instances running the streamdeck python stuff (python.exe + cmd.exe)@taskkill /f /im Python.exe >nul
@taskkill /f /im StreamDeck.exe >nul


rem identify aircraftfile to be launched and modify files so that the right profile is selected

rem start streamdeck python app
cd "G:\X-Plane 12\3rdParty\streamdeck\xplane-streamdeck-1.4.0"
python .\start.py



rem @echo off
rem @taskkill /f /im StreamDeck.exe >nul
rem @timeout /t 3 /nobreak >nul
rem @start C:\"Program Files"\Elgato\StreamDeck\StreamDeck.exe --runinbk >nul
rem :exit 0