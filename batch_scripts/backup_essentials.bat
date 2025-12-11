@echo off

REM X-CAMERA Profiles

if not exist "G:\weisair\configs\x-camera" mkdir "G:\weisair\configs\x-camera"
for /R "G:\junctions\Aircraft" %%x in (X-Camera_*.csv) do copy "%%x" "G:\weisair\configs\x-camera" /Y

REM XPlane Preferences

if not exist "G:\weisair\configs\preferences" mkdir "G:\weisair\configs\preferences"
if not exist "G:\weisair\configs\preferences\control profiles" mkdir "G:\weisair\configs\preferences\control profiles"
copy "G:\junctions\preferences\*.prf" "G:\weisair\configs\preferences\"
copy "G:\junctions\preferences\control profiles\*.*" "G:\weisair\configs\preferences\control profiles\"

REM FlywithLua Scripts

if not exist "G:\weisair\configs\flywithlua_scripts" mkdir "G:\weisair\configs\flywithlua_scripts"
if not exist "G:\weisair\configs\flywithlua_scripts\weisair_scripts" mkdir "G:\weisair\configs\flywithlua_scripts\weisair_scripts"
if not exist "G:\weisair\configs\flywithlua_scripts\arcaze_scripts" mkdir "G:\weisair\configs\flywithlua_scripts\arcaze_scripts"
copy "G:\junctions\Scripts\*.lua" "G:\weisair\configs\flywithlua_scripts\"
copy "G:\junctions\Scripts\weisair_scripts\*.lua" "G:\weisair\configs\flywithlua_scripts\weisair_scripts"
copy "G:\junctions\Scripts\arcaze_scripts\*.config" "G:\weisair\configs\flywithlua_scripts\arcaze_scripts"

REM Simhaptic Profiles

if not exist "G:\weisair\configs\simhaptic\Profiles" mkdir "G:\weisair\configs\simhaptic\Profiles"
copy "G:\weisair\tools\SimHaptic\Data\Profiles\*.json" "G:\weisair\configs\simhaptic\Profiles\"


rem XOrganizer?
rem XToolbox
rem airmanager									done
rem fms_datamanager mapping via hard link		done (manual)


