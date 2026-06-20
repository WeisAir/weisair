Run("firefox.exe --new-window http://192.168.2.112:9090/")
WinWait "ahk_exe firefox.exe"
sleep 5000
WinMove 0, 0, 1775, 1017, "WebFMC Pro v2.3.4 — Mozilla Firefox"
Send "{F11}"