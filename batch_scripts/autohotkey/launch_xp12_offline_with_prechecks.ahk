#Requires AutoHotkey v2.0
#SingleInstance Force

targetProgram := "G:\X-Plane_12_latest\X-Plane.exe --lock_fr=30" 

; Endlosschleife, die so lange läuft, bis Bedingungen erfüllt sind oder Abbrechen gedrückt wird
while true {
    ; 1. Prüfskripte ausführen und Ergebnisse abfangen
 checkerResult_processes := RunWait('G:\weisair\batch_scripts\autohotkey\check_launched processes_bool.ahk')
 checkerResult_usb_devices := RunWait('G:\weisair\batch_scripts\autohotkey\check_connected_hids_bool.ahk')

    ; 2. Wenn beide Skripte 1 zurückgeben, das Programm starten und Schleife beenden
    if (checkerResult_processes == 1 and checkerResult_usb_devices == 1) {
        Run(targetProgram)
        break
    } 
    
    ; 3. Falls Bedingungen nicht erfüllt sind: MsgBox mit Wiederholen/Abbrechen (Optionswert 5) anzeigen
    ; 5 = Schaltflächen "Wiederholen" (Retry) und "Abbrechen" (Cancel)
    ; 48 = Icon "Ausrufezeichen" (Warning)
    msgResult := MsgBox("Not Recommended to Launch X-Plane as preconditions are not met.`n`nDo you want to retry?", "Error", 5 + 48)
    
    ; Wenn der Benutzer auf "Abbrechen" (Cancel) klickt, wird das Skript beendet
    if (msgResult == "Cancel") {
        ExitApp()
    }
    
    ; Wenn der Benutzer auf "Wiederholen" (Retry) klickt, springt das Skript automatisch an den Schleifenanfang
}
