#Requires AutoHotkey v2.0
#SingleInstance Force

; --- CONFIGURATION ---
TargetURL := "google.com"
BrowserPath := "C:\Program Files\Mozilla Firefox\firefox.exe"
CheckInterval := 5000 ; Time between pings in milliseconds (5 seconds)
; ---------------------

SetTimer(CheckConnection, CheckInterval)

CheckConnection() {
    if Ping(TargetURL) {
        Run(BrowserPath)
        ExitApp() ; Stops the script after launching Firefox
    }
}

Ping(URL) {
    ; Runs the system ping command hidden and captures the result
    Shell := ComObject("WScript.Shell")
    Exec := Shell.Exec(A_ComSpec " /c ping -n 1 " URL)
    Result := Exec.StdOut.ReadAll()
    
    ; Returns true if the output contains "TTL=" (successful response)
    return InStr(Result, "TTL=") ? true : false
}
