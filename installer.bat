@echo off
ECHO Huawei Backup Installer 0.0.0.2
ECHO Copyright by Stepan
ECHO.
ECHO.

::Starte den ADB Server
ECHO [1;4mStarte ADB-Server[0m
ECHO.
.\ressources\adb.exe kill-server
::Sleep um auf adb zu warten
@ping -n 2 localhost> nul
.\ressources\adb.exe start-server
ECHO.

::ADB Geräte ausgeben
ECHO [1;4mADB-Geraete:[0m
ECHO.
.\ressources\adb.exe devices -l

ECHO.
ECHO Bitte Zugriff ueber ADB auf dem Geraet erlauben.
pause
ECHO [1;4mADB-Geraete:[0m
.\ressources\adb.exe devices -l

ECHO.
ECHO Sichere APK von Geraet
for /f %%i in ('.\ressources\adb.exe shell pm path com.huawei.KoBackup') do Set pfad=%%i
set pfad=%pfad:~8%
.\ressources\adb.exe pull %pfad% KoBackup.apk.backup

ECHO.
ECHO [101;93mEntferne APK von Geraet[0m
.\ressources\adb.exe uninstall com.huawei.KoBackup
ECHO.

:VERSIONASK
ECHO.
set /P askVersion="Welche Version von wollen sie installieren? (8/9/10)"
ECHO.
IF %askVersion% == 8 GOTO EIGHT
	IF %askVersion% == 9 GOTO NINE
		IF %askVersion% == 10 GOTO TEN
ECHO Falsche Eingabe.
ECHO. 
GOTO VERSIONASK

ECHO Entferne APK von Geraet
.\ressources\adb.exe uninstall com.huawei.KoBackup
ECHO.

:EIGHT
ECHO Installiere Version 8 von Huawei Backup
.\ressources\adb.exe install .\ressources\backup8.apk
ECHO.
ECHO Backup App ersetzt
GOTO ENDE

:NINE
ECHO Installiere Version 9 von Huawei Backup
.\ressources\adb.exe install .\ressources\backup9.apk
ECHO.
ECHO Backup App ersetzt
GOTO ENDE

:TEN
ECHO Installiere Version 10 von Huawei Backup
.\ressources\adb.exe install .\ressources\backup10.apk
ECHO.
ECHO Backup App ersetzt
GOTO ENDE


:ENDE
ECHO Bitte Backup auf dem Handy durchfuehren.
ECHO.
ECHO.
ECHO Beende ADB-Server
.\ressources\adb.exe kill-server
ECHO FERTIG

pause