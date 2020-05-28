@echo off
ECHO Huawei Backup Cleaner 0.0.0.1
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

ECHO Entferne APK von Geraet
.\ressources\adb.exe uninstall com.huawei.KoBackup
ECHO.
REN .\KoBackup.apk.backup .\KoBackup.apk
ECHO Installiere alte Version von Huawei Backup
.\ressources\adb.exe install .\KoBackup.apk
ECHO.
ECHO Backup App wiederhergestellt
DEL /f .\KoBackup.apk

ECHO FERTIG

pause