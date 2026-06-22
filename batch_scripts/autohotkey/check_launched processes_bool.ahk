#Requires AutoHotkey v2.0
#SingleInstance Force

; Define your target processes as keys, and their friendly names as values.
TargetProcesses := Map(
    "Companion.exe", "Bitfocus Companion",
    "SimBrief Downloader.exe",  "SimBrief Downloader",
    "NavigraphSimlink.exe", "Navigraph SimLink"
)

; Exit with the final result (1 if all are running, 0 if any are missing)
ExitApp(CheckProcesses(TargetProcesses))


/**
 * Checks if all specified processes are currently running.
 * Alerts the user with friendly names and process names if any are missing.
 * @param {Map} processMap - Map of process names (keys) and friendly names (values).
 * @return {Integer} 1 if all processes are running, 0 if any process is missing.
 */
CheckProcesses(processMap) {
    missingApps := ""
    
    for processName, friendlyName in processMap {
        ; ProcessExist returns the PID if running, or 0 if not
        if !ProcessExist(processName) {
            ; Formats as: • Friendly Name (notepad.exe)
            missingApps .= "• " . friendlyName . " (" . processName . ")`n"
        }
    }
    
    ; If any processes are missing, show a message box and return 0
    if (missingApps != "") {
        MsgBox("The following processes are not running:`n`n" . missingApps, "Process Status Error", 48)
        return 0
    }
    
    return 1 ; All processes are running
}
