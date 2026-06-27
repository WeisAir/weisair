;WinMoveTop "WebFMC Pro v2.3.4 — Mozilla Firefox"
;Send "{F5}"

;runscript "check_for_webfmcexe_running"
;if script_result = 1 then do
    ;if WebFMC Pro v2.3.4 — Mozilla Firefox is running
    ;then do
        ;WinMoveTop "WebFMC Pro v2.3.4 — Mozilla Firefox"
        ;Send "{F5}"
    ;else
        ;runscript efb_launch_and_position_browser_fmc.ahk
;if script_result = 0 then do nothing

#Requires AutoHotkey v2.0
#SingleInstance Force

; check if WebFMC server is running on remote PC
WebFMC_is_running := RunWait('G:\weisair\batch_scripts\autohotkey\check_launched_webfmc_bool.ahk')

    ; if the webfmc server is running, check if the firefox window is opened
    if (WebFMC_is_running == 1) {
        
        ;if the window is opened, bring it to the front and refresh it
        if (WebFMCFirefoxWindowIsOpened == 1){
        
            WinMoveTop "WebFMC Pro v2.3.4 — Mozilla Firefox"
            Send "{F5}"
        }
        
        ;if the window is not opened, launch it and position it
        if (WebFMCFirefoxWindowIsOpened == 0){
        
            Run("firefox.exe --new-window http://192.168.2.112:9090/")
            WinWait "ahk_exe firefox.exe"
            sleep 5000
            WinMove 0, 0, 1775, 1017, "WebFMC Pro v2.3.4 — Mozilla Firefox"
            Send "{F11}"
        } 
    }