@ECHO OFF

rem compress the xOrganizer data base file so that it can be used for an upload to GITHUB (25MB max)

cd G:\
cd "G:\weisair\tools\xOrganizer\latest\XoData"
if not exist "G:\weisair\configs\x-organizer" mkdir "G:\weisair\configs\x-organizer"
tar -a -c -f G:\weisair\configs\x-organizer\xorganizer_db_latest.zip XoData.xml

cd "G:\weisair\tools\xOrganizer\latest_stable\XoData"
tar -a -c -f G:\weisair\configs\x-organizer\xorganizer_db_latest_stable.zip XoData.xml

cd "G:\weisair\tools\xOrganizer\prelatest_stable\XoData"
tar -a -c -f G:\weisair\configs\x-organizer\xorganizer_db_prelatest_stable.zip XoData.xml

rem compress the xToolbox data base file so that it can be used for an upload to GITHUB (25MB max)

cd "G:\weisair\tools\xToolbox\XtData"
tar -a -c -f G:\weisair\configs\x-organizer\xtoolbox_db.zip XtData.xml

exit