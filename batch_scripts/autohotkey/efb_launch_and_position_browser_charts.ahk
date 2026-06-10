Run("firefox.exe --new-window https://charts.navigraph.com/flights")
WinWait "ahk_exe firefox.exe"
sleep 5000
WinMove 0, 0, 1775, 1017, "Navigraph Charts — Mozilla Firefox"
Send "{F11}"