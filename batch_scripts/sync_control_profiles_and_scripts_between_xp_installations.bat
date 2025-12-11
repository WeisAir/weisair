@echo off

REM XPlane Preferences

copy "G:\X-Plane 12\Output\preferences\*.prf" "G:\ConfigBackups\preferences\"
copy "G:\X-Plane 12\Output\preferences\control profiles\*.*" "G:\X-Plane 12 Test\Output\preferences\control profiles\"

REM FlywithLua Scripts

copy "G:\X-Plane 12\Resources\plugins\FlyWithLua\Scripts\*.lua" "G:\X-Plane 12 Test\Resources\plugins\FlyWithLua\Scripts\"
copy "G:\X-Plane 12\Resources\plugins\FlyWithLua\Scripts\weisair_scripts\*.lua" "G:\X-Plane 12 Test\Resources\plugins\FlyWithLua\Scripts\weisair_scripts\"
copy "G:\X-Plane 12\Resources\plugins\FlyWithLua\Scripts\arcaze_scripts\*.config" "G:\X-Plane 12 Test\Resources\plugins\FlyWithLua\Scripts\arcaze_scripts\"