#Requires AutoHotkey v2.0
#SingleInstance Force

; 1. Define the executable you want to run at the end
targetProgram := "G:\X-Plane_12_latest\X-Plane.exe --lock_fr=30" 

; 2. Run the checker script and wait for it to finish
; RunWait captures the ExitApp value from the checker script
checkerResult_processes := RunWait('G:\weisair\batch_scripts\autohotkey\check_launched processes_bool.ahk')
checkerResult_usb_devices := RunWait('G:\weisair\batch_scripts\autohotkey\check_connected_hids_bool.ahk')

; 3. Launch the program only if the result is 1 (True)
if (checkerResult_processes == 1 and checkerResult_usb_devices == 1) {
    Run(targetProgram)
} else {
    MsgBox("Not Recommended to Launch X-Plane as preconditions are not met.", "Error", 48)
}
