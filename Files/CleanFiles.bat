@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Cleaning unwanted files
set USAGE=

call :Cleaning_Files
goto Finish


:Cleaning_Files
set DELETE_OBJECT_ERROR=NO
if /I "%DEBUG%"=="YES" (
  call           :Cleaning_Files_Sub
) else (
  call>nul 2>nul :Cleaning_Files_Sub
)
if /I "%DEBUG%"=="YES" (
  echo.
  if /I "%DELETE_OBJECT_ERROR%"=="YES" (
    exit /B 1
  )
  exit /B 0
)
if /I "%DELETE_OBJECT_ERROR%"=="YES" (
  call EchoFail Cleaning files
  exit /B 1
)
call EchoSucc Cleaning files
exit /B 0
:Cleaning_Files_Sub
call EchoTitl Cleaning files

call Directory Delete         "%ALLUSERSPROFILE%\Adobe\ARM"
call Directory Delete         "%ALLUSERSPROFILE%\AlterGeo"
call Directory Delete         "%ALLUSERSPROFILE%\Drivers"
call Directory Delete         "%ALLUSERSPROFILE%\vksaver"
call Directory Delete         "%ALLUSERSPROFILE%\Windows"
call Directory Delete         "%SYSTEMDRIVE%\AdwCleaner"
call Directory Delete         "%SYSTEMDRIVE%\ATI"
call Directory Delete         "%SYSTEMDRIVE%\found.000"
call Directory Delete         "%SYSTEMDRIVE%\Intel"
call Directory Delete         "%SYSTEMDRIVE%\launcher"
call Directory Delete         "%SYSTEMDRIVE%\NVIDIA"
call Directory Delete         "%SYSTEMDRIVE%\MSOCache"
call Directory Delete         "%SYSTEMDRIVE%\PerfLogs"
call Directory Delete         "%SYSTEMDRIVE%\Plugin"
call Directory Delete         "%SYSTEMDRIVE%\RaidTool"
call Directory Delete         "%SYSTEMDRIVE%\VkontakteDJ"
call Directory Delete         "%SYSTEMROOT%\assembly\GAC_MSIL\WebAlta*"
call Directory Delete         "%SYSTEMROOT%\PixArt"
call Directory delete         "%SYSTEMROOT%\SYSTEM32\CompatTel"
call Directory Delete         "%SYSTEMROOT%\SYSTEM32\GWX"
call Directory Delete         "%SYSTEMROOT%\SYSTEM32\GWX32"
call Directory Delete         "%SYSTEMROOT%\SYSWOW64\GWX"
call Directory Delete         "D:\MSOCache"

call DeleteObjectsOld         "%SYSTEMROOT%\Logs"

call :DelDirInUsers           "Favorites\Links"
call :DelDirInUsers           "Favorites\Links for Россия"
call :DelDirInUsers           "Favorites\Windows Live"
call :DelDirInUsers           "Favorites\Веб-сайты MSN"
call :DelDirInUsers           "Favorites\Веб-сайты Майкрософт"
call :DelDirInUsers           "UpdatusUser"

call :DelDirInAppData         "{F0851D5E-F34D-4B0E-F085-51D5EF34757B}"
call :DelDirInAppData         "advPlugin"
call :DelDirInAppData         "AlterGeo"
call :DelDirInAppData         "Amigo"
call :DelDirInAppData         "AskToolbar"
call :DelDirInAppData         "Baidu"
call :DelDirInAppData         "Bromium"
call :DelDirInAppData         "FirefoxToolbar"
call :DelDirInAppData         "GameXN"
call :DelDirInAppData         "Google\CrashReports"
call :DelDirInAppData         "Google\Update"
call :DelDirInAppData         "Guard.Mail.Ru"
call :DelDirInAppData         "GWX"
call :DelDirInAppData         "Homepager"
call :DelDirInAppData         "IHProtectUpDate"
call :DelDirInAppData         "iLivid"
call :DelDirInAppData         "ilividmoviestoolbar*"
call :DelDirInAppData         "IObit"
call :DelDirInAppData         "IObit installer"
call :DelDirInAppData         "Kometa"
::call :DelDirInAppData       "Mail.Ru"
call :DelDirInAppData         "MailRu"
call :DelDirInAppData         "Media Get LLC"
call :DelDirInAppData         "MediaGet2"
call :DelDirInAppData         "mediahit"
call :DelDirInAppData         "MicrocoftUpdate"
call :DelDirInAppData         "Microsoft\Windows\WER"
call :DelDirInAppData         "Mra"
call :DelDirInAppData         "Nichrome"
call :DelDirInAppData         "NoMore Ads"
call :DelDirInAppData         "Opera\Opera\profile\cache4"
call :DelDirInAppData         "Opera\Opera\profile\scripts"
call :DelDirInAppData         "Opera\Opera\profile\toolbar"
call :DelDirInAppData         "Opera\Opera\profile\widgets"
call :DelDirInAppData         "PlayFree Browser"
call :DelDirInAppData         "Pokki"
call :DelDirInAppData         "Pokkies"
call :DelDirInAppData         "QipGuard"
call :DelDirInAppData         "Rambler"
call :DelDirInAppData         "SaveSense"
call :DelDirInAppData         "SetMyHomePage"
call :DelDirInAppData         "SkyMonk*"
call :DelDirInAppData         "SmartWeb"
call :DelDirInAppData         "storegid"
call :DelDirInAppData         "StormFall"
call :DelDirInAppData         "The AdBlocker"
call :DelDirInAppData         "ToolwizCareFree"
call :DelDirInAppData         "TornTV.com"
call :DelDirInAppData         "VKDJ"
call :DelDirInAppData         "VOPackage"
call :DelDirInAppData         "Webalta*"
call :DelDirInAppData         "Windows"
call :DelDirInAppData         "WindowsMangerProtect"
call :DelDirInAppData         "WinnerDM"
call :DelDirInAppData         "Xpom"
call :DelDirInAppData         "Yandex"
call :DelDirInAppData         "zona"

call :DelDirInCommonProgs     "Adobe\ARM"
call :DelDirInCommonProgs     "Adobe\OOBE\PDApp\UWA"
call :DelDirInCommonProgs     "Adobe\Updat*"
call :DelDirInCommonProgs     "InstallShield\UpdateService"
call :DelDirInCommonProgs     "Java\Java Updat*"
call :DelDirInCommonProgs     "Real\Update_OB"
call :DelDirInCommonProgs     "Scansoft Shared\SSBkgdUpdate"
call :DelDirInCommonProgs     "Spigot"
call :DelDirInCommonProgs     "YDP\UserAccessManager"

call :DelDirInFirefoxProfiles "extensions\{37964A3C-4EE8-47b1-8321-34DE2C39BA4D}"
call :DelDirInFirefoxProfiles "MRSputnikData"

call :DelDirInProgs           "*AlterGeo*"
call :DelDirInProgs           "*Ask.com*"
call :DelDirInProgs           "*AskTBar*"
call :DelDirInProgs           "*Cooupon*"
call :DelDirInProgs           "*Coupoon*"
call :DelDirInProgs           "*Couppon*"
call :DelDirInProgs           "*Mail.Ru*"
call :DelDirInProgs           "*Pandora.TV*"
call :DelDirInProgs           "*Punto Switcher*"
call :DelDirInProgs           "*QipGuard*"
call :DelDirInProgs           "*SkyMonk*"
call :DelDirInProgs           "*Toolbar*"
call :DelDirInProgs           "*Vkontakte*"
call :DelDirInProgs           "*Yandex*"
call :DelDirInProgs           "360"
call :DelDirInProgs           "50CeouupoNs"
call :DelDirInProgs           "advPlugin"
call :DelDirInProgs           "AllSaoveer"
call :DelDirInProgs           "AMD AVT"
call :DelDirInProgs           "AmlMaple"
call :DelDirInProgs           "Anonymity Shield"
call :DelDirInProgs           "Application Updater"
call :DelDirInProgs           "Application Assistance"
call :DelDirInProgs           "Apps Hat Madness"
call :DelDirInProgs           "ASUS\ATK Hotkey"
call :DelDirInProgs           "AVAST Software\SZBrowser"
call :DelDirInProgs           "AVG Secure Search"
call :DelDirInProgs           "Baidu"
call :DelDirInProgs           "BaiduEx"
call :DelDirInProgs           "Blue Coat K9 Web Protection"
call :DelDirInProgs           "BonanzaDealsLive"
call :DelDirInProgs           "CalendarWeek"
call :DelDirInProgs           "Carambis"
call :DelDirInProgs           "Content Defender"
call :DelDirInProgs           "CoupExTension"
call :DelDirInProgs           "DeviceVM\Browser Configuration Utility"
call :DelDirInProgs           "DolkaRuIePlugin"
call :DelDirInProgs           "dns2"
call :DelDirInProgs           "EditThisCookie"
call :DelDirInProgs           "EMOTIONSOFT"
call :DelDirInProgs           "FilesFrog Update Checker"
call :DelDirInProgs           "Gigabyte\EasySaver"
call :DelDirInProgs           "Google\Common\Google Updater"
call :DelDirInProgs           "Google\CrashReports"
call :DelDirInProgs           "Google\Google Toolbar"
call :DelDirInProgs           "Google\GoogleToolbarNotifier"
call :DelDirInProgs           "Google\Update"
call :DelDirInProgs           "Hotspot_Shield"
call :DelDirInProgs           "HP\HP Software Update"
call :DelDirInProgs           "Hewlett-Packard\HP Share-to-Web"
call :DelDirInProgs           "Hewlett-Packard\OrderReminder"
call :DelDirInProgs           "IB Updater"
call :DelDirInProgs           "Incredibar.com"
call :DelDirInProgs           "InstallShield\UpdateService"
call :DelDirInAppData         "Intel Security"
call :DelDirInProgs           "Key Switcher"
call :DelDirInProgs           "kingsoft"
call :DelDirInProgs           "LiveSupport"
call :DelDirInProgs           "madlen.ucoz.com"
call :DelDirInProgs           "Mask Surf Lite"
call :DelDirInProgs           "MarketResearchHelper"
call :DelDirInProgs           "McAfee*"
call :DelDirInProgs           "MenuEx"
call :DelDirInProgs           "Messenger"
call :DelDirInProgs           "Microsoft\BingBar"
call :DelDirInProgs           "MOBZystems\See Through Windows"
call :DelDirInProgs           "Mozilla Maintenance Service"
call :DelDirInProgs           "MPC Cleaner"
call :DelDirInProgs           "movies toolbar"
call :DelDirInProgs           "MyPC Backup"
call :DelDirInProgs           "National Instruments\Shared\Update Service"
call :DelDirInProgs           "Nero\Update"
call :DelDirInProgs           "NVIDIA Corporation\Installer2\NVIDIA.Update.0"
call :DelDirInProgs           "NVIDIA Corporation\NVIDIA Updat*"
call :DelDirInProgs           "NVIDIA Corporation\NvStreamSrv"
call :DelDirInProgs           "NVIDIA Corporation\NvUpdate"
call :DelDirInProgs           "Obnovi Soft"
call :DelDirInProgs           "Opera\userjs"
call :DelDirInProgs           "Picexa"
call :DelDirInProgs           "Real\RealPlayer\update"
call :DelDirInProgs           "Remote Manipulator System"
call :DelDirInProgs           "RelevantKnowledge"
call :DelDirInProgs           "Reset_hosts"
call :DelDirInProgs           "ScanSoft\OmniPageSE4.0\Ereg"
call :DelDirInProgs           "SearchYa!"
call :DelDirInProgs           "ShhopDrop"
call :DelDirInProgs           "ShopDrop"
call :DelDirInProgs           "Show-Password*"
call :DelDirInProgs           "SiallePlus"
call :DelDirInProgs           "SmartTweak"
call :DelDirInProgs           "Skype\Updater"
call :DelDirInProgs           "Skype\toolbars"
call :DelDirInProgs           "Sony\Marketing Tools"
call :DelDirInProgs           "Sony\VAIO Updat*"
call :DelDirInProgs           "SupTab"
call :DelDirInProgs           "Surftastic"
call :DelDirInProgs           "Symantec\Norton Online Backup\Activation"
call :DelDirInProgs           "SystemProgs\PuntoSwitcher"
call :DelDirInProgs           "Tab Snooze"
call :DelDirInProgs           "test"
call :DelDirInProgs           "TimeTasks"
call :DelDirInProgs           "TornTV.com"
call :DelDirInProgs           "Tracker Software\Live Update"
call :DelDirInProgs           "Translate Client"
call :DelDirInProgs           "TrueKey"
call :DelDirInProgs           "Uniblue"
call :DelDirInProgs           "VITSOFT"
call :DelDirInProgs           "WordSurfer*"
call :DelDirInProgs           "winelir"
call :DelDirInProgs           "XTab"
call :DelDirInProgs           "Zaxar"
call :DelDirInProgs           "zona"

call File Delete              "%SYSTEMDRIVE%\*.log"
call File Delete              "%SYSTEMDRIVE%\autoexec.bat"
call File Delete              "%SYSTEMDRIVE%\bootsqm.dat"
call File Delete              "%SYSTEMDRIVE%\config.sys"
call File Delete              "%SYSTEMDRIVE%\driverpack_*.txt"
call File Delete              "%SYSTEMDRIVE%\*.b?t.exe"
call File Delete              "%SYSTEMDRIVE%\io.sys"
call File Delete              "%SYSTEMDRIVE%\msdos.sys"

call :DelFileInAppData        "*.bat"
call :DelFileInAppData        "*.exe"
call :DelFileInAppData        "DRPSu\DrvUpdater.exe"
call :DelFileInAppData        "eTranslator"
call :DelFileInAppData        "FLEXnet\Connect\11\agent.exe"
call :DelFileInAppData        "Macrovision\FLEXnet Connect\6\agent.exe"
call :DelFileInAppData        "Microsoft\internet explorer\qipsearchbar.dll"
call :DelFileInAppData        "Microsoft\MSOIdentityCRL\Tracing\*.txt"
call :DelFileInAppData        "Microsoft\Windows\toolbar.exe"

call :DelFileInCommonProgs    "Adobe\OOBE\PDApp\UWA\updaterstartuputility.exe"
call :DelFileInCommonProgs    "Adobe\SwitchBoard\switchboard.exe"
::call :DelFileInCommonProgs  "Microsoft Shared\DW\dw20.exe"
call :DelFileInCommonProgs    "Microsoft Shared\VS7DEBUG\mdm.exe"

call :DelFileInProgs          "*.sys"
call :DelFileInProgs          "jusched.exe"
call :DelFileInProgs          "Adobe\Acrobat 8.0\Acrobat\acrotray.exe"
call :DelFileInProgs          "Adobe\Acrobat 8.0\Acrobat\Distillr\acrotray.exe"
call :DelFileInProgs          "Adobe\Reader 9.0\Reader\reader_sl.exe"
call :DelFileInProgs          "ATI Technologies\ATI.ACE\cli.exe"
call :DelFileInProgs          "Google\chrome.bat"
call :DelFileInProgs          "Internet Explorer\*.bat"
::call :DelFileInProgs        "Microsoft Office\Office14\grooveex.dll"
::call :DelFileInProgs        "Microsoft Office\Office15\grooveex.dll"
call :DelFileInProgs          "Mozilla Firefox\*.bat"

call :DelFileInProgs          "Java\jre1.6.0_01\bin\jucheck.exe"
call :DelFileInProgs          "Microsoft Office\Office10\osa.exe"
call :DelFileInProgs          "NVIDIA Corporation\Display\nvtray.exe"
call :DelFileInProgs          "NVIDIA Corporation\Installer2\Display.ControlPanel.0\nvtray.exe"
call :DelFileInProgs          "Winamp\winampa.exe"

call :DelFileInStartMenu      "Programs\Media Center.lnk"
call :DelFileInStartMenu      "Programs\Windows Anytime Upgrade.lnk"
call :DelFileInStartMenu      "Programs\Startup\appdistrib.lnk"
call :DelFileInStartMenu      "Programs\Startup\IMVU.lnk"
call :DelFileInStartMenu      "Programs\Startup\ISCTSystray.lnk"
call :DelFileInStartMenu      "Programs\Startup\Kbupdater Utility.lnk"
call :DelFileInStartMenu      "Programs\Startup\McAfee Security Scan Plus.lnk"
call :DelFileInStartMenu      "Programs\Startup\Punto Switcher.lnk"
call :DelFileInStartMenu      "Programs\Startup\SRS Premium Sound.lnk"
call :DelFileInStartMenu      "Programs\Startup\Вырезка экрана и программа запуска для OneNote 2010.lnk"

call :DelFileInSystem         "CompatTelRunner.exe"
call :DelFileInSystem         "csdrive32.exe"
call :DelFileInSystem         "fixhosts.exe"
call :DelFileInSystem         "googletoolbarnotifier.exe"
call :DelFileInSystem         "GroupPolicy\Machine\Registry.pol*"
call :DelFileInSystem         "hkcmd.exe"
call :DelFileInSystem         "hotfixq0306270.exe"
call :DelFileInSystem         "igfxpers.exe"
call :DelFileInSystem         "igfxsrvc.exe"
call :DelFileInSystem         "igfxtray.exe"
call :DelFileInSystem         "jusched.exe"
call :DelFileInSystem         "lockdown.exe"
::call :DelFileInSystem       "logon.scr"
call :DelFileInSystem         "pluginc.exe"
call :DelFileInSystem         "patsearch.bin"
call :DelFileInSystem         "praetorian.exe"
call :DelFileInSystem         "rfusclient.exe"
call :DelFileInSystem         "rmanserver.exe"
call :DelFileInSystem         "rmanfusclient.exe"
call :DelFileInSystem         "rutserv.exe"
call :DelFileInSystem         "soundmax.exe"
call :DelFileInSystem         "storegidfilter.sys"
call :DelFileInSystem         "xp_eos.exe"
call :DelFileInSystem         "AppPatch\*.exe"
call :DelFileInSystem         "drivers\bckd.sys"
call :DelFileInSystem         "drivers\bd0001.sys"
call :DelFileInSystem         "drivers\bd0002.sys"
call :DelFileInSystem         "drivers\bd0003.sys"
call :DelFileInSystem         "drivers\bd0004.sys"
call :DelFileInSystem         "drivers\bdarkit.sys"
call :DelFileInSystem         "drivers\bddefense.sys"
call :DelFileInSystem         "drivers\bdmwrench.sys"
call :DelFileInSystem         "drivers\mpckpt.sys"
call :DelFileInSystem         "Macromed\Flash\*.exe"

call :DelShortcuts            "baidu"
call :DelShortcuts            "Blue Coat K9 Web Protection"
call :DelShortcuts            "HP Share-to-Web"
call :DelShortcuts            "JetSwap SafeSurf"
call :DelShortcuts            "McAfee Security Scan Plus"
call :DelShortcuts            "Microsoft Silverlight"
call :DelShortcuts            "MediaGet"
call :DelShortcuts            "MediaGet2"
call :DelShortcuts            "MyPC Backup"
call :DelShortcuts            "PC App Store"
call :DelShortcuts            "PlayFree Браузер"
call :DelShortcuts            "Pokki Menu"
call :DelShortcuts            "StormFall"
call :DelShortcuts            "Sync Folder"
call :DelShortcuts            "Обнови Софт"
exit /B

:DelDirInUsers
if "%~1"=="" exit /B 1
setlocal
cd>nul 2>nul /D "%SYSTEMDRIVE%\Users" || ^
cd>nul 2>nul /D "%SYSTEMDRIVE%\Documents and Settings" || exit /B 1
for /D %%i in ("*.*" "All Users" "Default") do (
  if exist "%%~i" call Directory Delete "%%~i\%~1"
)
endlocal
exit /B

:DelDirInAppData
if "%~1"=="" exit /B 1
for /D %%h in (C D) do if exist "%%~h:" ^
for /D %%i in ("%%~h:\Users" "%%~d:\Documents and Settings") do if exist "%%~i" ^
for /D %%j in ("%%~i\All Users" "%%~i\Default" "%%~i\Все пользователи" "%%~i\*.*") do if exist "%%~j" (
  for /D %%k in ("%%~j\AppData\Local\%~1"                             ) do call Directory Delete "%%~k"
  for /D %%k in ("%%~j\AppData\Local\VirtualStore\Windows\AppData\%~1") do call Directory Delete "%%~k"
  for /D %%k in ("%%~j\AppData\LocalLow\%~1"                          ) do call Directory Delete "%%~k"
  for /D %%k in ("%%~j\AppData\Roaming\%~1"                           ) do call Directory Delete "%%~k"
  for /D %%k in ("%%~j\Application Data\%~1"                          ) do call Directory Delete "%%~k"
  for /D %%k in ("%%~j\Local Settings\%~1"                            ) do call Directory Delete "%%~k"
  for /D %%k in ("%%~j\Local Settings\Application Data\%~1"           ) do call Directory Delete "%%~k"
)
if defined ProgramData for /D %%i in ("%PROGRAMDATA%\%~1"       ) do call Directory Delete "%%~i"
if defined SystemRoot  for /D %%i in ("%SYSTEMROOT%\AppData\%~1") do call Directory Delete "%%~i"
exit /B

:DelDirInCommonProgs
if "%~1"=="" exit /B 1
for /D %%i in ("%COMMONPROGRAMFILES: (x86)=%" "%COMMONPROGRAMFILES(x86)%") do ^
if exist "%%~i" call Directory Delete "%%~i\%~1"
exit /B

:DelDirInFirefoxProfiles
if "%~1"=="" exit /B 1
for /D %%i in (%APPDATA%\Mozilla\Firefox\Profiles\*) do ^
if exist "%%~i" call Directory Delete "%%~i\%~1"
exit /B

:DelDirInProgs
if "%~1"=="" exit /B 1
for /D %%i in ("%PROGRAMFILES: (x86)=%" "%PROGRAMFILES(x86)%") do ^
if exist "%%~i" call Directory Delete "%%~i\%~1"
exit /B


:DelFileInAppData
if "%~1"=="" exit /B 1
setlocal
cd>nul 2>nul /D "%SYSTEMDRIVE%\Users" || ^
cd>nul 2>nul /D "%SYSTEMDRIVE%\Documents and Settings" || exit /B 1
for /D %%i in ("All Users" "Default" "Public" "Администратор" "*.*") do (
  if exist "%%~i" call File Delete "%%~i\AppData\Local\%~1"
  if exist "%%~i" call File Delete "%%~i\AppData\Local\VirtualStore\Windows\AppData\%~1"
  if exist "%%~i" call File Delete "%%~i\AppData\LocalLow\%~1"
  if exist "%%~i" call File Delete "%%~i\AppData\Roaming\%~1"
  if exist "%%~i" call File Delete "%%~i\Application Data\%~1"
  if exist "%%~i" call File Delete "%%~i\Local Settings\%~1"
  if exist "%%~i" call File Delete "%%~i\Local Settings\Application Data\%~1"
)
if defined ProgramData call File Delete "%PROGRAMDATA%\%~1"
if defined SystemRoot  call File Delete "%SYSTEMROOT%\AppData\%~1"
endlocal
exit /B

:DelFileInCommonProgs
if "%~1"=="" exit /B 1
for /D %%i in ("%COMMONPROGRAMFILES: (x86)=%" "%COMMONPROGRAMFILES(x86)%") do ^
if exist "%%~i" call File Delete "%%~i\%~1"
exit /B

:DelFileInProgs
if "%~1"=="" exit /B 1
for /D %%i in ("%PROGRAMFILES: (x86)=%" "%PROGRAMFILES(x86)%") do ^
if exist "%%~i" call File Delete "%%~i\%~1"
exit /B

:DelFileInStartMenu
if "%~1"=="" exit /B 1
for /D %%i in ("%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu" "%APPDATA%\Microsoft\Windows\Start Menu") do ^
if exist "%%~i" call File Delete "%%~i\%~1"
exit /B

:DelFileInSystem
if "%~1"=="" exit /B 1
for /D %%i in ("%SYSTEMROOT%" "%SYSTEMROOT%\SYSTEM32" "%SYSTEMROOT%\SYSWOW64") do ^
if exist "%%~i" call File Delete "%%~i\%~1"
exit /B

:DelShortcuts
if "%~1"=="" exit /B 1
setlocal
cd>nul 2>nul /D "%SYSTEMDRIVE%\Users" || ^
cd>nul 2>nul /D "%SYSTEMDRIVE%\Documents and Settings" || exit /B 1
for /D %%i in ("All Users" "Default" "Public" "Администратор" "*.*") do (
  if exist "%%~i" call Directory Delete "%%~i\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\%~1"
  if exist "%%~i" call Directory Delete "%%~i\AppData\Roaming\Microsoft\Windows\Start Menu\%~1"
  if exist "%%~i" call Directory Delete "%%~i\Microsoft\Windows\Start Menu\Programs\%~1"
  if exist "%%~i" call Directory Delete "%%~i\Microsoft\Windows\Start Menu\%~1"
  if exist "%%~i" call Directory Delete "%%~i\Главное меню\Программы\%~1"
  if exist "%%~i" call Directory Delete "%%~i\Главное меню\%~1"
  if exist "%%~i" call File      Delete "%%~i\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\%~1.lnk"
  if exist "%%~i" call File      Delete "%%~i\AppData\Roaming\Microsoft\Windows\Start Menu\%~1.lnk"
  if exist "%%~i" call File      Delete "%%~i\Microsoft\Windows\Start Menu\Programs\%~1.lnk"
  if exist "%%~i" call File      Delete "%%~i\Microsoft\Windows\Start Menu\%~1.lnk"
  if exist "%%~i" call File      Delete "%%~i\Главное меню\Программы\%~1.lnk"
  if exist "%%~i" call File      Delete "%%~i\Главное меню\%~1.lnk"
  if exist "%%~i" call File      Delete "%%~i\Desktop\%~1.lnk"
  if exist "%%~i" call File      Delete "%%~i\Рабочий стол\%~1.lnk"
  if exist "%%~i" call File      Delete "%%~i\Application Data\Microsoft\Internet Explorer\Quick Launch\%~1.lnk"
  if exist "%%~i" call File      Delete "%%~i\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\%~1.lnk"
  if exist "%%~i" call File      Delete "%%~i\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\%~1.lnk"
)
endlocal
exit /B

:Finish
