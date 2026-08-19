@echo off
setlocal enabledelayedexpansion

:: ==========================================
:: CONFIGURATION SECTION
:: ==========================================
set "THRESHOLD=10"
set "POLLING_INTERVAL=5"
set "TIME_FRAME_SEC=10"
:: ==========================================

:: Calculate how many samples we need to collect based on the time frame and interval
set /a "SAMPLES=%TIME_FRAME_SEC% / %POLLING_INTERVAL%"
if !SAMPLES! LSS 1 set "SAMPLES=1"

:: Initialize an array to keep track of historical CPU loads
for /l %%i in (1,1,%SAMPLES%) do set "LOAD_%%i=0"
set "INDEX=1"
set "INITIALIZED=0"

:CheckCPU
:: Fetch the current instantaneous CPU load using PowerShell
for /f %%a in ('powershell -NoProfile -Command "$cpu = (Get-CimInstance Win32_Processor | Measure-Object -Property LoadPercentage -Average).Average; if(-not $cpu){$cpu=0}; [math]::Round($cpu)"') do set "CURRENT_LOAD=%%a"

:: Store the current load in our rolling array
set "LOAD_!INDEX!=%CURRENT_LOAD%"

:: Calculate the current historical average
set "SUM=0"
for /l %%i in (1,1,%SAMPLES%) do (
    set /a "SUM+=LOAD_%%i"
)
set /a "AVG_LOAD=%SUM% / %SAMPLES%"

:: Track if we have collected enough samples to match the requested time frame
if %INITIALIZED% EQU 0 (
    if !INDEX! EQU %SAMPLES% (
        set "INITIALIZED=1"
    )
)

:: If the rolling buffer is fully initialized, start checking the threshold
if %INITIALIZED% EQU 1 (
    if %AVG_LOAD% LSS %THRESHOLD% (
        goto ShowMsg
    )
)

:: Increment our rolling index pointer
set /a "INDEX+=1"
if !INDEX! GTR %SAMPLES% set "INDEX=1"

:: Wait for the user-defined polling interval before checking again
timeout /t %POLLING_INTERVAL% /nobreak >nul
goto CheckCPU

:ShowMsg
:: Displays the GUI alert when the system has reached the idle state
powershell -NoProfile -Command "Add-Type -AssemblyName PresentationFramework; [System.Windows.MessageBox]::Show('System in idle state - ready to start EFB', 'Status')"
exit
