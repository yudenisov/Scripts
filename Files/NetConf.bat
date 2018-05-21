@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Backup/restore network configuration to directory [C:\BACKUP\NET]
set USAGE=backup/restore [backup_dir]

if /I "%~1"=="BACKUP" (
  call :Backup_NetConf "%~2"
  goto Finish
)
if /I "%~1"=="RESTORE" (
  call :Restore_NetConf "%~2"
  goto Finish
)
exit /B 255


:Backup_NetConf
setlocal
set NETCONF_BACKUP=C:\BACKUP\NET
if not "%~1"=="" set NETCONF_BACKUP=%~1
mkdir>nul 2>nul "%NETCONF_BACKUP%"
if not exist "%NETCONF_BACKUP%" goto Backup_NetConf_Fail
if exist "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Connections\Pbk\rasphone.pbk" (
  copy>nul 2>nul /Y /Z "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Connections\Pbk\rasphone.pbk" "%NETCONF_BACKUP%\" || goto Backup_NetConf_Fail
)
netsh.exe 2>nul int ip dump>"%NETCONF_BACKUP%\interfaces.txt" || goto Backup_NetConf_Fail
call EchoSucc Backup network configuration to "%NETCONF_BACKUP%"
exit /B 0
:Backup_NetConf_Fail
call EchoFail Backup network configuration to "%NETCONF_BACKUP%"
if /I "%DEBUG%"=="YES" (
  copy /Y /Z "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Connections\Pbk\rasphone.pbk" "%NETCONF_BACKUP%\"
  netsh.exe int ip dump>"%NETCONF_BACKUP%\interfaces.txt"
)
exit /B 1

:Restore_NetConf
setlocal
set NETCONF_BACKUP=C:\BACKUP\NET
if not "%~1"=="" set NETCONF_BACKUP=%~1
if not exist "%NETCONF_BACKUP%" goto Restore_NetConf_Fail
if exist "%NETCONF_BACKUP%\rasphone.pbk" (
  copy>nul 2>nul /Y /Z "%NETCONF_BACKUP%\rasphone.pbk" "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Connections\Pbk\" || goto Restore_NetConf_Fail
)
if not exist "%NETCONF_BACKUP%\interfaces.txt" goto Restore_NetConf_Fail
netsh.exe>nul 2>nul -F "%NETCONF_BACKUP%\interfaces.txt"
call EchoSucc Restore network configuration from "%NETCONF_BACKUP%"
exit /B 0
:Restore_NetConf_Fail
call EchoFail Restore network configuration from "%NETCONF_BACKUP%"
if /I "%DEBUG%"=="YES" (
  copy /Y /Z "%NETCONF_BACKUP%\rasphone.pbk" "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Connections\Pbk\"
  netsh.exe -F "%NETCONF_BACKUP%\interfaces.txt"
)
exit /B 1

:Finish
