@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Cleaning unwanted tasks
set USAGE=

call :Cleaning_Tasks
goto Finish


:Cleaning_Tasks
set DELETE_TASK_ERROR=NO
if /I "%DEBUG%"=="YES" (
  call           :Cleaning_Tasks_Sub
) else (
  call>nul 2>nul :Cleaning_Tasks_Sub
)
if /I "%DEBUG%"=="YES" (
  echo.
  if /I "%DELETE_TASK_ERROR%"=="YES" (
    exit /B 1
  )
  exit /B 0
)
if /I "%DELETE_TASK_ERROR%"=="YES" (
  call EchoFail Cleaning tasks
  exit /B 1
)
call EchoSucc Cleaning tasks
exit /B 0
:Cleaning_Tasks_Sub
call EchoTitl Cleaning tasks
call Task delete "{002240F8-0E50-48B6-B6C8-82196BB6469F}"
call Task delete "{23BBB104-84C0-4008-A99F-81585173BBFB}"
call Task delete "{372576E7-B381-4263-BB63-D239471CF75A}"
call Task delete "{559901C2-B923-462C-9CFF-335673146DE1}"
call Task delete "{6C7B6122-1233-4449-BE09-C2640F7F25AA}"
call Task delete "{8C506EB7-F4CD-4162-A1E7-29E2E429CC13}"
call Task delete "{A5EF258B-9F3D-452A-8053-55328C0459DB}"
call Task delete "{C2246ACB-F525-4393-979F-6A00030F8AF6}"
call Task delete "Adobe Acrobat Update Task"
call Task delete "Adobe Flash Player Updater"
call Task delete "appdistrib"
call Task delete "AppleSoftwareUpdate"
call Task delete "avaxvyyvyf"
call Task delete "BonanzaDealsLiveUpdateTaskMachineCore"
call Task delete "BonanzaDealsLiveUpdateTaskMachineUA"
call Task delete "CCleanerSkipUAC"
call Task delete "cvc"
call Task delete "Kbupdater Utility"
call Task delete "Microsoft\Office\Office 15 Subscription Heartbeat"
call Task delete "Microsoft\Office\OfficeBackgroundTaskHandlerRegistration"
call Task delete "Microsoft\Office\OfficeTelemetryAgentFallBack2016"
call Task delete "Microsoft\Office\OfficeTelemetryAgentLogOn2016"
call Task delete "Microsoft\Windows\Application Experience\AitAgent"
call Task delete "Microsoft\Windows\Application Experience\ProgramDataUpdater"
call Task delete "Microsoft\Windows\Autochk\Proxy"
call Task delete "Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
call Task delete "Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"
call Task delete "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"
call Task delete "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
call Task delete "Microsoft\Windows\Setup\gwx\launchtrayprocess"
call Task delete "Microsoft\Windows\Setup\gwx\refreshgwxconfig"
call Task delete "Microsoft\Windows\Setup\gwx\refreshgwxconfigandcontent"
call Task delete "Microsoft\Windows\Setup\gwx\refreshgwxcontent"
call Task delete "Microsoft\Windows\Setup\gwx"
::call Task delete "Microsoft\Windows\Setup\GWXTriggers\Logon-5d"
::call Task delete "Microsoft\Windows\Setup\GWXTriggers\MachineUnlock-5d"
::call Task delete "Microsoft\Windows\Setup\GWXTriggers\OutOfIdle-5d"
::call Task delete "Microsoft\Windows\Setup\GWXTriggers\OutOfSleep-5d"
::call Task delete "Microsoft\Windows\Setup\GWXTriggers\refreshgwxconfig-B"
::call Task delete "Microsoft\Windows\Setup\GWXTriggers\Telemetry-4xd"
::call Task delete "Microsoft\Windows\Setup\GWXTriggers\Time-5d"
::call Task delete "Microsoft\Windows\Setup\GWXTriggers"
call Task delete "Microsoft\Windows\Windows Media Sharing\UpdateLibrary"
call Task delete "nethost task"
call Task delete "SmartWeb Upgrade Trigger Task"
call Task delete "Soft installer"
call Task delete "SystemScript"
call Task delete "GoogleUpdateTaskMachineCore"
call Task delete "GoogleUpdateTaskMachineCore1ccfbd54b0ef3fe"
call Task delete "GoogleUpdateTaskMachineUA"
call Task delete "SlimDrivers Startup"
call Task delete "WindowsUpdater"
call Task delete "Программа онлайн-обновления Adobe."
call Task delete "Уведомление о завершении поддержки Microsoft Windows XP ежемесячно"
call Task delete "Уведомлением о завершении поддержки Microsoft Windows XP при входе"
exit /B

:Finish
