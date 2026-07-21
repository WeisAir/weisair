@echo off

REM Backup AirManagerDB on Windows Startup

if not exist "D:\Gefrickel\weisair\weisair\configs\airmanager_db" mkdir "D:\Gefrickel\weisair\weisair\configs\airmanager_db"
copy "C:\Users\Stephan\Air Manager\config.sqlite3" "D:\Gefrickel\weisair\weisair\configs\airmanager_db"


