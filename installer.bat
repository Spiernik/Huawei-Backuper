@echo off
ECHO Huawei Backup Installer 0.0.0.1
ECHO Copyright by Stepan
ECHO.
ECHO.

ECHO Starte ADB-Server
ECHO.
.\ressources\adb.exe start-server
ECHO ADB-Geraete:
.\ressources\adb.exe devices -l

ECHO Bitte Zugriff ueber ADB auf dem Geraet erlauben.
pause
ECHO ADB-Geraete:
.\ressources\adb.exe devices -l

ECHO Sichere APK von Geraet
for /f %%i in ('.\ressources\adb.exe shell pm path com.huawei.KoBackup') do Set pfad=%%i
set pfad=%pfad:~8%
.\ressources\adb.exe pull %pfad% KoBackup.apk.backup

ECHO Entferne APK von Geraet
.\ressources\adb.exe uninstall com.huawei.KoBackup
ECHO.
ECHO Installiere alte Version von Huawei Backup
.\ressources\adb.exe install .\ressources\backup.apk
ECHO.
ECHO Backup App ersetzt

ECHO Bitte Backup auf dem Handy durchfuehren und alle .tar entpacken
ECHO.
ECHO FERTIG

pause