#Requires AutoHotkey v2.0
#SingleInstance Force

; Configuration
RemoteIP := "192.168.2.112"
RemotePort := "9090"
CheckInterval := 5000 ; Check every 5 seconds (in milliseconds)
WindowName := "WebFMC Pro v2.3.4 — Mozilla Firefox"
MaxRetries := 2      ; Maximum number of attempts allowed
RetryCount := 0


;The script does the following
;check if FMC browser window is already open
;   true: just focus it and refresh it
;   false: do not simply launch firefox but rather check first if the server port is already available
;       true: launch and position the WebFMC client
;       false: retry for MaxRetries and exit the script if the limit is reached


; URL is already open, do nothing
if WinExist(WindowName) {

    WinMoveTop WindowName
    Send "{F5}"
    ExitApp()

} else {
    
    Loop {
        RetryCount++
        if IsPortOpen(RemoteIP, RemotePort) {
            Run("firefox.exe --new-window http://192.168.2.112:9090/")
            WinWait "ahk_exe firefox.exe"
            sleep 5000
            WinMove 0, 0, 1775, 1017, "WebFMC Pro v2.3.4 — Mozilla Firefox"
            Send "{F11}"
            ExitApp ; Stops the script after launching Notepad
        }

        ; Check if maximum retries reached
        if (RetryCount >= MaxRetries) {
        MsgBox("WebFMC (Port " RemotePort " on " RemoteIP ") did not become available after " MaxRetries " attempts. Script stopping.", "Timeout Error", 16)
        ExitApp
    }
        Sleep(CheckInterval)
    }
}

; Function to check if a remote TCP port is open
IsPortOpen(ip, port) {
    shell := ComObject("WScript.Shell")

    ; Runs PowerShell hidden and checks the connection
    cmd := "powershell.exe -NoProfile -Command `"(Test-NetConnection " ip " -Port " port ").TcpTestSucceeded`""
    exec := shell.Exec(cmd)
    output := exec.StdOut.ReadAll()
    
    return InStr(output, "True") ? true : false
}
