#Requires AutoHotkey v2.0
#SingleInstance Force

; Define your full target USB Device IDs including instance paths.
; Backslashes must be escaped with another backslash in AutoHotkey strings.
TargetIDs := [
    "VID_06A3&PID_0C2D\\9&1d94182f&0&1", ; Left Throttle Quadrant
    "VID_06A3&PID_0C2D\\9&1d94182f&0&2", ; Right Throttle Quadrant
    "VID_1690&PID_FE13", ; WeisAir Switch Panel
    "VID_05E3&PID_0626", ; Rudder Pedals
    "VID_294B&PID_1900" ; Alpha Yoke
]

; Run the check
Results := CheckUsbIDs(TargetIDs)

; Display the results
Report := "USB Device ID Status:`n`n"
for DeviceID, Connected in Results {
    Status := Connected ? "CONNECTED" : "NOT FOUND"
    ; Replace escaped backslashes back to single for the report display
    DisplayID := StrReplace(DeviceID, "\\", "\")
    Report .= DisplayID " -> " Status "`n"
}
MsgBox(Report, "USB ID Checker")


/**
 * Checks if specific USB Device IDs or Instance Paths are currently connected.
 * @param {Array} idList - Array of hardware ID/Instance strings to search for.
 * @return {Map} A map with IDs as keys and booleans as values.
 */
CheckUsbIDs(idList) {
    Results := Map()
    
    ; Initialize all status entries to false
    for deviceID in idList {
        Results[deviceID] := false
    }
    
    ; Connect to WMI service to query Plug and Play devices
    wmi := ComObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
    query := wmi.ExecQuery("SELECT DeviceID FROM Win32_PnPEntity WHERE DeviceID LIKE 'USB%'")
    
    ; Loop through all active USB hardware devices
    for objDevice in query {
        if !objDevice.DeviceID
            continue
            
        ; Check if the current hardware ID matches any item in our target list
        for deviceID in idList {
            ; Unescape backslashes for the comparison function
            CleanID := StrReplace(deviceID, "\\", "\")
            if InStr(objDevice.DeviceID, CleanID) {
                Results[deviceID] := true
            }
        }
    }
    
    return Results
}
