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

ECHO.
ECHO Sichere APK von Geraet
for /f %%i in ('.\ressources\adb.exe shell pm path com.huawei.KoBackup') do Set pfad=%%i
set pfad=%pfad:~8%
.\ressources\adb.exe pull %pfad% KoBackup.apk.backup

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
ECHO FERTIG

pause