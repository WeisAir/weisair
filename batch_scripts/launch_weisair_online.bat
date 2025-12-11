@ECHO OFF

rem check if Arcaze modules are available

cd G:\
cd "G:\X-Plane 12\3rdParty\xp_weisair_launcher"
UsbTreeView.exe -R=usb_report.txt
find "EFIS" usb_report.txt

if errorlevel 1 goto hardware_not_found
msg %username% WeisAir Hardware found! Blue Skies, Captain!
"G:\X-Plane 12\3rdParty\xOrganizer\xOrganizer.exe" quickstart 2 2 "None" 0 0
goto remove_usb_report

:hardware_not_found
msg %username% Please power the panel and try again, Captain!

:remove_usb_report
del usb_report.txt
exit