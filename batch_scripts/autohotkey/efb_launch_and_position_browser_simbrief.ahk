Run("firefox.exe --new-window https://dispatch.simbrief.com/home")
WinWait "ahk_exe firefox.exe"
sleep 10000
WinMove 0, 0, 1775, 1017, "SimBrief - Welcome — Mozilla Firefox"
sleep 3000
Send "{F11}"