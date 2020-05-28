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
ECHO [93mBitte Zugriff ueber ADB auf dem Geraet erlauben.[0m
pause
ECHO [1;4mADB-Geraete:[0m
.\ressources\adb.exe devices -l

ECHO.
ECHO Sichere APK von Geraet
for /f %%i in ('.\ressources\adb.exe shell pm path com.huawei.KoBackup') do Set pfad=%%i
set pfad=%pfad:~8%
.\ressources\adb.exe pull %pfad% KoBackup.apk.backup

ECHO.
ECHO [101;97mEntferne APK von Geraet[0m
.\ressources\adb.exe uninstall com.huawei.KoBackup
ECHO.

:VERSIONASK
ECHO.
set /P askVersion="[93mWelche Version von wollen sie installieren? (8/9/10)[0m"
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
ECHO Installiere [1mVersion 8[0m von Huawei Backup
.\ressources\adb.exe install .\ressources\backup8.apk
ECHO.
ECHO [42mBackup App ersetzt[0m
GOTO ENDE

:NINE
ECHO Installiere [1mVersion 9[0m von Huawei Backup
.\ressources\adb.exe install .\ressources\backup9.apk
ECHO.
ECHO [42mBackup App ersetzt[0m
GOTO ENDE

:TEN
ECHO Installiere [1mVersion 10[0m von Huawei Backup
.\ressources\adb.exe install .\ressources\backup10.apk
ECHO.
ECHO [42mBackup App ersetzt[0m
GOTO ENDE


:ENDE
ECHO Starte Huawei Backup App
ECHO [93mBitte Backup auf dem Handy durchfuehren.[0m
ECHO.
.\ressources\adb.exe shell monkey -p com.huawei.KoBackup -c android.intent.category.LAUNCHER 1 > nul
::Beende ADB-Server
.\ressources\adb.exe kill-server
pause