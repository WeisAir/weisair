|Step   |Test                               | Expected Result| Result (passed or comment)|
|-------|-----------------------------------|-------------------------------------------------------------------------------------------------------------------|-|
|1      | Start EFB on Notebook             | App starts up, all services are running / are connected |ok - FMC missing?|
|2      | Plan Flight in Simbrief           | Flight can be planned and dispatched|ok|
|3      | Start WeisAir Launcher            | Script launches, checks passed New Simbrief flight has been detected and imported to X-Plane |ok|
|4      | Configure Flight in XP12          | X-Plane 12 starts up, flight can be configured and loaded |ok|
|5      | Enter virtual Flight Deck         | Virtual Cockpit has loaded, positive UDP count in status bar|ok|
|6      | Activate KML Loggimg on Prompt    | Prompt about KML log appears and can be activated |ok|
|7      | Fly following Checklists          | Flight controls / Buttons / Switches / Streamdeck / Airmanager work as expected / no noticable performance issues |ok|
|7.1    | Take Screenshots (in Flight)      | Screenshot counter increases in status bar and new screenshots are stored |ok|
|7.2    | Take Screenshots (Replay Mode)    | Screenshot counter increases in status bar and new screenshots are stored |ok| 
|8.     | Turn Off Aircraft                 | KML-Logger dialog appears to summarize flightAfter last relevant screenshot |ok|
|9.     | Save Replay                       | Replay is saved |ok|
|10.    | Exit X-Plane                      | Sim closed gracefully |ok|
|11.    | Exit Status Bar                   | LittleNavMap and Simbriefpydownloader closed gracefully|nok, with shutdown of XP, the status bar was closed as well, so lnm and simbriefdownloader still online|
|12.    | Inspect Debrief Folder            | Debrief Folder for the current flight has been created|ok|
|12.1   | LogFiles are available            | Logfiles are copied |ok|
|12.2   | Geo Data is available             | geo folder has KML and KMZ files, files an be opened in Google earth |ok|
|12.3   | Stats Data is available           | data folder has udp logfile + gnuplot files |ok|
|12.4   | capture Data is available         | capture folder has screenshots |ok|
|13     | Start WebApp                      | WebApp has been started |ok|
|13.1   | Check new Flight Data in App      | Summary table lists recent flight |ok|
|13.2   | Flight geo/data/captures available| Clicking the webapp buttons access additional information|nok - no lat lon for KaiTak -> needs to be hardcoded and by now only got a few airports, buttons are not visible -> after update_webapp.py has been started and coordinates have been added, everything worked fine|