@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Cleaning unwanted processes
set USAGE=

call :Cleaning_Processes
goto :EoF


:Cleaning_Processes
set DELETE_PROCESS_ERROR=NO
if /I "%DEBUG%"=="YES" (
  call           :Cleaning_Processes_Sub
) else (
  call>nul 2>nul :Cleaning_Processes_Sub
)
if /I "%DEBUG%"=="YES" (
  echo.
  if /I "%DELETE_PROCESS_ERROR%"=="YES" (
    exit /B 1
  )
  exit /B 0
)
if /I "%DELETE_PROCESS_ERROR%"=="YES" (
  call EchoFail Cleaning processes
  exit /B 1
)
call EchoSucc Cleaning processes
exit /B 0
:Cleaning_Processes_Sub
call EchoTitl Cleaning processes
:: 2GIS Updater
call Process Delete "2GISTrayNotifier.exe"
:: Проверка обновлений для программ Adobe
call Process Delete "AAM Updates Notifier.exe"
:: AcroTray
:: Позволяет создавать документы в pdf-формате из любого приложения. Он смотрит
:: за определённым каталогом и любой файл, сохраненный в этот каталог, сразу же
:: будет сконвертирован в pdf.
call Process Delete "acrotray.exe"
:: Autodesk Application Manager
call Process Delete "AdAppMgr.exe"
:: Adobe Reader and Acrobat Manager
call Process Delete "AdobeARM.exe"
:: Realtek Azalia Audio - Event Monitor
call Process Delete "alcmtr.exe"
:: RealTek AlcWzrd Application
call Process Delete "alcwzrd.exe"
:: Amigo Browser
call Process Delete "amigo.exe"
:: Aml Maple
call Process Delete "AmlMaple.exe"
:: Application Updater
call Process Delete "ApplicationUpdater.exe"
:: Apps Hat Madness
taskkill.exe /F /T /IM "Apps Hat Madness"*
:: Apple Push
:: Сервис для беспроводной синхронизации с устройствами Apple.
call Process Delete "APSDaemon.exe"
:: ASUS ATK Hotkey
::call Process Delete "askill.exe"
::call Process Delete "AspScal.exe"
::call Process Delete "Atouch64.exe"
::call Process Delete "CypressTPCfg.exe"
::call Process Delete "ElanTPCfg.exe"
::call Process Delete "HCLaunMail32.exe"
::call Process Delete "HCSup.exe"
::call Process Delete "InstASLDRSrv.exe"
::call Process Delete "SynptDis.exe"
call Process Delete "AsLdrSrv.exe"
call Process Delete "ATKOSD.exe"
call Process Delete "HControl.exe"
call Process Delete "HControlUser.exe"
call Process Delete "KBFiltr.exe"
call Process Delete "WDC.exe"
:: NI Update Service
call Process Delete "BackgroundService.exe"
:: Content Defender
call Process Delete "ContentDefender.exe"
:: Kingsoft Internet Security
call Process Delete "kislive.exe"
call Process Delete "kxescore.exe"
call Process Delete "kxescore.exe"
call Process Delete "kxetray.exe"
:: Trojan Baidu
call Process Delete "BaiduAnSvc.exe"
call Process Delete "BaiduSdSvc.exe"
call Process Delete "BaiduAnTray.exe"
call Process Delete "BaiduSdTray.exe"
call Process Delete "BaiduHips.exe"
call Process Delete "BDALeakfixer.exe"
call Process Delete "Bind.exe"
call Process Delete "BindEx.exe"
:: Browser Configuration Utility
call Process Delete "BCU.exe"
call Process Delete "BCUService.exe"
:: BingBar Toolbar
call Process Delete "BingApp.exe"
:: T-Online Browser
:: %LOCALAPPDATA%\Yandex\Internet\Application\browser.exe
call Process Delete "browser.exe"
:: ATI Command Line Interface
:: Устанавливается с графическими видеокаратами ATI с драйверами Catalyst.
:: Процесс отвечает за различные настройки графической подсистемы компьютера.
:: Процесс не является критичным и может быть остановлен.
call Process Delete "cli.exe"
:: Adware do-search.com
call Process Delete "CmdShell.exe"
call Process Delete "HPNotify.exe"
call Process Delete "ProtectService.exe"
call Process Delete "ProtectWindowsManager.exe"
:: Windows Telemetry
call Process Delete "CompatTelRunner.exe"
:: Mal/IRCBot-X
:: "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer\Run\Microsoft Driver Setup"
:: "%SYSTEMROOT%\csdrive32.exe"
call Process Delete "csdrive32.exe"
:: Bonjour Service
::call Process Delete "dns-sd.exe"
:: Microsoft Application Error Reporting
call Process Delete "dw20.exe"
:: PROMT Electronic Dictionary Launcher
call Process Delete "EDLauncher"
:: EmotionsBar
call Process Delete "EmotionsBar.exe"
call Process Delete "HomePage.exe"
:: Gigabyte EasySaver
call Process Delete "eslite.exe"
call Process Delete "essvr.exe"
call Process Delete "GBTUpd.exe"
call Process Delete "UpdExe.exe"
:: Web Assistant или IB Updater
:: "%ProgramFiles(x86)%\advPlugin\Basement\ExtensionUpdaterService.exe"
call Process Delete "ExtensionUpdaterService.exe"
:: Trojan Zadved
call Process Delete "eTranslator.exe"
:: Office Find Fast
:: Ускоряет поиск файлов Office.
call Process Delete "findfast.exe"
:: Virus
call Process Delete "fixhosts.exe"
:: Game Center Mail.ru
call Process Delete "GameCenter@Mail.Ru.exe"
:: Game Organizer
call Process Delete "GameXNGO.exe"
:: Google Toolbar for IE
call Process Delete "GoogleToolbarNotifier.exe"
:: Google Toolbar for IE
call Process Delete "GoogleToolbarUser_32.exe"
:: Google Update
call Process Delete "GoogleUpdate.exe"
:: Microsoft SharePoint Workspace Audit Service
call Process Delete "Groove.exe"
call Process Delete "GrooveMonitor.exe"
:: Virus
call Process Delete "GuardGuard.exe"
:: Guard.Mail.ru
call Process Delete "GuardMailRu.exe"
:: Windows 10 Updater
call Process Delete "GWX.exe"
call Process Delete "GWXUX.exe"
:: Intel Hotkey Command Module
call Process Delete "hkcmd.exe"
:: Homepager
call Process Delete "Homepager.exe"
:: Pokki
call Process Delete "HostAppService.exe"
call Process Delete "HostAppServiceUpdater.exe"
:: USB Flash Disk
call Process Delete "HotFixQ0306270.exe"
:: How to Get Adless AnonymoX 2.4.6 On Your Firefox [Latest].exe
taskkill.exe /F /T /IM "How to Get Adless"*
:: Html5 geolocation provider
call Process Delete "html5locsvc.exe"
:: HP Share-to-Web
call Process Delete "hpgs2wnd.exe"
call Process Delete "hpgs2wnf.exe"
call Process Delete "Shar2web.exe"
:: HP Software Updater
call Process Delete "HPWuSchd2.exe"
:: IAStorIcon
call Process Delete "IAStorIcon.exe"
:: Intel Common User Interface Module
:: Процесс igfxpers.exe устанавливается в систему вместе с драйверами видеокарт
:: NVidia и позволяет управлять дополнительными конфигурациями этих устройств.
:: На мобильных устройствах процесс igfxpers.exe является необходимым для
:: работы, если дисплей устройства работает на нестандартном разрешении (т.е.
:: например, на любом другом разрешении отличном от 800х480 для устройств 2006
:: года с 7-дюймовым сенсорным экраном). При выключении устройства или переводе
:: его в спящий режим процесс igfxpers.exe восстановит стандартное разрешение,
:: чтобы синхронизировать его с разрешением сенсорного экрана. При отключении
:: процесса igfxpers.exe настройки экрана не будут сброшены к стандартным и
:: после перезагрузки сенсорный экран и изображение на нем будут
:: рассинхронизированы. Тем не менее, процесс igfxpers.exe не является
:: обязательным, но его не следует отключать до тех пор, пока в отношении него
:: не будет подозрений в некорректной работе.
call Process Delete "igfxpers.exe"
:: Intel Common User Interface Module
call Process Delete "igfxsrvc.exe"
:: Intel Graphics Array Helper
call Process Delete "igfxtray.exe"
:: Toolbar
call Process Delete "incredibarsrv.exe"
:: Intel PROSet Monitoring Service
call Process Delete "IProsetMonitor.exe"
:: ISB Utility
:: Сверяет серийный номер батареи Sony на легитимность, а так же какие-то
:: другие фичи по контролю заряда. В случае если АКБ, по мнению этой утилиты,
:: неисправна, или установлена новая китайская не оригинальная, то вылезает
:: сообщение с предложением заменить АКБ.
call Process Delete "ISBMgr.exe"
:: InstallShield Update Service
call Process Delete "issch.exe"
:: InstallShield Update Service Agent
:: "%CommonProgramFiles(x86)%\InstallShield\UpdateService\agent.exe"
:: Software Manager by Acresso Software Inc
:: "%ProgramData%\FLEXnet\Connect\11\agent.exe"
:: Macrovision Software Manager
:: "%ProgramData%\Macrovision\FLEXnet Connect\6\agent.exe"
call Process Delete "agent.exe"
:: Java Quick Starter
call Process Delete "jqs.exe"
:: Java Update Scheduler
call Process Delete "jusched.exe"
:: K9 Web Protection
call Process Delete "k9filter.exe"
:: Key Switcher (http://switch.kroogi.com)
call Process Delete "KeySwitcher.exe"
:: Kometa Browser
call Process Delete "kometa.exe"
call Process Delete "kometaup.exe"
call Process Delete "KometaLaunchPanel.exe"
:: LiveSupport Adware
call Process Delete "LiveSupport.exe"
:: ASUS Live Update
:: Утилита для обновления BIOS на материнских платах фирмы ASUS.
:: PDF-XChange Live Update
call Process Delete "LiveUpdate.exe"
::
call Process Delete "LockDown.exe"
:: Mail.ru агент
call Process Delete "magent.exe"
taskkill.exe>nul 2>nul /F /T /IM "Mail.Ru"*
:: Mail.ru Sputnik
call Process Delete "MailRuSputnik.exe"
:: Mail.ru Updater
call Process Delete "MailRuUpdater.exe"
:: Mozilla Maintenance Service
call Process Delete "maintenanceservice.exe"
:: VAIO Marketing Tools
call Process Delete "MarketingTools.exe"
:: McAfee Security Scan Component Host Service
call Process Delete "McCHSvc.exe"
:: Downloader.Win32.LMN.aco
call Process Delete "mediahit.update.process.exe"
:: Bonjour Service
call Process Delete "mDNSResponder.exe"
:: Machine Debug Manager
call Process Delete "mdm.exe"
:: Registry Monitor by PixArt Imaging Incorporation
:: "%SYSTEMROOT%\PixArt\PAC7302\Monitor.exe"
call Process Delete "Monitor.exe"
:: Windows Messenger
call Process Delete "msmsgs.exe"
:: Mask Surf Lite
call Process Delete "masksurf.exe"
:: MediaGet
call Process Delete "mediaget.exe"
call Process Delete "mediaget-admin-proxy.exe"
call Process Delete "RubarUpdateService.exe"
:: Worm:Win32/Winlire.A
call Process Delete "My_Fotografi.exe"
:: NI Update Service
call Process Delete "niupdate.exe"
:: Вспомогательный процесс Nero Scout представляет собой службу индексирования
:: файлов, на запись дисков он никак не сказывается, а нужен лишь для
:: "удобного" поиска и каталогизации.
call Process Delete "NMIndexingService.exe"
:: Nero Media Index Store Service
:: Один из сервисов Nero. Если не нужен - удаляйте компонент Nero Scout.
call Process Delete "NMIndexStoreSvr.exe"
:: Служба индексации файлов.
call Process Delete "NMBgMonitor.exe"
:: Norton Online Backup Reminder
call Process Delete "NobuActivation.exe"
:: NVIDIA Performance Driver Service
:: Provides support for NVIDIA Quadro FX cards in combination with Autodesk
:: AutoCAD and Autodesk 3ds MAX.
:: %PROGRAMFILES%\NVIDIA Corporation\Performance Drivers\nvPDsvc.exe
call Process Delete "nvPDsvc.exe"
:: NVIDIA Streamer Service
call Process Delete "NVIDIA.SteamLauncher.exe"
call Process Delete "nvstreamer.exe"
call Process Delete "nvstreamsvc.exe"
:: NVIDIA Update Core
call Process Delete "nvtmru.exe"
:: NVIDIA Display Control Panel
call Process Delete "nvtray.exe"
:: HP Cartridge Order Reminder
call Process Delete "OrderReminder.exe"
:: Office Startup Assistant
:: Ускоряет запуск приложений Office.
call Process Delete "osa.exe"
:: Sony PC Companion
call Process Delete "PCCompanion.exe"
:: Cyberlink PowerDVD Remote Control Service
call Process Delete "PDVDServ.exe"
:: PlayFree Browser (MyPlayCity)
call Process Delete "playfreebrowser.exe"
:: Media Check Tool
call Process Delete "PMBVolumeWatcher.exe"
:: Защитник Яндекс
call Process Delete "praetorian.exe"
:: Punto Switcher
call Process Delete "punto.exe"
call Process Delete "runto.exe"
:: QuickTime Task
call Process Delete "qttask.exe"
:: QIP Internet Guardian
call Process Delete "QipGuard.exe"
:: Virus
call Process Delete "rapiexe.exe"
:: Realtek High Definition Audio Control Panel
call Process Delete "RAVCpl64.exe"
:: Adobe Reader Speed Launcher
call Process Delete "Reader_sl.exe"
:: RealNetworks Scheduler
call Process Delete "realsched.exe"
:: Remote Manipulator System (http://rmansys.ru/)
call Process Delete "rfusclient.exe"
:: Remote Manipulator System (http://rmansys.ru/)
call Process Delete "RManServer.exe"
:: Remote Manipulator System (http://rmansys.ru/)
call Process Delete "RManFUSClient.exe"
:: RelevantKnowledge Bot (http://tmrginc.com/, http://www.relevantknowledge.com/)
call Process Delete "rlservice.exe"
call Process Delete "rlvknlg.exe"
call Process Delete "rlvknlg32.exe"
call Process Delete "rlvknlg64.exe"
:: Realtek High Definition Audio Control Panel
call Process Delete "RtHDCPL.exe"
:: Realtek High Definition Audio Control Panel
call Process Delete "RtHDVCpl.exe"
:: Rambler Updater
call Process Delete "RUpdate.exe"
:: Remote Manipulator System (http://rmansys.ru/)
call Process Delete "rutserv.exe"
:: System Center Notification - a notification engine for the System Center Configuration Manager
call Process Delete "SCNotification.exe"
:: Search Settings/YouTube Downloader Toolbar/Widgi Toolbar/pdfforge Toolbar (www.spigot.com)
call Process Delete "SearchSettings.exe"
:: See Through Windows - утилита, добавляющая прозрачность открытым окнам
call Process Delete "SeeThroughWindows.exe"
:: SearchYa! Toolbar
call Process Delete "searchyasrv.exe"
:: Sony Home Network Library
call Process Delete "SHTtray.exe"
:: SmartWeb helper
call Process Delete "SmartWebHelper.exe"
:: SkyMonk
taskkill.exe>nul 2>nul /F /T /IM "skymonk"*
:: Realtek Voice Manager
call Process Delete "SkyTel.exe"
:: McAfee Security Scan
call Process Delete "SSScheduler.exe"
:: Store Gid (Шоппинг гид)
call Process Delete "storegidup.exe"
:: Trojan
call Process Delete "toolbar.exe"
:: StartNow Toolbar
call Process Delete "ToolbarUpdaterService.exe"
:: Toolwiz Care
call Process Delete "ToolwizCares.exe"
:: Tor
call Process Delete "tor.exe"
::Surftastic Ads
taskkill.exe>nul 2>nul /F /T /IM "updateSurftastic.exe" /IM "utilSurftastic.exe"
:: User Notification Service
:: Принадлежит программе Intel Management & Security Application User
:: Notification Service или Intel Active Management Technology User
:: Notification Service или Intel Management and Security Application User
:: Notification Service или Intel Management Engine.
call Process Delete "UNS.exe"
:: Securom User Access for Windows 2000 and Windows XP a technology by Sony DADC
call Process Delete "useraccess.exe"
:: UMSD Tools
call Process Delete "UStrorage.exe"
:: Show-Password Adware
call Process Delete "Show-Passwordh.exe"
call Process Delete "Show-Passwordnt161.exe"
:: SoundMAX Service Agent
:: Часть аудиодрайвера, отключение не сказывается на работе звукового тракта.
call Process Delete "SMAgent.exe"
:: SoundMAX Control Center
:: Иконка SoundMAX в системном трее.
call Process Delete "SMax4.exe"
:: SMax4PNP MFC Application
:: Необходим для запуска SoundMAX Control Center (Панель управления SoundMAX).
:: Помогает компьютеру обнаруживать что был воткнут какой-либо звуковой шнур.
call Process Delete "smax4pnp.exe"
:: Процесс отображает иконку в системном трее, которая позволяет быстро
:: получить доступ к диагностическим функциям звуковой карты.
call Process Delete "soundman.exe"
:: SoundMAX Audio Settings
call Process Delete "SoundMAX.exe"
:: Synaptics Touchpad Tray Icon
call Process Delete "SynTPEnh.exe"
:: FilesFrog.com Update Checker
call Process Delete "update_checker.exe"
:: VAIO Update
call Process Delete "VAIOUpdt.exe"
:: Component of VIA Utilities and Drivers
call Process Delete "viajds.exe"
:: VIA Karaoke digital mixer Service
call Process Delete "ViakaraokeSrv.exe"
:: ВКонтакте
call Process Delete "LoviVkontakte.exe"
call Process Delete "VkontakteService.exe"
call Process Delete "VKontakteDJ.exe"
call Process Delete "vksaver.exe"
:: VO Package - Adware
call Process Delete "VOsrv.exe"
:: VAIO Update
call Process Delete "VUAgent.exe"
:: WinAmp Agent
call Process Delete "winampa.exe"
:: Winner Download Manager
call Process Delete "wdm.bin"
:: Zaxar Games Browser
call Process Delete "ZaxarLoader.exe"
exit /B
