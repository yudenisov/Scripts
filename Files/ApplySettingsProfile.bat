@echo off
set PATH=%SystemRoot%\SYSTEM32;%SystemRoot%;%SystemRoot%\SYSTEM32\WBEM;

set  HELP=Apply settings profile
set USAGE=[home/work]

call :Set_Profile "%~1"
goto :EoF


:Set_Profile
:: *** Set variable OS_CORE ***
set OS_CORE=
call CheckOSType|%SystemRoot%\System32\find.exe>nul 2>nul /I "Core" && set OS_CORE=YES

:: *** Set variable OS_SERVER ***
set OS_SERVER=
call CheckOSType|%SystemRoot%\System32\find.exe>nul 2>nul /I "Server" && set OS_SERVER=YES

:: *** Set variable OS_WINXP ***
set OS_WINXP=
call CheckOSType|%SystemRoot%\System32\find.exe>nul 2>nul /I "Windows XP" && set OS_WINXP=YES

:: *** Set variable OS_WIN8 ***
set OS_WIN8=
call CheckOSType|%SystemRoot%\System32\find.exe>nul 2>nul /I "Windows 8" && set OS_WIN8=YES

:: *** Set variable OS_PROFILE ***
set OS_PROFILE=WORK
if /I "%~1"==""  if exist "%SystemRoot%\osprofile.txt" set /P OS_PROFILE=<"%SystemRoot%\osprofile.txt"
if /I "%~1"=="HOME"        set OS_PROFILE=HOME
if /I "%OS_SERVER%"=="YES" set OS_PROFILE=WORK
echo>"%SystemRoot%\osprofile.txt" %OS_PROFILE%

:: *** Set variable SVC_SPOOLER ***
::set SVC_SPOOLER=
::call ShowPrinters "Real"|%SystemRoot%\System32\find.exe>nul 2>nul /I """" && set SVC_SPOOLER=YES
::if /I "%OS_PROFILE%"=="WORK"                           set SVC_SPOOLER=YES

:: *** Begin ***
call EchoTitl Apply settings profile "%OS_PROFILE%"

:: *** Services ***
                                         call Svc Disable "2GISUpdateService"
                                         call Svc Disable "4game-service"
                                         call Svc Disable "AdAppMgrSvc"
                                         call Svc Disable "AdobeARMservice"
                                         call Svc Disable "AdobeFlashPlayerUpdateSvc"
                                         call Svc Auto    "ADWS"
                                         call Svc Demand  "AppIDSvc"
                                         call Svc Demand  "AppMgmt"
                                         call Svc Disable "Application Updater"
                                         call Svc Demand  "AeLookupSvc"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "Alerter"
if /I "%OS_PROFILE%"=="WORK"             call Svc Auto    "Alerter"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "ALG"
if /I "%OS_PROFILE%"=="WORK"             call Svc Demand  "ALG"
                                         call Svc Disable "AMD External Events Utility"
                                         call Svc Disable "AnviCsbSvc"
                                         call Svc Demand  "AppInfo"
                                         call Svc Demand  "Apple Mobile Device"
                                         call Svc Disable "aspnet_state"
                                         call Svc Disable "ATI External Events Utility"
if /I "%OS_SERVER%"==""                  call Svc Auto    "AudioSrv"
if /I "%OS_SERVER%"=="YES"               call Svc Disable "AudioSrv"
                                         call Svc Disable "BaiduHips"
                                         call Svc Disable "BBSvc"
                                         call Svc Disable "BBUpdate"
                                         call Svc Disable "bckd"
                                         call Svc Disable "bckwfs"
                                         call Svc Disable "BCUService"
                                         call Svc Disable "bd0001"
                                         call Svc Disable "bd0002"
                                         call Svc Disable "bd0003"
                                         call Svc Disable "bd0004"
                                         call Svc Disable "BDArKit"
                                         call Svc Disable "BDDefence"
                                         call Svc Disable "BDSafeBrowser"
                                         call Svc Disable "BDSGRTP"
                                         call Svc Disable "BDKVRTP"
                                         call Svc Disable "BDMNetMon"
                                         call Svc Disable "BDMRTP"
                                         call Svc Disable "BDMWrench"
                                         call Svc Disable "BDMWrench_x64"
                                         call Svc Demand  "BITS"
                                         call Svc Demand  "Bonjour Service"
if /I "%OS_CORE%"=="YES"                 call Svc Disable "CcmExec"
                                         call Svc Disable "Changer"
                                         call Svc Disable "CiSvc"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "ClipSrv"
if /I "%OS_PROFILE%"=="WORK"             call Svc Auto    "ClipSrv"
                                         call Svc Disable "clr_optimization_v2.0.50727"
                                         call Svc Disable "clr_optimization_v2.0.50727_32"
                                         call Svc Disable "clr_optimization_v2.0.50727_64"
                                         call Svc Disable "clr_optimization_v4.0.30319_32"
                                         call Svc Disable "clr_optimization_v4.0.30319_64"
                                         call Svc Disable "CltMngSvc"
if /I "%OS_CORE%"=="YES"                 call Svc Disable "CmRcService"
                                         call Svc Disable "Com4QLBEx"
                                         call Svc Disable "comyninu"
                                         call Svc Disable "ContentDefender"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "CryptSvc"
if /I "%OS_PROFILE%"=="WORK"             call Svc Auto    "CryptSvc"
                                         call Svc Auto    "CscService"
                                         call Svc Demand  "defragsvc"
                                         call Svc Auto    "DcomLaunch"
                                         call Svc Auto    "Dhcp"
                                         call Svc Auto    "dmserver"
                                         call Svc Auto    "Dnscache"
                                         call Svc Auto    "DPS"
                                         call Svc Disable "DWMRCS"
                                         call Svc Disable "ehSched"
                                         call Svc Disable "ERSvc"
                                         call Svc Disable "ES lite Service"
                                         call Svc Auto    "eventlog"
                                         call Svc Auto    "EventSystem"
                                         call Svc Disable "FastUserSwitchingCompatibility"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "Fax"
if /I "%OS_PROFILE%"=="WORK"             call Svc Demand  "Fax"
                                         call Svc Demand  "FontCache"
                                         call Svc Disable "FontCache3.0.0.0"
                                         call Svc Disable "gopibeko"
                                         call Svc Auto    "gpsvc"
                                         call Svc Disable "Guard.Mail.ru"
                                         call Svc Disable "gupdate"
                                         call Svc Disable "gupdatem"
                                         call Svc Disable "gusvc"
                                         call Svc Disable "HelpSvc"
if /I "%OS_SERVER%"==""                  call Svc Demand  "HidServ"
if /I "%OS_SERVER%"=="YES"               call Svc Disable "HidServ"
                                         call Svc Disable "HomeGroupListener"
                                         call Svc Disable "HomeGroupProvider"
                                         call Svc Auto    "HPSIService"
                                         call Svc Disable "HWDeviceService.exe"
                                         call Svc Disable "hyverumu"
                                         call Svc Disable "i2omgmt"
                                         call Svc Disable "IAANTMON"
                                         call Svc Disable "ICQ Service"
                                         call Svc Disable "IHProtect Service"
                                         call Svc Disable "idsvc"
                                         call Svc Demand  "igfxCUIService1.0.0.0"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "ImapiService"
if /I "%OS_PROFILE%"=="WORK"             call Svc Demand  "ImapiService"
                                         call Svc Disable "Intel(R) Capability Licensing Service Interface"
                                         call Svc Disable "iPod Service"
                                         call Svc Disable "JavaQuickStarterService"
                                         call Svc Disable "jhi_service"
                                         call Svc Disable "jizirexy"
                                         call Svc Auto    "LanmanServer"
                                         call Svc Auto    "LanmanWorkstation"
                                         call Svc Disable "lbrtfdc"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "lmhosts"
if /I "%OS_PROFILE%"=="WORK"             call Svc Auto    "lmhosts"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "lpasvc"
if /I "%OS_PROFILE%%OS_CORE%"=="WORKYES" call Svc Disable "lpasvc"
if /I "%OS_PROFILE%%OS_CORE%"=="WORK"    call Svc Demand  "lpasvc"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "lppsvc"
if /I "%OS_PROFILE%%OS_CORE%"=="WORKYES" call Svc Disable "lppsvc"
if /I "%OS_PROFILE%%OS_CORE%"=="WORK"    call Svc Demand  "lppsvc"
                                         call Svc Disable "McComponentHostService"
                                         call Svc Disable "MDM"
                                         call Svc Disable "MegaFon Modem. RunOuc"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "Messenger"
if /I "%OS_PROFILE%"=="WORK"             call Svc Auto    "Messenger"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "Microsoft SharePoint Workspace Audit Service"
                                         call Svc Disable "mnmsrvc"
                                         call Svc Disable "MozillaMaintenance"
                                         call Svc Disable "MPCKpt"
                                         call Svc Disable "MPCProtectService"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "MpsSvc"
if /I "%OS_PROFILE%"=="WORK"             call Svc Auto    "MpsSvc"
                                         call Svc Demand  "MSDTC"
                                         call Svc Demand  "msiserver"
                                         call Svc Disable "napagent"
                                         call Svc Disable "NAUpdate"
                                         call Svc Auto    "NetDDE"
                                         call Svc Demand  "Netman"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "Netlogon"
if /I "%OS_PROFILE%"=="WORK"             call Svc Auto    "Netlogon"
                                         call Svc Demand  "NisSrv"
                                         call Svc Auto    "Nla"
                                         call Svc Auto    "NlaSvc"
                                         call Svc Disable "NvStreamSvc"
                                         call Svc Demand  "NVSvc"
                                         call Svc Disable "nvUpdatusService"
                                         call Svc Demand  "ose"
                                         call Svc Demand  "osppsvc"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "p2psvc"
if /I "%OS_PROFILE%"=="WORK"             call Svc Demand  "p2psvc"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "p2pimsvc"
if /I "%OS_PROFILE%"=="WORK"             call Svc Demand  "p2pimsvc"
                                         call Svc Disable "PCIDump"
                                         call Svc Disable "PDCOMP"
                                         call Svc Disable "PDFRAME"
                                         call Svc Disable "PDRELI"
                                         call Svc Disable "PDRFRAME"
                                         call Svc Disable "PicexaService"
                                         call Svc Demand  "pla"
                                         call Svc Auto    "PlugPlay"
                                         call Svc Disable "PnkBstrA"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "PolicyAgent"
if /I "%OS_PROFILE%"=="WORK"             call Svc Demand  "PolicyAgent"
if /I "%OS_CORE%"==""                    call Svc Demand  "ProtectedStorage"
if /I "%OS_CORE%"=="YES"                 call Svc Disable "ProtectedStorage"
                                         call Svc Disable "QipGuard"
                                         call Svc Disable "qrnfd_1_10_0_12"
                                         call Svc Demand  "RapiMgr"
                                         call Svc Demand  "RasAuto"
                                         call Svc Demand  "RasMan"
                                         call Svc Demand  "RpcLocator"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "RemoteRegistry"
if /I "%OS_PROFILE%"=="WORK"             call Svc Auto    "RemoteRegistry"
                                         call Svc Disable "ROMService_Support"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "SamSs"
if /I "%OS_PROFILE%"=="WORK"             call Svc Auto    "SamSs"
                                         call Svc Auto    "SCardSvr"
                                         call Svc Auto    "Schedule"
                                         call Svc Demand  "SDRSVC"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "SecLogon"
if /I "%OS_PROFILE%"=="WORK"             call Svc Demand  "SecLogon"
                                         call Svc Auto    "SENS"
                                         call Svc Demand  "SensrSvc"
                                         call Svc Disable "servervo"
                                         call Svc Disable "SharedAccess"
                                         call Svc Auto    "ShellHWDetection"
                                         call Svc Disable "SkypeUpdate"
if /I "%OS_CORE%"=="YES"                 call Svc Disable "smstsmgr"
                                         call Svc Auto    "Spooler"
                                         call Svc Auto    "srservice"
                                         call Svc Demand  "Srv"
                                         call Svc Disable "STacSV"
                                         call Svc Auto    "stisvc"
                                         call Svc Demand  "SSDPSRV"
                                         call Svc Disable "SSUService"
                                         call Svc Disable "Stereo Service"
                                         call Svc Disable "SynTPEnhService"
                                         call Svc Demand  "TapiSrv"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "TermService"
if /I "%OS_PROFILE%"=="WORK"             call Svc Demand  "TermService"
                                         call Svc Auto    "Themes"
                                         call Svc Disable "TrkWks"
                                         call Svc Demand  "TrustedInstaller"
                                         call Svc Disable "UALSVC"
                                         call Svc Disable "UFDSVC"
                                         call Svc Disable "UI0Detect"
                                         call Svc Disable "UPHClean"
if /I "%OS_SERVER%"==""                  call Svc Demand  "upnphost"
if /I "%OS_SERVER%"=="YES"               call Svc Disable "upnphost"
                                         call Svc Disable "UserAccess"
                                         call Svc Demand  "w32time"
                                         call Svc Demand  "WcesComm"
                                         call Svc Disable "WDICA"
                                         call Svc Demand  "WdiSystemHost"
                                         call Svc Demand  "WebClient"
                                         call Svc Disable "VIAKaraokeService"
                                         call Svc Demand  "WinHttpAutoProxySvc"
                                         call Svc Auto    "Winmgmt"
if /I "%OS_SERVER%"==""                  call Svc Disable "WinRM"
if /I "%OS_SERVER%"=="YES"               call Svc Auto    "WinRM"
                                         call Svc Disable "WLTRYSVC"
                                         call Svc Disable "WmdmPMSN"
                                         call Svc Demand  "wmiApSrv"
                                         call Svc Disable "WMPNetworkSvc"
                                         call Svc Disable "WPCSvc"
                                         call Svc Demand  "WPDBusEnum"
                                         call Svc Disable "WPFFontCache_v0400"
                                         call Svc Disable "wscsvc"
if /I "%OS_PROFILE%"=="HOME"             call Svc Disable "WSearch"
if /I "%OS_PROFILE%"=="WORK"             call Svc Auto    "WSearch"
                                         call Svc Disable "vToolbarUpdater10.2.0"
                                         call Svc Disable "wsasvc_1.10.0.19"
                                         call Svc Demand  "wuauserv"
                                         call Svc Auto    "WZCSVC"
                                         call Svc Disable "xohisiwe"

:: *** RDP ***
if /I "%OS_PROFILE%"=="HOME"             call RDP "Disable"
if /I "%OS_PROFILE%"=="WORK"             call RDP "Enable"

:: *** Remote Access To PnP ***
if /I "%OS_PROFILE%"=="WORK"             call RemoteAccessToPnP "Enable"

:: *** Network Power Management ***
if /I "%OS_SERVER%"=="YES"               call NetPowerManagement "Disable"

:: *** Short File Names ***
if /I "%OS_SERVER%"=="YES"               call ShortFileNames "Disable"

:: *** Enable Windows XPx32 security updates ***
::if /I "%OS_WINXP%"=="YES"              call WinXPx32SecurityUpdates "Enable"

:: *** Set Timeout For LAN ***
if /I "%OS_PROFILE%"=="WORK"             call SetTimeoutForLAN "5"

:: *** Features ***
::call Feature Disable "InboxGames"
call Feature Disable "WindowsGadgetPlatform"
call Feature Enable  "TelnetClient"
if /I "%OS_CORE%"=="YES" (
  :: Для поддержки 32-битных приложений
  call Feature Enable "ServerCore-WOW64"
  :: Для поддержки 32-битных .NET-приложений
  call Feature Enable "NetFx2-ServerCore"
  call Feature Enable "NetFx3-ServerCore"
)
call Feature Enable "NetFx3"
:: *** Server settings ***
if /I "%OS_PROFILE%"=="WORK" (
  call>nul CheckDC                              && call :Is_DC
  call>nul Feature Check "DNS-Server-Full-Role" && call :Is_DNSServer
  call>nul Feature Check "DNS-Server-Core-Role" && call :Is_DNSServer
  call>nul TaskBackupDHCP "Delete"
  call>nul Feature Check "DHCPServer"           && call :Is_DHCPServer
  call>nul Feature Check "DHCPServerCore"       && call :Is_DHCPServer
  call Firewall "Disable"
)

:: *** Common Settings ***
call EnableRegEdit
call ImportProxySettingsFromIE
call IP6 "Disable"
call Hibernation "Disable"
call USBDevOnSoftRemove "Disable"
call DisableAutorunDrives
call DisableGWX
call CAD "Disable"
call ThumbCache "Disable"
call Thumbs "Enable"
call MobilityCenter "Enable"
call Account Delete "UpdatusUser"
call Account Activate "Administrator"
call CachingWDigest "Disable"
call LSASSProtection "Enable"
::call SetSRPPolicy "Unrestricted"
call SetUACPolicy "Enable"
call SetPasswordPolicy
call SetAttachManagerPolicy
call SetTCPIPParams
call SetIEParams
call SetTaskbarParams
call SetDesktopParams
call SetExplorerParams
call SetMenuParams
call SetBootParams
::call SetLayoutEn
call SetToggleCS
call SetNumLock "Off"
call SetTimeSyncParams
call SyncTime
::call RepairMSI
call RepairVBS
call RepairIcons
call CleanSoft
call CleanProcesses
call CleanFiles
call CleanHosts
call CleanRegistry
call CleanTasks
call CleanTemp
exit /B


:Is_DC
call CCM "Remove"
call SIADebugTracing "Disable"
call NetVisibility "Disable"
call StopReplicationOnAutoRecovery "Disable"
call SetLDAPBindParams "Default"
call Account Make       "DHCPDNSupd" "mEsIBynXb7OPwy"
call AddUserToDNSAdmins "DHCPDNSupd"
exit /B

:Is_DNSServer
if /I "%IS_DNSServer%"=="YES" exit /B
set IS_DNSServer=YES
call SetDNSServerParams
exit /B

:Is_DHCPServer
if /I "%IS_DHCPServer%"=="YES" exit /B
set IS_DHCPServer=YES
call SetDHCPDNSCredentials
call TaskBackupDHCP "Add"
exit /B


:: Настройка служб в windows 7 - http://w7q.ru/sluzhbyi-v-windows-7/

:: 2GISUpdateService
:: Служба для обновления ПО ООО ДубльГИС.

:: 4game-service
:: Responsible for installing, updating, repairing and uninstalling 4Game
:: software.

:: AdAppMgrSvc
:: Autodesk Application Manager
:: %Program Files(x86)%\Common Files\Autodesk Shared\AppManager\R1\AdAppMgrSvc.exe

:: AdobeARMservice
:: Adobe Acrobat Update Service (Служба обновления Adobe Acrobat)
:: Средство обновления Adobe Acrobat обеспечивает загрузку и установку
:: актуальных обновлений программы.

:: AdobeFlashPlayerUpdateSvc (Служба обновления Adobe Flash Player)
:: Adobe Flash Player Update Service
:: Поддерживает актуальность установки Adobe Flash Player с помощью последних
:: улучшений и исправлений системы безопасности.

:: ADWS
:: Active Directory Web Services (Веб-службы Active Directory)
:: Эта служба предоставляет интерфейс веб-службы для экземпляров службы
:: каталогов (AD DS и AD LDS), которые выполняются на сервере локально. Если
:: эта служба остановлена или отключена, клиентским приложениям, например,
:: Active Directory PowerShell, не предоставляются возможности доступа к
:: экземплярам службы каталогов, которые выполняются на сервере локально, или
:: управления ими.

:: aksfridge
:: Sentinel Fridge
:: SafeNet Inc. Sentinel Ancillary Function Driver
:: Драйвер: %SystemRoot%\System32\drivers\aksfridge.sys. Может вызывать BSOD.

:: AppIDSvc
:: Application Identity (Удостоверение приложения)
:: Определяет и проверяет удостоверение приложения. Отключение данной службы
:: делает невозможным принудительное применение политики AppLocker.
:: ПРИМЕЧАНИЕ: AppLocker работает только на версиях Windows 7 Максимальная и
:: Корпоративная. А на остальных версиях - нет.

:: AppMgmt
:: Application Management (Управление приложениями)
:: Обработка запросов на установку, удаление и построение списков для программ,
:: установленных через групповую политику. При отключении этой службы
:: пользователи не смогут устанавливать, удалять и создавать списки программ,
:: установленных через групповую политику.

:: Alerter
:: Alerter (Оповещатель)
:: Посылает выбранным пользователям и компьютерам административные оповещения.
:: Если служба остановлена, программа, использующая административные оповещения
:: их не получит. При обычных условиях эта служба не нужна.

:: ALG
:: Application Layer Gateway Service (Служба шлюза уровня приложения)
:: Оказывает поддержку протоколов третьей стороны протоколов PnP для общего
:: доступа к подключению к Интернету и подключений к Интернету с использованием
:: брандмауэра. Эта служба нужна при использовании Брандмауэра Интернета/Общего
:: доступа к Интернету для подключения к сети. Служба занимает около 1.5 Mb в
:: оперативной памяти. У кого нет сети можно отключить эту службу.

:: AMD External Events Utility
:: ATI External Events Utility
:: %SystemRoot%\SYSTEM32\atiesrxx.exe
:: Служба AMD/ATI External Events Utility отвечает за сбор и обработку внешних
:: событий. Данный сервис также отвечает за горячее подключение, а точнее
:: определение новых мониторов. Если он будет выключен, то при попытке
:: подсоединить дополнительный дисплей, драйвер его попросту не увидит,
:: потребуется перезагрузка системы.
:: Ещё раньше в Windows XP эта служба называлась ATI Hotkey Poller.

:: AnviCsbSvc
:: Anvi Cloud System Booster Speed Service

:: AppInfo
:: Application Information (Сведения о приложении)
:: Обеспечивает выполнение интерактивных приложений с дополнительными
:: административными привилегиями. Если эта служба будет остановлена,
:: пользователи не смогут запускать приложения с дополнительными
:: административными привилегиями, которые могут потребоваться для выполнения
:: нужных пользовательских заданий. Режим запуска по умолчанию: Вручную.

:: Apple Mobile Device
:: Сервис для подключения устройств Apple, устанавливается вместе с iTunes.

:: Application Updater
:: Хуйня какая-то.

:: aspnet_state
:: ASP.NET State Service
:: Provides support for out-of-process session states for ASP.NET. If this
:: service is stopped, out-of-process requests will not be processed. If this
:: service is disabled, any services that explicitly depend on it will fail to
:: start.

:: AudioSrv
:: Windows Audio (Центр Аудио Windows)
:: Управление звуковыми устройствами для Windows-программ. Если эта служба
:: остановлена, звуковые устройства и эффекты не будут работать должным
:: образом. Эта служба необходимо для воспроизведения ЛЮБОГО звука. Отключать
:: можно только при отсутствии звуковой карты, иначе вы не будете слышать звуки
:: вообще.

:: BBSvc
:: BBUpdate
:: BingBar Toolbar

:: bckd
:: bckwfs
:: K9 Web Protection
:: Родительский контроль и ограничение пользователей от нежелательного
:: контента.

:: BCUService
:: Browser Configuration Utility
:: Плагин-поисковик для браузеров, ставится с драйверами на материнскую плату.

:: BaiduHips
:: bd0001
:: bd0002
:: bd0003
:: BDKVRTP
:: BDMNetMon
:: BDMRTP
:: BDMWrench
:: Baidu Trojan

:: BITS
:: Background Intelligent Transfer Service (Фоновая интеллектуальная служба
:: передачи)

:: Bonjour Service
:: Позволяет автоматически обнаруживать и работать с сетевыми устройствами без
:: дополнительных настроек.

:: CcmExec
:: Узел агента SMS
:: Часть клиента Configuration Manager. Отвечает за установку обновлений к
:: различным программам на сетевых компьютерах.

:: CiSvc
:: CiSvc (Служба индексирования)
:: Индексирует содержимое и свойства файлов на локальном и удалённых
:: компьютерах, обеспечивает быстрый доступ к файлам с помощью гибкого языка
:: запросов.

:: ClipSrv
:: ClipSrv (Сервер папки обмена)
:: Позволяет просматривать страницы папок обмена удалённых компьютеров. Если
:: эта служба остановлена, программа просмотра страниц папок обмена не может
:: обмениваться информацией с удалёнными компьютерами. Если эта служба
:: отключена, любые службы, которые явно зависят от нее, не могут быть
:: запущены.

:: CltMngSvc
:: This service loads the Search Protector, which maintains your selected
:: Search settings, and enables auto-updates.

:: clr_optimization_v2.0.50727_32
:: clr_optimization_v2.0.50727_64
:: clr_optimization_v2.0.50727
:: .NET Runtime Optimization Service v2.0.50727_X86
:: Microsoft .NET Framework NGEN

:: CmRcService (Удалённое управление Configuration Manager)
:: Часть клиента Configuration Manager. Позволяет авторизованным пользователям
:: удалённо управлять системой.

:: Com4QLBEx
:: HP Quick Launch Buttons
:: Com4QLBEx is a part of the HP Quick Launch Buttons package which enables the
:: Quick Launch Buttons on the keyboard for easy control of various bezel
:: buttons such as volume, internal/external display, and mute on/off; HotKeys,
:: and Docked Events.

:: CryptSvc
:: Cryptographic Services (Службы криптографии)
:: Предоставляет три службы управления: службу баз данных каталога, которая
:: проверяет цифровые подписи файлов Windows; службу защищенного корня, которая
:: добавляет и удаляет сертификаты доверенного корня центра сертификации с
:: этого компьютера; и службу ключей, которая позволяет подавать заявки на
:: сертификаты с этого компьютера. Если эта служба остановлена, все эти службы
:: управления не будут работать. По сути, эта служба проверяет подписи файлов
:: Windows. Однако вы все равно можете получать окошко с предупреждением о
:: неподписанном драйвере. Эта служба необходима для обновления Windows в
:: ручном и автоматическом режимах, а также для инсталляции Service Pack'ов и
:: DirectX 9.0. Windows Media Player и некоторые .NET приложения могут
:: требовать эту службу для функционирования некоторых функций. Служба занимает
:: около 1.9 Мб в оперативной памяти.

:: CscService
:: Offline Files (Автономные файлы)
:: Обеспечивает различные функции обслуживания кэша оффлайн файлов. Большинству
:: пользователей, работающих на рабочих станциях, этот сервис не нужен.  Однако
:: подумайте дважды, прежде чем отключать этот сервис на ноутбуке. Возможно,  в
:: дальнейшем он вам пригодится. Рекомендуемый режим запуска:  "Автоматически",
:: иначе неправильно работают NAS (WD MyBook Live).

:: defragsvc
:: Disk Defragmenter (Дефрагментация диска)
:: Тип запуска: Вручную.

:: DcomLaunch
:: DCOM Server Process Launcher (Запуск серверных процессов DCOM)
:: Provides launch functionality for DCOM services

:: Dhcp
:: DHCP Client (DHCP-клиент)
:: Управляет конфигурацией сети посредством регистрации и обновления IP-адресов
:: и DNS-имен. Эта служба автоматически получает ваш динамический IP адрес от
:: вашего DHCP сервера и DNS обновлений. Необходима для ISC (интернет клиента)
:: и в случае, если у вас используется IPSEC. Может быть отключена на системах
:: со статическим ip-адресом. Примечание: Имейте ввиду, что многие DSL или
:: кабельные подключения требуют эту службу для предоставления доступа в
:: Интернет. Если вы отключите эту службу и ваше Интернет соединение перестанет
:: работать, то верните значение в Автоматически.

:: dmserver
:: Logical Disk Manager (Диспетчер логических дисков)
:: Обнаружение и наблюдение за новыми жесткими дисками и передача информации о
:: томах жестких дисков службе управления диспетчера логических дисков. Если
:: эта служба остановлена, состояние динамических дисков и информация о
:: конфигурации может оказаться устаревшей. Если эта служба отключена, любые
:: службы, которые явно зависят от нее, не могут быть запущены.

:: Dnscache
:: DNS Client (DNS-клиент)
:: Разрешает для данного компьютера DNS-имена в адреса и помещает их в кэш.
:: Если служба остановлена, не удастся разрешить DNS-имена и разместить службу
:: каталогов Active Directory контроллеров домена. Данная служба получает и
:: кеширует DNS имена и фнкции контроллера домена Active Directory. Однако, DNS
:: клиент необходим для IPSEC. Если вы пытаетесь "исправить" ваше сетевое
:: соединение и получаете диалоговое окно: "DNS resolver failed to flush the
:: cache", то данная служба является причиной возникновения данной ошибки.

:: DPS
:: Diagnostic Policy Service (Служба политики диагностики)

:: DWMRCS
:: DameWare Mini Remote Control
:: A component of the DameWare NT Utilities System Management Suite. The
:: DameWare Mini Remote Client Agent Service allows Administrators (or
:: authorized users) the ability to quickly provide Remote Assistance, by
:: interactively accessing the Desktop of a computer from a remote location.
:: Additional benefits include: Troubleshooting, Working from Home, System &
:: Application Configuration, Collaboration, or even Remote Instruction &
:: Teaching.

:: ehSched
:: Windows Media Center Scheduler Service (Служба планировщика Windows Media
:: Center)
:: Начало и остановка записи телепрограмм в Windows Media Center.

:: ERSvc
:: Error Reporting Service (Служба регистрации ошибок)
:: Позволяет регистрировать ошибки для служб и приложений, выполняющихся в
:: нестандартной среде. При возникновении ошибки отправляет информацию об
:: ошибке в корпорацию Microsoft. Я считаю, что это пустая трата памяти.
:: Однако, если ваша система постоянно "падает", то данная служба является
:: одним из лучших способов решить ваши проблемы.

:: ES lite Service
:: ES lite Service for program management
:: %ProgramFiles%\Gigabyte\EasySaver\essvr.exe

:: eventlog
:: Event Log (Журнал событий)
:: Обеспечивает поддержку сообщений журналов событий, выдаваемых
:: Windows-программами и компонентами системы, и просмотр этих сообщений. Эта
:: служба не может быть остановлена. C помощью данной службы можно посмотреть
:: какие программы "вылетают" при работе операционной системы, очень полезный
:: инструмент для опытного пользователя.

:: EventSystem
:: COM+ Event System (Система событий COM+)
:: Поддержка службы уведомления о системных событиях (SENS), обеспечивающей
:: автоматическое распространение событий подписавшимся компонентам COM. Если
:: данная служба остановлена, SENS будет закрыта и не сможет предоставлять
:: уведомления входа и выхода.

:: FastUserSwitchingCompatibility
:: Fast User Switching Compatibility (Совместимость быстрого переключения
:: пользователей)
:: Данная служба осуществляет управление приложениями, которые требуют
:: поддержки в многопользовательской среде. Службу имеет смысл включить, если в
:: вашей системе работает несколько пользователей, в противном случае нет
:: необходимости в запуске этой службы. Если вы все-таки решили включить
:: службу, то она позволит переключаться между пользователями без закрытия
:: работающих программ, что бывают очень удобно.

:: Fax
:: Fax (Факс)
:: Позволяет отправлять и получать факсы, используя ресурсы этого компьютера и
:: сетевые ресурсы.

:: FontCache
:: Windows Font Cache Service (Служба кэша шрифтов Windows)
:: Управляет системным и пользовательским кэшем шрифтов Windows.

:: FontCache3.0.0.0
:: Windows Presentation Foundation Font Cache 3.0.0.0 (Кэш шрифтов Windows
:: Presentation Foundation 3.0.0.0)
:: Оптимизирует производительность приложений Windows Presentation Foundation
:: (WPF) путем кэширования обычно используемых данных шрифтов. Приложения WPF
:: запускают эту службу, если она еще не запущена. Ее можно отключить, однако
:: это ухудшит производительность приложений WPF. WPF - графическая
:: (презентационная) подсистема в составе .NET Framework.

:: gpsvc
:: Group Policy Client (Клиент групповой политики)
:: Данная служба ответственна за применение параметров, определенных
:: администраторами для компьютеров и пользователей через компонент групповой
:: политики. Если эта служба остановлена или отключена, параметры не будут
:: применены. Также не будет возможно управление приложениями и компонентами
:: через групповую политику.

:: Guard.Mail.ru
:: Обеспечивает защиту настроек браузеров от несанкционированного изменения.

:: gupdate
:: Google Update Service (Служба Google Update (gupdate))
:: Обеспечивает обновление програм от Google - например, Picasa.
:: Следите за тем, чтобы ваше ПО Google всегда обновлялось. Если отключить или
:: остановить эту службу, ваше ПО Google не будет обновляться. Это может
:: поставить безопасность под угрозу, а также привести к тому, что некоторые
:: функции перестанут работать. Эта служба удаляется автоматически, если нет ПО
:: Google, которое ее использует.

:: gupdatem
:: Google Update Service (Служба Google Update (gupdatem))
:: Обеспечивает обновление програм от Google - например, Picasa.
:: Следите за тем, чтобы ваше ПО Google всегда обновлялось. Если отключить или
:: остановить эту службу, ваше ПО Google не будет обновляться. Это может
:: поставить безопасность под угрозу, а также привести к тому, что некоторые
:: функции перестанут работать. Эта служба удаляется автоматически, если нет ПО
:: Google, которое ее использует.

:: gusvc
:: Google Update Service (Служба обновлений Google)
:: Обеспечивает обновление програм от Google - например, Picasa.

:: HelpSvc
:: Help and Support (Справка и поддержка)
:: Обеспечивает возможность работы центра справки и поддержки на этом
:: компьютере. Если эта служба остановлена, центр справки и поддержки не будет
:: доступен. Данная служба необходима для запуска справочных документов
:: Microsoft. Если вы запускаете программу Справка и Поддержка через меню Пуск,
:: то данная служба будет включена в любом случае, даже если стоит значение
:: Отключена.

:: HomeGroupListener
:: Home Group Listener (Прослушиватель домашней группы)
:: Изменение параметров локального компьютера, связанных с конфигурацией и
:: обслуживанием подключенных к домашней группе компьютеров. Если эта служба
:: остановлена или отключена, возможны ошибки в работе компьютера в домашней
:: группе, а также в работе самой группы.

:: HomeGroupProvider
:: Home Group Provider (Поставщик домашней группы)
:: Выполнение сетевых задач, связанных с настройкой и обслуживанием домашних
:: групп. Если эта служба остановлена или отключена, возможны ошибки при
:: обнаружении других домашних групп, а также ошибки в работе собственной
:: домашней группы.

:: HidServ
:: HID Input Service (Доступ к HID-устройствам)
:: Обеспечивает универсальный доступ к HID-устройствам (Human Interface
:: Devices), который активизирует и поддерживает использование заранее
:: определенных клавиш быстрого вызова на клавиатуре, устройствах управления
:: или иных устройствах мультимедиа. Если эта служба остановлена, клавиши
:: быстрого вызова, управляемые этой службой, не будут работать. Вы можете не
:: иметь проблем с внешними устройствами при отключении этой службы. Если же
:: какая-нибудь "уникальная" функция вашего устройства перестанет работать, то
:: измените значение на "Автоматически".

:: HPSIService
:: HP Smart-Install Service
:: %SystemRoot%\System32\hpsisvc.exe
:: Если отключить эту службу, не работают принтеры HP LJ P1102.

:: HWDeviceService.exe
:: Service for runing Mobile applications autorun
:: Запускает при загрузке программу подключения Мегафон-модема.

:: IAANTMON
:: Intel Matrix Storage Event Monitor (Монитор RAID-контроллеров Intel)
:: Следит за контроллерами жёстких дисков на чипсетах Intel.

:: ICQ Service
:: ICQ Toolbar

:: IHProtect Service
:: Adware do-search.com
:: %ProgramFiles%\XTab\CmdShell.exe
:: %ProgramFiles%\XTab\HPNotify.exe
:: %ProgramFiles%\XTab\ProtectService.exe
:: %ProgramData%\WindowsMangerProtect\ProtectWindowsManager.exe

:: idsvc
:: Windows CardSpace
:: Обеспечивает надежную возможность создания, управления и раскрытия цифровых
:: удостоверений. Тип запуска: Вручную.

:: igfxCUIService1.0.0.0
:: Intel(R) HD Graphics Control Panel Service
:: Служба для Intel(R) HD Graphics Control Panel.

:: ImapiService
:: IMAPI CD-Burning COM Service (Служба COM записи компакт-дисков IMAPI)
:: Данная служба осуществляет управление записью компакт-дисков с помощью IMAPI
:: (Image Mastering Applications Programming Interface). Если эта служба
:: остановлена, то компьютер не может записывать компакт-диски. Вы можете
:: установить значение В ручную, тогда служба будет запускаться в тот момент,
:: когда вы будете записывать диск, а потом отключаться. Если же у вас начнут
:: возникать проблемы с записью дисков после установки значения "Вручную", то
:: измените значение на "автоматически". Данная служба занимает около 1.6 мб в
:: оперативной памяти в режиме бездействия.

:: Intel(R) Capability Licensing Service Interface
:: heciserver.exe
:: По умолчанию эта служба включена в автоматическом режиме.

:: JavaQuickStarterService
:: Prefetches JRE files for faster startup of Java applets and applications.

:: jhi_service
:: Jhi_Service.exe
:: Intel(R) Dynamic Application Loader Host Interface

:: LanmanServer
:: Server (Сервер)
:: Обеспечивает поддержку общий доступ к файлам, принтерам и именованным
:: каналам для данного компьютера через сетевое подключение. Если служба
:: остановлена, такие функции не удастся выполнить. Данная служба используется
:: для открытия на доступ ваших файлов и принтеров, а также для работы сервиса
:: Message Queuing. Вы можете отключить эту службу для дополнительной
:: безопасности, если у вас нет необходимости открывать доступ к вашим файлам и
:: принтерам. У кого нет сети можно отключить эту службу.

:: LanmanWorkstation
:: Workstation (Рабочая станция)
:: Обеспечивает поддержку сетевых подключений и связь. Данная служба нужна для
:: подключения локального компьютера на удалённый компьютер. Многие службы
:: требуют работу данного сервиса для нормального функционирования, поэтому
:: рекомендую оставить данную службу в режиме "Автоматически".

:: lmhosts
:: TCP/IP NetBIOS Helper Service (Модуль поддержки NetBIOS через TCP/IP)
:: Включает поддержку службы NetBIOS через TCP/IP (NetBT) и разрешения
:: NetBIOS-имен в адреса. Данная служба необходима для нормальной поддержки
:: NetBIOS через TCP/IP. Если ваша сеть не использует NetBIOS или WINS, то
:: отключите данную службу.

:: lpasvc
:: Microsoft Policy Platform Local Authority
:: %ProgramFiles%\Microsoft Policy Platform\policyHost.exe
:: Часть клиента Configuration Manager.

:: lppsvc
:: Microsoft Policy Platform Processor
:: %ProgramFiles%\Microsoft Policy Platform\policyHost.exe
:: Часть клиента Configuration Manager.

:: McComponentHostService
:: McAfee Security Scan Component Host Service
:: %Program Files%\McAfee Security Scan\3.8.141\McCHSvc.exe

:: MDM
:: Machine Debug Manager
:: Supports local and remote debugging for Visual Studio and script debuggers.
:: If this service is stopped, the debuggers will not function properly.

:: Messenger
:: Messenger (Служба сообщений)
:: Посылает и получает сообщения, переданные администраторами или службой
:: оповещений. Данная служба не имеет отношения к программа Windows Messenger.
:: Если служба остановлена, оповещение не будет передано. Если данная служба
:: неразрешена, не удастся запустить любые явно зависимые службы.

:: Microsoft SharePoint Workspace Audit Service
:: "%ProgramFiles%\Microsoft Office\Office14\GROOVE.EXE" /auditservice
:: "%ProgramFiles%\Microsoft Office\Office15\GROOVE.EXE" /auditservice
:: Microsoft Office Groove, is a desktop application designed for document
:: collaboration in teams with members who are regularly off-line or who do not
:: share the same network security clearance.

:: mnmsrvc
:: NetMeeting Remote Desktop Sharing
:: Системная служба общего доступа к рабочему столу NetMeeting позволяет
:: прошедшим проверку пользователям удалённо управлять рабочим столом Windows
:: с помощью программы Windows NetMeeting с другого компьютера по внутренней
:: сети предприятия. Службу необходимо явно включить в NetMeeting, а для
:: отключения или закрытия предназначен значок в области уведомлений Windows.
:: Если вы заботитесь о безопасности вашего компьютера, то я советую вам
:: отключить данную службу.

:: MozillaMaintenance
:: Mozilla maintenance service
:: Отвечает за отключение UAC при обновлении Firefox.
:: Эту службу можно либо отключить либо совсем удалить. Это не повлияет на
:: стабильность работы браузера. Правда придётся подтверждать установку
:: обновлений. А те у кого WinXP вообще ничего не заметят.

:: MPCKpt
:: More Powerful Cleaner (MPC)
:: "%SYSTEMROOT%\SYSTEM32\DRIVERS\mpckpt.sys"

:: MPCProtectService
:: More Powerful Cleaner (MPC)
:: "%ProgramFiles(x86)%\MPC Cleaner\MPCProtectService.exe"

:: MpsSvc
:: Windows Firewall (Брандмауэр Windows)
:: Помогает предотвратить несанкционированный доступ к вашему компьютеру через
:: Интернет или сеть. Если отключить службу, то при настройке общего доступа
:: может появляться ошибка.

:: MSDTC
:: Distributed Transaction Coordinator (Координатор распределенных транзакций)
:: Обеспечивает управление транзакциями между некоторыми компьютерными
:: ресурсами и системами управления базами данных, очередями сообщений или к
:: примеру файловой системой. Необходим для конфигурации (но не работы!) COM+
:: компонент, и таких систем как Message Queuing (MSMQ) или Microsoft SQL
:: Server.

:: msiserver
:: Windows Installer (Установщик Windows)
:: msiexec.exe
:: Тип запуска: Вручную.

:: MsMpSvc
:: Microsoft Antimalware Service (Служба Майкрософт по защите от вредоносных
:: программ)
:: "%ProgramFiles%\Microsoft Security Essentials\MsMpEng.exe"
:: Входит в состав Microsoft Security Essentials. Помогает защитить
:: пользователей от программ-шпионов и других потенциально нежелательных
:: программ.

:: napagent
:: Network Access Protection Agent (Агент защиты доступа к сети)
:: Позволяет клиентам Windows принимать участие в защите доступа к сети.
:: Рекомендуемое значение: Вручную.
:: При подключении клиента к Сети проверяется наличие файрвола, последних
:: обновлений безопасности, обновлений антивирусных программ и т.д. Если
:: компьютер не удовлетворяет принятым политикам, в полном доступе ему будет
:: отказано до тех пор, пока выявленные проблемы не будут устранены. В
:: зависимости от настроек, компьютеры, не прошедшие контроль, либо блокируются
:: полностью, либо помещаются в карантин (например, им выдаются IP-адреса из
:: другого диапазона). Как вариант, можно настроить только журналирование
:: подобных событий без принятия каких-либо мер. В карантинной подсети могут
:: располагаться коррекционные сервера (Remediation Server), предоставляющие
:: ресурсы для устранения выявленных недостатков, к примеру, сервер обновлений
:: WSUS (Windows Server Update Services) или антивирусная база. После
:: обновления соответствие политикам проверяется повторно, - если все
:: нормально, система получает доступ в Сеть. Среди настроек можно указать
:: веб-страничку, на которой описано, почему пользователь не может
:: подключиться, и что ему для этого нужно сделать.
:: NAP выполняет не только блокирующие функции, но и является средством,
:: помогающим устранить найденные недостатки. Его работа не сводится к
:: однократной проверке при подключении (после которой пользователь может
:: отключить антивирус, "чтобы не мешал"). Проверка состояния производится
:: периодически в течение всего времени, когда компьютер подключен к Сети.

:: NAUpdate
:: Nero Update
:: This module assists in the automatic update function for Nero software. If
:: disabled, the NERO software will not automatically seek updates.

:: NetDDE
:: NetDDE (Служба сетевого DDE)
:: Обеспечивает сетевой транспорт и безопасность для динамического обмена
:: данными (DDE) для программ, выполняющихся на одном или на различных
:: компьютерах. Если эта служба остановлена, сетевой транспорт и безопасность
:: DDE не будут доступны. Если эта служба отключена, любые службы, которые явно
:: зависят от нее, не могут быть запущены.

:: Netlogon
:: Net Logon (Сетевой вход в систему)
:: Для проверки подлинности пользователей и служб системная служба поддерживает
:: безопасный канал между компьютером и контроллером домена. Она передает на
:: контроллер домена учетные данные пользователя, а возвращает доменные
:: идентификаторы безопасности и назначенные пользователю права. Обычно этот
:: процесс называется сквозной проверкой подлинности. Служба Net Logon
:: автоматически запускается, только когда к домену подключается рядовой
:: компьютер или контроллер домена. Данная служба не нужна в домашних условиях
:: или в условиях домашних сетей, поэтому можете ее отключить.

:: Netman
:: Network Connections (Сетевые подключения)
:: Управляет объектами папки Сеть и удалённый доступ к сети, отображающей
:: свойства локальной сети и подключений удалённого доступа. Данная служба
:: необходима для поддержки сетевых соединений. Отключите данную службу, если
:: ваш компьютер находится ВНЕ СЕТИ. Если после отключения данной службы у вас
:: появились проблемы с сетевыми подключениями, то поставьте значение в
:: Автоматически. Примечание: Если вы отключите данную службу, то у вас больше
:: в системном трее не будет появляться значок соединения (2 мониторчика) даже
:: для модемных соединений.

:: NisSrv
:: Microsoft Network Inspection System (Проверка сети Майкрософт)
:: "%ProgramFiles%\Microsoft Security Client\Antimalware\NisSrv.exe
:: Работа этой службы основана на сигнатурном анализе и в её функции входит
:: предотвращение атак на известные уязвимости. Используется для для временного
:: блокирования уязвимости с момента её обнаружения до выхода обновления.
:: Входит в состав Microsoft Security Essentials.

:: Nla
:: NlaSvc
:: Network Location Awareness NLA (Служба сетевого расположения NLA)
:: Данная служба собирает и хранит сведения о размещении и настройки сети, а
:: также уведомляет приложения об их изменении.

:: NvStreamSvc
:: NVIDIA Streamer Service
:: %ProgramFiles%\NVIDIA Corporation\NvStreamSrv\nvstreamsvc.exe
:: Служба для SHIELD Streaming. Нужна для того, чтобы играть в игры на игровой
:: консоли от nVidia, запущенные на ПК. Еще без этой службы нельзя записывать
:: игру в Shadow Play.

:: NVSvc
:: NVidia Display Driver Service (Интерфейс управления драйвером видеокарт
:: NVidia)
:: %SystemRoot%\System32\nvsvc32.exe
:: Provides system and desktop level support to the NVIDIA display driver.
:: Если служба отключена, то не запускается NVIDIA Control Panel Application
:: (панель управления NVIDIA).

:: nvUpdatusService
:: NVIDIA Update Service Daemon
:: NVIDIA Settings Update Manager service, used to check new updates from
:: NVIDIA server.

:: ose
:: Office Source Engine
:: Сохранение установочных файлов для последующего обновления и восстановления
:: продукта. Используется также для загрузки обновленных версий программы
:: установки и отчетов об ошибках Watson. Без этой службы не ставится Office
:: 2013 на Windows 8.

:: osppsvc
:: Microsoft Office Software Protection Platform Service
:: %CommonProgramFiles%\Microsoft Shared\OfficeSoftwareProtectionPlatform\osppsvc.exe
:: %SystemRoot%\System32\osppsvc.exe
:: Служба проверяет лицензию Microsoft Office. Если её отключить, то Microsoft
:: Office закрывается, поэтому режим запуска: Вручную.

:: p2psvc
:: Peer Networking Grouping (Группировка сетевых участников)
:: Включает многосторонние взаимодействия с помощью группировки одноранговой
:: сети. При отключении некоторые приложения, например домашняя группа, могут
:: перестать работать.

:: p2pimsvc
:: Peer Networking Identity Manager (Диспетчер удостоверения сетевых участников)
:: Предоставляет службы идентификации для протокола однорангового разрешения
:: имён (PNRP) и группировки одноранговой сети. В случае запрещения службы для
:: протокола однорангового разрешения имён (PNRP) и группировки одноранговой
:: сети, а также некоторые приложения, например домашняя группа и Remote
:: Assistance, могут перестать работать.

:: PicexaService
:: Вирус.

:: pla
:: Performance Logs & Alerts (Журналы и оповещения производительности)
:: Служба журналов производительности и оповещений собирает данные с локальных
:: и удалённых компьютеров соответственно заданным параметрам расписания, а
:: затем записывает данные в журнал или выдаёт оповещение. Если данная служба
:: остановлена, все сведения о производительности не собираются.

:: PlugPlay
:: Plug and Play
:: Позволяет компьютеру распознавать изменения в установленном оборудовании и
:: подстраиваться под них, либо, не требуя вмешательства пользователя, либо
:: сводя его к минимуму. Остановка или отключение этой службы может привести к
:: нестабильной работе системы. Это служба является "сердцем" всей системы Plug
:: and Play устройств на компьютере. Я крайне не рекомендую отключать данную
:: службу, так как вы можете столкнуться с множеством проблем. Имейте ввиду,
:: что UPnP НЕ ТОЖЕ самое, что и PnP. UPnP служит для связи через TCP/IP с
:: оборудованием (сканерами, принтерами и т.д.). Ваше звуковая карта - это PnP
:: устройство. НЕ ОТКЛЮЧАЙТЕ службу Plug and Play.

:: PnkBstrA
:: PunkBuster Service Component (http://www.evenbalance.com) - автоматически
:: самообновляющаяся система программного обеспечения античитерства на сервере.
:: Это означает, что за игроком в процессе игры устанавливается наблюдение
:: PunkBusterом, которое отсылает на сервер все нарушения конкретного игрока.
:: Система PunkBuster разработана, для того чтобы все игроки были ответственны
:: за свои поступки в онлайн играх, при использовании читерских команд.
:: PunkBuster не изменяет никаких файлов или функции настройки на вашем
:: компьютере, даже если и обнаруживается некоторые типы нарушений во время
:: игры у данного игрока, а просто выводит сообщение ему о нарушениях
:: допущенных им и кикает (удаляет) игрока с сервера или же банит. Админ
:: сервера в праве включать на сервере или не включать PunkBuster, всё зависит
:: только от его желания. Вы можете в настройках игры отключить PunkBuster, но
:: при этом у вас будет уже ограниченный список серверов, на которых тоже
:: PunkBuster будет отключён. PunkBuster не является вирусной программой и
:: создан для честной игры на сервере. Дополнительно, PunkBuster не передает
:: ваши частные данные на любой другой компьютер, не содержет собственных баз
:: данных в которых описаны ваши персональные данные. PunkBuster в основном
:: только ищет нестандартные действия в процессе вашей игры.

:: PolicyAgent
:: Агент политики IPsec
:: IPSEC Services (Службы IPSEC)
:: Безопасность протокола IP (IPsec) поддерживает проверку подлинности
:: кэширующих узлов на сетевом уровне, проверку подлинности источника данных,
:: проверку целостности данных, их конфиденциальность (шифрование) и защиту
:: повторения. Эта служба вводит в действие политики IPsec, созданные с помощью
:: оснастки "Политики IP-безопасности" или средством командной строки "netsh
:: ipsec". Остановка этой службы может привести к возникновению проблем с
:: сетевыми подключениями, если политика требует, чтобы соединения использовали
:: IPsec. Кроме того, если остановлена эта служба, то удаленное управление
:: брандмауэром Windows недоступно. Данная служба может понадобиться при
:: использовании VPN или домена. Для домашнего использования данную службу
:: можно отключить.

:: ProtectedStorage
:: Protected Storage (Защищенное хранилище)
:: Обеспечивает защищенное хранение секретных данных, таких, как закрытые
:: ключи, для предотвращения несанкционированного доступа служб, процессов или
:: пользователей. Позволяет сохранять локальные пароли или веб-информацию
:: (автозаполнение). По умолчанию данная служба включена в автоматическом
:: режиме. Но из соображений безопасности я рекомендую отключить ее. С другой
:: стороны, данная служба может вам понадобиться при работе с зашифрованными
:: данными и ключами от различных программ, в таком случае верните службу в
:: значение Автоматически. Если вы сохраняете пароли в Outlook Express`е,
:: подключениях к Интернету по модему или через контроллер домена, что требует
:: идентификации, то оставьте службу в режиме "Автоматически".

:: RapiMgr
:: ActiveSync RAPI Manager
:: %ProgramFiles%\Microsoft ActiveSync\rapimgr.exe
:: Принадлежит программе Microsoft ActiveSync (связь с устройствами на ОС
:: Windows Mobile). Слушает или шлет данные на открытые порты в сети или по
:: Интернету.

:: RasAuto
:: Remote Access Auto Connection Manager (Диспетчер автоматических подключений
:: удалённого доступа)
:: Создает подключение к удалённой сети, когда программа обращается к удалённому
:: DNS- или NetBIOS-имени или адресу.

:: RasMan
:: Remote Access Connection Manager (Диспетчер подключений удалённого доступа)
:: Управляет подключениями удалённого доступа и виртуальной частной сети (VPN)
:: с данного компьютера к Интернету или другим удалённым сетям.

:: RemoteRegistry
:: Remote Registry (Удалённый реестр)
:: Позволяет удалённым пользователям изменять параметры реестра на этом
:: компьютере. Если эта служба остановлена, реестр может быть изменен только
:: локальными пользователями, работающими на этом компьютере. Данной службы нет
:: в операционной системе Windows XP Home. Да и в Windows XP Pro она абсолютно
:: не нужна, эта служба является одной из первых, которую я отключаю после
:: установки операционной системы.

:: ROMService_Support
:: Удалённое управление (rmansys.ru).

:: RpcLocator
:: Remote Procedure Call (Локатор удалённого вызова процедур (RPC))
:: Создает сетевое подключение. Данная служба необходима, если вы  используете
:: общий доступ к Интернету. Попробуйте отключить  ее,  если  у  вас  перестал
:: работать интернет, то верните значение  службы  в  "Автоматически".  Имейте
:: ввиду,  что  данная  служба  может  потребоваться  для   некоторых   прямых
:: подключений или DSL-подключений.

:: SamSs
:: Security Accounts Manager (Диспетчер учетных записей безопасности)
:: Хранит информацию о безопасности для учетной записи локального пользователя.
:: Без этой службы не будет работать служба IIS Admin (IIS Admin). Если вы не
:: делали никаких изменений в локальной политике безопасности (gpedit.msc), то
:: можете отключить данную службу. Если же вы делали изменения в локальной
:: политике безопасности и отключите данную службу, то все изменения, которые
:: вы делали, перестанут работать. Поэтому я рекомендую оставить режим запуска
:: этой службы по умолчанию, то есть "Автоматически".

:: SDRSVC
:: Windows Backup (Архивация Windows)
:: Поддержка архивации и восстановления в Windows.

:: Schedule
:: Task Scheduler (Планировщик заданий)
:: Позволяет запускать процессы от имени другого пользователя. Если эта служба
:: остановлена, этот тип регистрации пользователя недоступен.

:: SecLogon
:: Secondary Logon (Вторичный вход в систему)
:: Позволяет запускать процессы от имени другого пользователя. Если эта служба
:: остановлена, этот тип регистрации пользователя недоступен.

:: SENS
:: System Event Notification (Уведомление о системных событиях)
:: Данная служба протоколирует системные события, такие как регистрация в
:: Windows, в сети и изменения в подаче электропитания. Уведомляет подписчиков
:: из разряда COM+ системное событие, рассылая оповещения. Если служба не
:: запущена, обычному пользователю невозможно войти в учётную запись, текст
:: ошибки: Windows не удается подключиться к службе "Служба уведомления о
:: системных событиях".

:: SensrSvc
:: Adaptive Brightness (Адаптивная регулировка яркости)
:: Предназначена для наблюдения за датчиком внешнего освещения и корректировки
:: яркости монитора в соответствии с изменениями освещенности. В случае
:: остановки или отключения этой службы корректировка яркости монитора в
:: соответствии с освещённостью не производится.

:: servervo
:: VO Service component
:: Remote Desktop Access (VuuPC).
:: %AppData%\VOPackage\VOsrv.exe
:: Вирус.

:: SCardSvr
:: Smart Card Helper (Модуль поддержки смарт-карт)
:: SCardSvr.exe
:: По умолчанию данная служба включена в автоматическом режиме. Обеспечивает
:: поддержку для старых устройств чтения смарт-карт (без PnP). Если эта служба
:: остановлена, на компьютере не будут поддерживаться старые устройства чтения
:: смарт-карт. Служба используется для поддержки локальной или сетевой
:: авторизации через смарт-карты (банк-клиенты).

:: SharedAccess
:: Windows Firewall/Internet Connection Sharing (Брандмауэр Windows / Общий
:: доступ к Интернету (ICS))
:: Обеспечивает поддержку служб трансляции адресов, адресации и разрешения имен
:: или предотвращает вторжение служб в домашней сети или сети небольшого офиса.
:: Позволяет тонко настроить фильтрацию сетевого трафика. Если вы используете
:: файерволл сторонних производителей (Outpost firewall, Norton Personal
:: Firewall, ZoneAlarm и т.п.), то необходимо отключить данную службу.

:: ShellHWDetection
:: Shell Hardware Detection (Определение оборудования оболочки)
:: Служит для автозапуска оборудования: CD-ROM и т.д. Служба загрузки
:: изображений Windows (WIA) является зависимой от этой службы.

:: SkypeUpdate
:: Skype Updater
:: Обнаружение, загрузка и установка обновлений для Skype.

:: smstsmgr
:: Агент последовательности задач Configuration Manager
:: %SystemRoot%\CCM\TSManager.exe
:: Агент клиента Configuration Manager для выполнения последовательности задач.

:: Spooler
:: Print Spooler (Диспетчер очереди печати)
:: Загружает в память файлы для последующей печати. Если вы не используете
:: печать и у вас в системе не установлено ни одного принтера, то отключите
:: данную службу.

:: SSDPSRV
:: SSDP Discovery Service (Служба обнаружения SSDP)
:: Данная служба включает обнаружение UPnP-устройств в домашней сети. Однако,
:: необходимость данного сервиса в домашних условиях вызывает большое сомнение.
:: Тип запуска: Вручную.

:: SSUService
:: Splashtop software updater (Служба обновления Splashtop)
:: Enables updates and enhancements to the SmartView browser extension.

:: srservice
:: System Restore Service (Служба восстановления системы)
:: Выполняет функции восстановления системы. Чтобы остановить данную службу,
:: следует отключить восстановление системы на вкладке Восстановление системы,
:: в которую можно попасть, нажав правой кнопкой мыши на ярлыке Мой компьютер
:: на рабочем столе и выбрав пункт Свойства.Примечание: Крайне не рекомендуется
:: отключать восстановление системы, так как в случае сбоя в работе компьютера
:: вы не сможете вернуться к работоспособному состоянию.

:: Srv
:: Драйвер ядра srv.sys обеспечивает поддержку протокола SMB 1.0. При отключени
:: служюы старые клиенты, такие как Windows XP и Windows Server 2003, не
:: получат доступ к общим папкам.

:: STacSV
:: Audio Service
:: Manages audio jack configurations
:: %ProgramFiles%\IDT\WDM\STacSV.exe
:: This program contains the driver that enables the IDT High-Definition (HD)
:: Audio in supported notebook models that are running a supported operating
:: system.

:: stisvc
:: Windows Image Acquisition (WIA) (Служба загрузки изображений Windows (WIA))
:: Still Image Service (в Windows 2000)
:: Обеспечивает службы получения изображений со сканеров и цифровых камер.
:: Были проблемы когда служба не запускалась в ручном режиме.

:: Stereo Service
:: NVIDIA Stereoscopic 3D Driver Service
:: Provides system support for NVIDIA Stereoscopic 3D driver.

:: SynTPEnhService
:: SynTPEnh Caller Service
:: 32-bit Synaptics Pointing Enhance Service
:: 64-bit Synaptics Pointing Enhance Service
:: %ProgramFiles%\Synaptics\SynTP\SynTPEnhService.exe
:: %ProgramFiles%\Synaptics\SynTP\SynTPEnh.exe
:: %ProgramFiles%\Synaptics\SynTP\SynTPHelper.exe
:: Утилита из состава драйвера тачпада от Synaptics, обеспечивает поддержку
:: расширенных функций тачпада (например, назначение специальных действий на
:: отдельные зоны тачпада). Без этой тулзы тачпад будет просто работать как
:: обычная мышка. Никаких дополнительных функций не будет.

:: TapiSrv
:: Telephony (Телефония)
:: Обеспечивает поддержку Telephony API (TAPI) для программ, управляющих
:: телефонным оборудованием и голосовыми IP-подключениями на этом компьютере, а
:: также через ЛВС - на серверах, где запущена соответствующая служба.

:: TermService
:: Terminal Services (Службы терминалов)
:: Данная служба предоставляет возможность нескольким пользователям
:: интерактивно подключаться к компьютеру и отображает рабочий стол и
:: приложения на удалённых компьютерах. Является основой для удалённого
:: рабочего стола (включая удалённое администрирование), быстрого переключения
:: пользователей, удалённого помощника и служб терминалов.

:: Themes
:: Themes (Темы)
:: Обеспечивает управление пользовательскими темами рабочего стола. Если вы
:: используете классическую тему Windows, то вам не за чем держать этот сервис
:: включенным.

:: TrkWks
:: Distributed Link Tracking Client (Клиент отслеживания изменившихся связей)
:: Поддерживает связи NTFS-файлов, перемещаемых в пределах компьютера или между
:: компьютерами в домене.

:: TrustedInstaller
:: Windows Modules Installer (Установщик модулей Windows)

:: UALSVC
:: User Access Logging Service (Служба ведения журнала доступа пользователей)
:: Эта служба регистрирует (в виде IP-адресов и имен пользователей) уникальные
:: клиентские запросы на доступ, отправляемые продуктами или ролями на
:: локальном сервере. Эту информацию могут через Powershell запрашивать
:: администраторы, которым требуется оценить количество клиентских запросов к
:: серверному программному обеспечению для автономного управления клиентскими
:: лицензиями. Остановка службы не влияет на запросы исторических данных (см.
:: шаги по удалению исторических данных в документации по поддержке).
:: Локальному системному администратору требуется изучить условия лицензионного
:: соглашения на использование Windows Server, чтобы определить количество
:: клиентских лицензий, необходимых для надлежащего лицензирования серверного
:: программного обеспечения; использование службы и данных UAL не изменяет эту
:: обязанность.

:: UFDSVC
:: UFD Command Service
:: Служба UFD Command Service (файл ufdsvc.exe) идёт с флешками Transcend
:: Jetflash... видимо для работы таких программ как PC-Lock, Password, mFormat,
:: поставляемых с флэшкой.

:: UI0Detect
:: Interactive Services Detection (Обнаружения интерактивных служб)
:: %SystemRoot%\System32\UI0Detect.exe
:: Interactive Services Detection (the blinking button on the taskbar) is a
:: mitigation for legacy applications that detects if a service is trying to
:: interact with the desktop. This is handled by the Interactive Services
:: Detection (UI0Detect) service.
:: When you choose "View the message", you are taken to session 0's desktop and
:: you can only interact with the dialog or message that services have tried to
:: display on the desktop.

:: UPHClean
:: User Profile Hive Cleanup
:: Устанавливается как сервис на Windows 2000/XP/Vista. Появилась и версия для
:: x64 систем. Очень актуальна для терминальных серверов. Позволяет коррекно
:: завершать пользовательские сессии. Перед завершением сеанса освобождает
:: занятые процессами или приложениями ветки реестра. К тому же позволяет
:: избавиться от лишних сообщений в логах (Userenv 1517, 1524). Но дальнейшая
:: разработка утилиты остановлена. В Windows 7/2008 R2 уже существует штатная
:: служба <User Profile Service>, которая и выполняет необходимые функции.

:: upnphost
:: UPnP Device Host (Узел универсальных PNP-устройств)
:: Позволяет размещать устройства UPnP на этом компьютере. Если эта служба
:: остановлена, все UPnP-устройства прекратят работу, и добавить дополнительные
:: устройства будет невозможно. Если данная служба отключена, все явно
:: зависящие от нее службы запустить не удастся. Тип запуска: Вручную.

:: UserAccess
:: Securom User Access for Windows 2000 and Windows XP a technology by Sony DADC
:: %CommonProgramFiles%\YDP\UserAccessManager\useraccess.exe

:: w32time
:: Windows Time (Служба времени Windows)
:: Управляет синхронизацией даты и времени на всех клиентах и серверах в сети.
:: Если эта служба остановлена, синхронизация даты и времени не будет доступна.

:: WcesComm
:: ActiveSync Connection Manager
:: %ProgramFiles%\Microsoft ActiveSync\wcescomm.exe
:: Принадлежит программе Microsoft ActiveSync (связь с устройствами на ОС
:: Windows Mobile). Использует порт, чтобы присоединится к сети или Интернету.

:: WdiSystemHost
:: Diagnostic System Host (Узел системы диагностики)

:: WebClient
:: Web Client (Веб-клиент)
:: Позволяет Windows-программам создавать, получать доступ и изменять файлы,
:: хранящиеся в Интернете. Если эта служба остановлена, эти функции не доступны.
:: Если эта служба отключена, любые службы, которые явно зависят от нее, не
:: могут быть запущены.

:: VIAKaraokeService
:: VIA Karaoke digital mixer Service

:: WinHttpAutoProxySvc
:: WinHTTP Web Proxy Auto-Discovery Service (Служба автоматического обнаружения
:: веб-прокси WinHTTP)

:: Winmgmt
:: Windows Management Instrumentation (Инструментарий управления Windows)
:: Предоставляет общий интерфейс и объектную модель для доступа к информации об
:: управлении операционной системой, устройствами, приложениями и службами.
:: После остановки данной службы многие Windows-приложения могут работать
:: некорректно.

:: WinRM
:: Windows Remote Management (Служба удалённого управления)
:: Windows

:: WLTRYSVC
:: Dell Wireless WLAN Tray Service
:: %SystemRoot%\System32\wltrysvc.exe

:: WmdmPMSN
:: Portable Media Serial Number (хм, даже не знаю как перевести эту глупость).

:: wmiApSrv
:: WMI Performance Adapter

:: WMPNetworkSvc
:: Windows Media Player Network Sharing Service (Служба общих сетевых ресурсов
:: проигрывателя Windows Media)
:: Предоставляет общий доступ к библиотекам проигрывателя Windows Media другим
:: сетевым проигрывателям и устройствам, использующим стандарт Universal  Plug
:: and Play. Рекомендуемое значение: Вручную.

:: WPCSvc
:: Parental Controls (Родительский контроль)
:: Включает в системе родительский контроль Windows. Службу можно отключить.

:: WPDBusEnum
:: Portable Device Enumerator Service (Служба перечислителя переносных
:: устройств)

:: WPFFontCache_v0400
:: Windows Presentation Foundation Font Cache 4.0.0.0 (Кэш шрифтов Windows
:: Presentation Foundation 4.0.0.0)
:: Оптимизирует производительность приложений Windows Presentation Foundation
:: (WPF) путем кэширования обычно используемых данных шрифтов. Приложения WPF
:: запускают эту службу, если она еще не запущена. Ее можно отключить, однако
:: это ухудшит производительность приложений WPF. WPF - графическая
:: (презентационная) подсистема в составе .NET Framework.

:: wscsvc
:: Security Center (Центр обеспечения безопасности)
:: Центр обеспечения безопасности помогает управлять параметрами безопасности
:: Windows. Можно отключить эту службу.

:: WSearch
:: Windows Search (Поиск Windows)
:: Индексирование содержимого и кэширование свойств для файлов, почтовых
:: сообщений и других элементов (посредством API-интерфейсов расширения). Эта
:: служба реагирует на уведомления об изменении файлов и сообщений с целью
:: индексирования их содержимого. Если служба останавливается или отключается,
:: проводник Windows не сможет отображать виртуальные папки элементов, а
:: функциональные возможности поиска будут ограничены поэлементным медленным
:: поиском. Если отключить, не работает быстрый поиск в Outlook - выдаёт ошибку.

:: wuauserv
:: Automatic Updates (Автоматическое обновление)
:: Нужен для подключения компьютера к центру Windows Update для автоматического
:: скачивания обновлений для вашей системы. Если отключить службу, то не будет
:: обновляться Microsoft Security Essentials, поэтому режим запуска: Вручную.

:: WZCSVC
:: Wireless Zero Configuration (Беспроводная настройка)
:: Предоставляет автоматическую настройку 802.11 адаптеров. Если к компьютеру
:: не подключено адаптеров беспроводной связи, то рекомендуется отключить
:: данную службу для экономии системных ресурсов.
