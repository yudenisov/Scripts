@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Management console
set USAGE=[ad/cer/cmp/dev/dhcp/dsk/dns/env/evt/gp/hv/mob/net/rst/shr/snd/srv/svc/tsk/usr/usr2/wb]

call :Management_Console "%~1" "%~2"
goto Finish


:Management_Console
if "%~1"=="" (
  start mmc.exe
  exit /B
)
if /I "%~1"=="AD" (
  start dsac.exe
  exit /B
)
if /I "%~1"=="CER" (
  start mmc.exe "%SYSTEMROOT%\SYSTEM32\certmgr.msc"
  exit /B
)
if /I "%~1"=="CMP" (
  start mmc.exe "%SYSTEMROOT%\SYSTEM32\compmgmt.msc" /COMPUTER=%~2
  exit /B
)
if /I "%~1"=="DEV" (
  start mmc.exe "%SYSTEMROOT%\SYSTEM32\devmgmt.msc"
  exit /B
)
if /I "%~1"=="DHCP" (
  start mmc.exe "%SYSTEMROOT%\SYSTEM32\dhcpmgmt.msc"
  exit /B
)
if /I "%~1"=="DSK" (
  start mmc.exe "%SYSTEMROOT%\SYSTEM32\diskmgmt.msc"
  exit /B
)
if /I "%~1"=="DNS" (
  start mmc.exe "%SYSTEMROOT%\SYSTEM32\dnsmgmt.msc"
  exit /B
)
if /I "%~1"=="ENV" (
  "%SYSTEMROOT%\SYSTEM32\rundll32.exe" sysdm.cpl,EditEnvironmentVariables
  exit /B
)
if /I "%~1"=="EVT" (
  start mmc.exe "%SYSTEMROOT%\SYSTEM32\eventvwr.msc"
  exit /B
)
if /I "%~1"=="GP" (
  start mmc.exe "%SYSTEMROOT%\SYSTEM32\gpmc.msc"
  exit /B
)
if /I "%~1"=="HV" (
  start mmc.exe "%PROGRAMFILES%\Hyper-V\virtmgmt.msc"
  exit /B
)
if /I "%~1"=="MOB" (
  start mblctr.exe
  exit /B
)
if /I "%~1"=="NET" (
  start control.exe ncpa.cpl
  exit /B
)
if /I "%~1"=="RST" (
  if exist "%SYSTEMROOT%\SYSTEM32\RESTORE\rstrui.exe" (
    start "%SYSTEMROOT%\SYSTEM32\RESTORE\rstrui.exe"
  ) else (
    start rstrui.exe
  )
  exit /B
)
if /I "%~1"=="SHR" (
  start mmc.exe "%SYSTEMROOT%\SYSTEM32\fsmgmt.msc" /COMPUTER=%~2
  exit /B
)
if /I "%~1"=="SND" (
  start control.exe mmsys.cpl
  exit /B
)
if /I "%~1"=="SRV" (
  start mmc.exe "%SYSTEMROOT%\SYSTEM32\ServerManager.msc"
  exit /B
)
if /I "%~1"=="SVC" (
  start mmc.exe "%SYSTEMROOT%\SYSTEM32\services.msc" /COMPUTER=%~2
  exit /B
)
if /I "%~1"=="TSK" (
  if exist "%SYSTEMROOT%\SYSTEM32\taskschd.msc" (
    start mmc.exe "%SYSTEMROOT%\SYSTEM32\taskschd.msc"
  ) else (
    start control.exe schedtasks
  )
  exit /B
)
if /I "%~1"=="USR" (
  start mmc.exe "%SYSTEMROOT%\SYSTEM32\lusrmgr.msc" /COMPUTER=%~2
  exit /B
)
if /I "%~1"=="USR2" (
  start control.exe userpasswords2
  exit /B
)
if /I "%~1"=="WB" (
  if exist "%SYSTEMROOT%\SYSTEM32\wbadmin.msc" (
    start mmc.exe "%SYSTEMROOT%\SYSTEM32\wbadmin.msc"
    exit /B
  )
)
exit /B 255

:Finish
