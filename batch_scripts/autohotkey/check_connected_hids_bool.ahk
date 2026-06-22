#Requires AutoHotkey v2.0
#SingleInstance Force

; Define your target USB Device IDs as keys, and their friendly names as values.
; Backslashes must be escaped with another backslash in the keys.
TargetDevices := Map(
    "VID_06A3&PID_0C2D\\9&1d94182f&0&1", "Left Throttle Quadrant",
    "VID_06A3&PID_0C2D\\9&1d94182f&0&2", "Right Throttle Quadrant",
    "VID_1690&PID_FE13",                 "WeisAir Switch Panel",
    "VID_05E3&PID_0626",                 "Saitek Rudder Pedals",
    "VID_294B&PID_1900",                 "Honeycomb Alpha Yoke"
)

; Exit with the final result (1 if all are connected, 0 if any are missing)
ExitApp(CheckUsbDevices(TargetDevices))


/**
 * Checks if all specified USB Device IDs are currently connected.
 * Alerts the user with friendly names and IDs if any are missing.
 * @param {Map} deviceMap - Map of hardware IDs (keys) and friendly names (values).
 * @return {Integer} 1 if all devices are found, 0 if any device is missing.
 */
CheckUsbDevices(deviceMap) {
    ; Create a temporary tracking map initialized to false
    statusMap := Map()
    for deviceID, friendlyName in deviceMap {
        statusMap[deviceID] := false
    }
    
    ; Connect to WMI service to query Plug and Play devices
    wmi := ComObjGet("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
    query := wmi.ExecQuery("SELECT DeviceID FROM Win32_PnPEntity WHERE DeviceID LIKE 'USB%'")
    
    ; Loop through all active USB hardware devices
    for objDevice in query {
        if !objDevice.DeviceID
            continue
            
        for deviceID, friendlyName in deviceMap {
            CleanID := StrReplace(deviceID, "\\", "\")
            if InStr(objDevice.DeviceID, CleanID) {
                statusMap[deviceID] := true
            }
        }
    }
    
    ; Identify missing devices and format the error message
    missingDevices := ""
    for deviceID, connected in statusMap {
        if !connected {
            FriendlyName := deviceMap[deviceID]
            CleanID := StrReplace(deviceID, "\\", "\")
            
            ; Formats as: • Friendly Name (ID: VID_...)
            missingDevices .= "• " . FriendlyName . "`n  [ID: " . CleanID . "]`n`n"
        }
    }
    
    ; If any devices are missing, show a message box and return 0
    if (missingDevices != "") {
        MsgBox("The following USB devices are missing:`n`n" . missingDevices, "USB Connection Error", 48)
        return 0
    }
    
    return 1 ; Everything is connected
}
