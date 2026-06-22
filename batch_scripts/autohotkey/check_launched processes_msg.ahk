#Requires AutoHotkey v2.0
#SingleInstance Force

; 1. Define the list of processes to check
processList := ["Companion.exe", "SimBrief Downloader.exe", "NavigraphSimlink.exe"]

; 2. Run the check
CheckProcesses(processList)

CheckProcesses(apps) {
    runningApps := ""
    missingApps := ""
    
    for app in apps {
        ; ProcessExist returns the PID if running, or 0 if not
        if ProcessExist(app) {
            runningApps .= "• " . app . "`n"
        } else {
            missingApps .= "• " . app . "`n"
        }
    }
    
    ; 3. Build and display the result message
    resultMessage := ""
    if (runningApps != "") {
        resultMessage .= "RUNNING:`n" . runningApps . "`n"
    }
    if (missingApps != "") {
        resultMessage .= "NOT RUNNING:`n" . missingApps
    }
    
    MsgBox(resultMessage, "Process Status Checker", 64)
}
