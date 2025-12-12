REM CREATE JUNCTIONS FOR SHARED SCREENSHOTS FOLDER
mklink /j "G:\X-Plane_12_prelatest_stable\Output\screenshots" "G:\weisair\junctions\screenshots"
mklink /j "G:\X-Plane_12_latest_stable\Output\screenshots" "G:\weisair\junctions\screenshots"
mklink /j "G:\X-Plane_12_latest\Output\screenshots" "G:\weisair\junctions\screenshots"

REM CREATE JUNCTIONS FOR SHARED GLOBAL SCENERY FOLDER
mklink /j "G:\X-Plane_12_prelatest_stable\Global Scenery" "G:\weisair\junctions\Global Scenery"
mklink /j "G:\X-Plane_12_latest_stable\Global Scenery" "G:\weisair\junctions\Global Scenery"
mklink /j "G:\X-Plane_12_latest\Global Scenery" "G:\weisair\junctions\Global Scenery"

REM CREATE JUNCTIONS FOR SHARED AIRCRAFT FOLDER
mklink /j "G:\X-Plane_12_prelatest_stable\Aircraft" "G:\weisair\junctions\Aircraft"
mklink /j "G:\X-Plane_12_latest_stable\Aircraft" "G:\weisair\junctions\Aircraft"
mklink /j "G:\X-Plane_12_latest\Aircraft" "G:\weisair\junctions\Aircraft"

REM CREATE JUNCTIONS FOR FLYWITHLUA SCRIPTS FOLDER
mklink /j "G:\X-Plane_12_prelatest_stable\Resources\plugins\FlyWithLua\Scripts" "G:\weisair\junctions\Scripts"
mklink /j "G:\X-Plane_12_latest_stable\Resources\plugins\FlyWithLua\Scripts" "G:\weisair\junctions\Scripts"
mklink /j "G:\X-Plane_12_latest\Resources\plugins\FlyWithLua\Scripts" "G:\weisair\junctions\Scripts"

REM CREATE JUNCTIONS FOR PREFERENCES FOLDER
mklink /j "G:\X-Plane_12_prelatest_stable\Output\preferences" "G:\weisair\junctions\preferences"
mklink /j "G:\X-Plane_12_latest_stable\Output\preferences" "G:\weisair\junctions\preferences"
mklink /j "G:\X-Plane_12_latest\Output\preferences" "G:\weisair\junctions\preferences"

REM CREATE JUNCTIONS FOR AIRMANAGER INSTRUMENTS AND PANELS
mklink /j "C:\Users\Pilot\Air Manager\instruments\OPEN_DIRECTORY" "G:\weisair\junctions\airmanager_instruments"
mklink /j "C:\Users\Pilot\Air Manager\panels\OPEN_DIRECTORY" "G:\weisair\junctions\airmanager_panels"

REM DELETE JUNCTIONS

REM rmdir <junctionlink>
