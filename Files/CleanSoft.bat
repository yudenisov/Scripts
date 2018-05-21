@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Cleaning unwanted software
set USAGE=

call :Cleaning_Soft
goto Finish


:Cleaning_Soft
:: DeleteSPRollback - удаление файлов отката от SP, установленного вручную
dism.exe>nul 2>nul /ONLINE /CLEANUP-IMAGE /SPSUPERSEDED
:: 1ClickDownload
call>nul 2>nul Software uninstall "LSHunterTVApp"
call>nul 2>nul :ExecFilesInProgs  "1ClickDownload\uninst.exe"
for /F %%i in ('dir 2^>nul /A:D /B "%PROGRAMFILES%\Funmoods"') do ^
"%PROGRAMFILES%\Funmoods\%%~i\uninstall.exe">nul 2>nul
for /F %%i in ('dir 2^>nul /A:D /B "%PROGRAMFILES(x86)%\Funmoods"') do ^
"%PROGRAMFILES(x86)%\Funmoods\%%~i\uninstall.exe">nul 2>nul
:: 50CeouupoNs
call>nul 2>nul Software uninstall "50CeouupoNs"
:: AllSaoveer
call>nul 2>nul Software uninstall "AllSaoveer"
:: AmlMaple
call>nul 2>nul Software uninstall "AmlMaple"
:: AlterGeo
call       >nul 2>nul Software uninstall "Html5 geolocation provider"
msiexec.exe>nul 2>nul /X "{0483E1BF-BD3D-4052-A9F2-C2D954D38139}" /QN /NORESTART
msiexec.exe>nul 2>nul /X "{12644DC5-2271-442B-816F-8CFFD3DDDF32}" /QN /NORESTART
msiexec.exe>nul 2>nul /X "{14894C07-EDA7-4919-A22B-98C665DF64C0}" /QN /NORESTART
msiexec.exe>nul 2>nul /X "{65C64E3D-539F-4B81-993B-364C6169F8F5}" /QN /NORESTART
msiexec.exe>nul 2>nul /X "{9ACADADD-3804-4364-A63E-B2B911581F31}" /QN /NORESTART
msiexec.exe>nul 2>nul /X "{A6DC8E6F-1D8D-446C-9644-DAEC54DB1936}" /QN /NORESTART
msiexec.exe>nul 2>nul /X "{F142376D-C1CC-4F66-9AF2-BECEDC1B3A15}" /QN /NORESTART
:: Apple Software Update
call>nul 2>nul Software uninstall "Apple Software Update"
:: Ask Toolbar
:: Search App by Ask
:: Shopping App by Ask
msiexec.exe>nul 2>nul /X "{4F524A2D-5350-4500-76A7-A758B70C1101}" /QN /NORESTART
msiexec.exe>nul 2>nul /X "{4F524A2D-5354-2D53-5045-A758B70C1002}" /QN /NORESTART
msiexec.exe>nul 2>nul /X "{86D4B82A-ABED-442A-BE86-96357B70F4FE}" /QN /NORESTART
call       >nul 2>nul :ExecFilesInProgs "ask.com\Updater\Updater.exe" "-uninstall"
call       >nul 2>nul Software uninstall "Ask Toolbar"
call       >nul 2>nul Software uninstall "App by Ask"
:: Astroburn Toolbar
call>nul 2>nul :ExecFilesInProgs "Astroburn Toolbar\uninst.exe"
:: Babylon Toolbar
for /F %%i in ('dir 2^>nul /A:D /B "%PROGRAMFILES%\BabylonToolbar\BabylonToolbar"') do ^
"%PROGRAMFILES%\BabylonToolbar\BabylonToolbar\%%~i\uninstall.exe">nul 2>nul
for /F %%i in ('dir 2^>nul /A:D /B "%PROGRAMFILES(x86)%\BabylonToolbar\BabylonToolbar"') do ^
"%PROGRAMFILES(x86)%\BabylonToolbar\BabylonToolbar\%%~i\uninstall.exe">nul 2>nul
:: Baidu Trojan
call>nul 2>nul Software uninstall "Baidu"
:: Bing Bar
msiexec.exe>nul 2>nul /X "{3365E735-48A6-4194-9988-CE59AC5AE503}" /QN /NORESTART
msiexec.exe>nul 2>nul /X "{D6C3C9E7-D334-4918-BD57-5B1EF14C207D}" /QN /NORESTART
call       >nul 2>nul Software uninstall "Bing Bar"
:: Bonjour Service
rem hidec.exe>nul 2>nul regsvr32.exe /U /S "%PROGRAMFILES%\Bonjour\explorerplugin.dll"
rem hidec.exe>nul 2>nul regsvr32.exe /U /S "%PROGRAMFILES(x86)%\Bonjour\explorerplugin.dll"
rem hidec.exe>nul 2>nul regsvr32.exe /U /S "%PROGRAMFILES%\Bonjour\mdnsnsp.dll"
rem hidec.exe>nul 2>nul regsvr32.exe /U /S "%PROGRAMFILES(x86)%\Bonjour\mdnsnsp.dll"
:: CalendarWeek
call>nul 2>nul Software uninstall "CalendarWeek"
:: Client for Google Translate
call>nul 2>nul Software uninstall "Client for Google Translate"
:: Coupon
call>nul 2>nul Software uninstall "Coupon"
:: CoupExtension
call>nul 2>nul Software uninstall "CoupExtension"
:: EmotionsBar
call>nul 2>nul Software uninstall "EmotionsBar"
call>nul 2>nul Software uninstall "HomePage.exe"
:: Download Updater (AOL LLC)
call>nul 2>nul :ExecFilesInCommonProgs "Software Update Utility\uninstall.exe"
:: Facemoods Toolbar
for /F %%i in ('dir 2^>nul /A:D /B "%PROGRAMFILES%\facemoods.com\facemoods"') do ^
"%PROGRAMFILES%\facemoods.com\facemoods\%%~i\uninstall.exe">nul 2>nul
for /F %%i in ('dir 2^>nul /A:D /B "%PROGRAMFILES(x86)%\facemoods.com\facemoods"') do ^
"%PROGRAMFILES(x86)%\facemoods.com\facemoods\%%~i\uninstall.exe">nul 2>nul
:: FieryAds
call>nul 2>nul :ExecFilesInAppData "FieryAds\FieryAdsUninstall.exe"
:: FreeRIP Toolbar
call>nul 2>nul Software uninstall "FreeRIP Toolbar"
:: Fixhosts
msiexec.exe>nul 2>nul /X "{FBFBBDD0-EC37-4152-BB77-7D54322AF953}" /QN /NORESTART
:: Gismeteotray
call>nul 2>nul Software uninstall "Gismeteotray"
:: Google Toolbar
call       >nul 2>nul Software uninstall "Google Toolbar"
msiexec.exe>nul 2>nul /X "{18455581-E099-4BA8-BC6B-F34B2F06600C}" /QN /NORESTART
msiexec.exe>nul 2>nul /X "{2318C2B1-4965-11d4-9B18-009027A5CD4F}" /QN /NORESTART
hidec.exe  >nul 2>nul regsvr32.exe /U /S "%PROGRAMFILES%\Google\googletoolbar1.dll"
:: Google Update
call       >nul 2>nul Software uninstall "Google Update"
msiexec.exe>nul 2>nul /X "{430FD4D0-B729-4F61-AA34-91526481799D}" /QN /NORESTART
msiexec.exe>nul 2>nul /X "{A92DAB39-4E2C-4304-9AB6-BC44E68B55E2}" /QN /NORESTART
call>nul 2>nul :ExecFilesInProgs "Google\Update\GoogleUpdate.exe" "/uninstall"
:: GTA Vice City Toolbar
call>nul 2>nul :ExecFilesInProgs "gtavicecity Toolbar\uninstall.exe"
:: Hotspot Shield Toolbar
call>nul 2>nul :ExecFilesInProgs "Hotspot_Shield\uninstall.exe" "toolbar"
:: HP Update
call>nul 2>nul Software uninstall "HP Update"
:: Intel(R) TV Wizard
call>nul 2>nul Software uninstall "Intel(R) TV Wizard"
:: Java Auto Updater
call>nul 2>nul Software uninstall "Java Auto Updater"
:: Mail.Ru
call>nul 2>nul Software uninstall "Mail.ru"
:: Mail.Ru Агент
call>nul 2>nul :ExecFilesInProgs "Mail.Ru\Agent\magentsetup.exe" "-uninstalllm"
:: Mail.Ru Guard
rem call>nul 2>nul Software uninstall  "Guard.Mail.ru"
rem call>nul 2>nul :ExecFilesInAppData "Guard.Mail.Ru\GuardMailRu.exe" "/uninstall"
rem call>nul 2>nul :ExecFilesInProgs   "Mail.Ru\Guard\GuardMailRu.exe" "/uninstall"
:: Mail.Ru Sputnik
call>nul 2>nul :ExecFilesInProgs "Mail.Ru\Sputnik\MailRuSputnik.exe"                      "uninstall"
call>nul 2>nul :ExecFilesInProgs "Mail.Ru\Sputnik\MailRuSputnik_rfranvir_s_mpcln7819.exe" "uninstall"
:: Mail.Ru Updater (Служба автоматического обновления программ)
call>nul 2>nul :ExecFilesInAppData "Mail.Ru\MailRuUpdater.exe" "uninstall"
:: Mail.Ru Интернет
for /F %%i in ('dir 2^>nul /A:D /B "%LOCALAPPDATA%\Xpom\Application"') do ^
hidec.exe>nul 2>nul "%LOCALAPPDATA%\Xpom\Application\%%~i\Installer\setup.exe" --uninstall
:: Marvell Software Informer
call>nul 2>nul Software uninstall "MrvlUsgTracking"
:: McAfee
call>nul 2>nul Software uninstall "McAfee"
:: MediaGet Toolbar
call>nul 2>nul :ExecFilesInProgs "MediaGet DB Toolbar\uninstalltoolbar.exe"
:: MenuEx
hidec.exe>nul 2>nul regsvr32.exe /U /S "%PROGRAMFILES%\MenuEx\menuex.dll"
hidec.exe>nul 2>nul regsvr32.exe /U /S "%PROGRAMFILES(x86)%\MenuEx\menuex.dll"
:: MyPC Backup
call>nul 2>nul :ExecFilesInProgs "MyPC Backup\uninst.exe" "/S"
:: Nero Scout
hidec.exe>nul 2>nul regsvr32.exe /U /S "%COMMONPROGRAMFILES%\Ahead\Lib\MediaLibraryNSE.dll"
hidec.exe>nul 2>nul regsvr32.exe /U /S "%COMMONPROGRAMFILES(x86)%\Ahead\Lib\MediaLibraryNSE.dll"
:: Norton Security Scan
msiexec.exe>nul 2>nul /X "{397E31AA-0D78-4649-A01C-339D73A2ED35}" /QN /NORESTART
:: NVidia Update
call>nul 2>nul Software uninstall "NVidia Update"
call>nul 2>nul Software uninstall "NVIDIA Optimus Update"
:: PandoraTV (KMPlayer)
call>nul 2>nul :ExecFilesInProgs "PANDORA.TV\PanService\unins000.exe" "/SILENT"
:: pdfforge Toolbar
call>nul 2>nul Software uninstall "pdfforge Toolbar"
:: Pokki
call>nul 2>nul :ExecFilesInAppData "Pokki\Uninstall.exe" "/S"
call>nul 2>nul :ExecFilesInAppData "Pokki\Download Helper\PokkiDownloadHelper.exe" "--command uninstall"
:: Punto Switcher
call>nul 2>nul Software uninstall "Punto Switcher"
:: Папка выгрузки Share-to-Web
call>nul 2>nul Software uninstall "ShareIns"
:: QipGuard
call>nul 2>nul :ExecFilesInAppData "QipGuard\QipGuard.exe"  "/u"
call>nul 2>nul :ExecFilesInProgs   "Guard-ICQ\GuardICQ.exe" "/uninstall"
:: Rambler.ru Toolbar
call       >nul 2>nul :ExecFilesInProgs "Rambler Assistant\uninstall.exe"
msiexec.exe>nul 2>nul /X "{01C9B140-F6BE-11E1-8128-742F68A1264B}" /QN /NORESTART
msiexec.exe>nul 2>nul /X "{9C288540-F6AA-11E1-842E-742F68A1264B}" /QN /NORESTART
:: Trojan RelayTurbo
call>nul 2>nul Software uninstall "RelayTurbo"
:: Remote Manipulator System (http://rmansys.ru/)
rutserv.exe>nul 2>nul /stop
rutserv.exe>nul 2>nul /silentuninstall
reg.exe    >nul 2>nul delete "HKLM\SYSTEM\Remote Manipulator System" /F
:: SalePlus
call>nul 2>nul Software uninstall "SalePlus"
:: ShopDrop
call>nul 2>nul Software uninstall "ShopDrop"
:: Skymonk
call>nul 2>nul :ExecFilesInProgs "SkyMonk\uninstall.exe"
:: Skype Click To Call
msiexec.exe>nul 2>nul /X "{B6CF2967-C81E-40C0-9815-C05774FEF120}" /QN /NORESTART
if exist "%PROGRAMFILES%\Skype\SkypeIEPlugin.dll"      rundll32.exe>nul 2>nul "%PROGRAMFILES%\Skype\SkypeIEPlugin.dll",FriendlyUnregisterServer 0
if exist "%PROGRAMFILES(x86)%\Skype\SkypeIEPlugin.dll" rundll32.exe>nul 2>nul "%PROGRAMFILES(x86)%\Skype\SkypeIEPlugin.dll",FriendlyUnregisterServer 0
:: SoftoBase (http://softobase.com/)
taskkill.exe>nul 2>nul /F /T /IM "softobase*" /IM "AwesomiumProcess.exe"
call        >nul 2>nul :DelDirInProgs "Softobase"
:: Sql Server Customer Experience Improvement Program
call>nul 2>nul Software uninstall "Sql Server Customer Experience Improvement Program"
:: SpeedUpMyPC
call>nul 2>nul Software uninstall "SpeedUpMyPC"
:: StartNow Tooobar
call>nul 2>nul Software uninstall "StartNow Toolbar"
:: Store Gid (Шоппинг гид)
call>nul 2>nul Software uninstall "storegid"
:: superpromokody
call>nul 2>nul Software uninstall "superpromokody"
:: Ticno Multibar & Ticno Tabs
call >nul 2>nul :ExecFilesInProgs "Ticno\Multibar\uninstall.exe"
call >nul 2>nul :ExecFilesInProgs "Ticno\Tabs\uninstall.exe"
call >nul 2>nul :DelDirInProgs    "Ticno"
:: The AdBlocker
call>nul 2>nul Software uninstall "The AdBlocker"
:: Unknown
msiexec.exe>nul 2>nul /X "{D6C3C9E7-D334-4918-BD57-5B1EF14C207D}" /QN /NORESTART
:: Webalta Toolbar
call>nul 2>nul :ExecFilesInAppData "Webalta Toolbar\uninstall.exe" "/S"
:: WinAmp Toolbar
call>nul 2>nul :ExecFilesInProgs "Winamp Toolbar\uninstall.exe"
:: Windows Unwanted Updates
:: KB971033 - License validation / anti piracy
wusa.exe>nul 2>nul /KB:971033  /UNINSTALL /QUIET /NORESTART
:: KB2952664 - GWX assistant
wusa.exe>nul 2>nul /KB:2952664 /UNINSTALL /QUIET /NORESTART
:: KB2976978 - Update for Windows 8.1 and Windows 8
wusa.exe>nul 2>nul /KB:2976978 /UNINSTALL /QUIET /NORESTART
:: KB2977759 - Update for Windows 7 RTM
wusa.exe>nul 2>nul /KB:2977759 /UNINSTALL /QUIET /NORESTART
:: KB2990214 - GWX for Windows 7
wusa.exe>nul 2>nul /KB:2990214 /UNINSTALL /QUIET /NORESTART
:: KB3012973 - Upgrade to Windows 10
wusa.exe>nul 2>nul /KB:3012973 /UNINSTALL /QUIET /NORESTART
:: KB3014460 - Upgrade for Windows Insider Preview / Upgrade to Windows 10
wusa.exe>nul 2>nul /KB:3014460 /UNINSTALL /QUIET /NORESTART
:: KB3015249 - Telemetry points for Windows 8.1 / Windows 7
wusa.exe>nul 2>nul /KB:3015249 /UNINSTALL /QUIET /NORESTART
:: KB3021917 - Update to Windows 7 SP1 for performance improvements
wusa.exe>nul 2>nul /KB:3021917 /UNINSTALL /QUIET /NORESTART
:: KB3022345 - Telemetry
wusa.exe>nul 2>nul /KB:3022345 /UNINSTALL /QUIET /NORESTART
:: KB3035583 - GWX Update for Get Windows 10 app in Windows 8.1 / Windows 7 SP1
wusa.exe>nul 2>nul /KB:3035583 /UNINSTALL /QUIET /NORESTART
:: KB3044374 - GWX for Windows 8.1
wusa.exe>nul 2>nul /KB:3044374 /UNINSTALL /QUIET /NORESTART
:: KB3050265 - Update for Windows Update on Windows 7
wusa.exe>nul 2>nul /KB:3050265 /UNINSTALL /QUIET /NORESTART
:: KB3050267 - Update for Windows update client for Windows 8.1 June 2015
wusa.exe>nul 2>nul /KB:3050267 /UNINSTALL /QUIET /NORESTART
:: KB3068708 - Telemetry
wusa.exe>nul 2>nul /KB:3068708 /UNINSTALL /QUIET /NORESTART
:: KB3075249 - Telemetry for Win7/8.1
wusa.exe>nul 2>nul /KB:3075249 /UNINSTALL /QUIET /NORESTART
:: KB3075851 - Update for Windows Update on Windows 7 / Server 2008 R2
wusa.exe>nul 2>nul /KB:3075851 /UNINSTALL /QUIET /NORESTART
:: KB3075853 - Update for Windows Update on Windows 8.1 / Server 2012 R2
wusa.exe>nul 2>nul /KB:3075853 /UNINSTALL /QUIET /NORESTART
:: KB3080149 - Telemetry
wusa.exe>nul 2>nul /KB:3080149 /UNINSTALL /QUIET /NORESTART
:: KB3112336 - Update Client for Windows 8.1 / Server 2012 R2
wusa.exe>nul 2>nul /KB:3112336 /UNINSTALL /QUIET /NORESTART
:: KB3118401 - Update for Universal C Runtime in Windows
wusa.exe>nul 2>nul /KB:3118401 /UNINSTALL /QUIET /NORESTART
:: KB3123862 - Updated capabilities to upgrade Windows 8.1 and Windows 7
wusa.exe>nul 2>nul /KB:3123862 /UNINSTALL /QUIET /NORESTART
:: KB3140185 - March 2016 WAU update for Windows 8.1
wusa.exe>nul 2>nul /KB:3140185 /UNINSTALL /QUIET /NORESTART
:: KB3144850 - Update for downgrade rights for Windows 10
wusa.exe>nul 2>nul /KB:3144850 /UNINSTALL /QUIET /NORESTART
:: Yandex Bar
msiexec.exe>nul 2>nul /X "{11EA1C75-DB0D-410B-B63B-20916EECD568}" /QN /NORESTART
msiexec.exe>nul 2>nul /X "{35015585-072D-4D95-9509-E6205C6F7991}" /QN /NORESTART
msiexec.exe>nul 2>nul /X "{6740F9E3-1353-47DD-9765-BA49FC4C3479}" /QN /NORESTART
msiexec.exe>nul 2>nul /X "{FBB54511-4D35-4EE0-872C-BB5A9617EC8F}" /QN /NORESTART
:: Yontoo Toolbar
call>nul 2>nul Software uninstall "Yontoo"
:: Weather Bar
call>nul 2>nul Software uninstall "Weatherbar"
:: Регистрация продуктов HP
call>nul 2>nul Software uninstall "WebReg"
:: Zaxar Games Browser
call>nul 2>nul Software uninstall "Zaxar Games Browser"
:: Элементы Яндекса
call>nul 2>nul Software uninstall "Элементы Яндекса"
::
ping.exe>nul 2>nul 127.0.0.1 -n 31
call EchoSucc Cleaning software
exit /B

:ExecFilesInCommonProgs
if "%~1"=="" exit /B 255
for /D %%i in ("%COMMONPROGRAMFILES: (x86)=%" "%COMMONPROGRAMFILES(x86)%") do hidec.exe "%%~i\%~1" %~2
exit /B

:ExecFilesInProgs
if "%~1"=="" exit /B 255
for /D %%i in ("%PROGRAMFILES: (x86)=%" "%PROGRAMFILES(x86)%") do hidec.exe "%%~i\%~1" %~2
exit /B

:ExecFilesInAppData
if "%~1"=="" exit /B 255
for /D %%i in ("%SYSTEMDRIVE%\Users" "%SYSTEMDRIVE%\Documents and Settings") do ^
for /D %%j in ("%%~i\*.*" "%%~i\All Users" "%%~i\Default") do (
  hidec.exe "%%~j\AppData\Local\%~1" %~2
  hidec.exe "%%~j\AppData\Roaming\%~1" %~2
  hidec.exe "%%~j\Application Data\%~1" %~2
  hidec.exe "%%~j\Local Settings\%~1" %~2
  hidec.exe "%%~j\Local Settings\Application Data\%~1" %~2
)
if defined ProgramData hidec.exe "%PROGRAMDATA%\%~1" %~2
exit /B

:DelDirInProgs
if "%~1"=="" exit /B 1
for /D %%i in ("%PROGRAMFILES: (x86)=%" "%PROGRAMFILES(x86)%") do ^
if exist "%%~i" call Directory Delete "%%~i\%~1"
exit /B

:Finish
