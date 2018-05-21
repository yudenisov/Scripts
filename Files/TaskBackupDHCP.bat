@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete/add task backup DHCP-server params [to C:\BACKUP\DHCP]
set USAGE=delete/add [backup_path]

if /I "%~1"=="DELETE" (
  call :Delete_Task_Backup_DHCP "%~2"
  goto Finish
)
if /I "%~1"=="ADD" (
  call :Add_Task_Backup_DHCP "%~2"
  goto Finish
)
exit /B 255


:Delete_Task_Backup_DHCP
setlocal
set TASK_BACKUP_DST=%~1
if "%TASK_BACKUP_DST%"=="" set TASK_BACKUP_DST=C:\BACKUP\DHCP
set TASK_BACKUP_DST_NAME=%TASK_BACKUP_DST:\\=%
set TASK_BACKUP_DST_NAME=%TASK_BACKUP_DST_NAME:\=_%
set TASK_BACKUP_DST_NAME=%TASK_BACKUP_DST_NAME::=%
set TASK_BACKUP_DST_NAME=%TASK_BACKUP_DST_NAME:$=%
set TASK_BACKUP_DST_NAME=%TASK_BACKUP_DST_NAME: =%
call Task Delete "Backup DHCP to %TASK_BACKUP_DST_NAME%"
exit /B

:Add_Task_Backup_DHCP
setlocal
set TASK_BACKUP_DST=%~1
if "%TASK_BACKUP_DST%"=="" set TASK_BACKUP_DST=C:\BACKUP\DHCP
set TASK_BACKUP_DST_NAME=%TASK_BACKUP_DST:\\=%
set TASK_BACKUP_DST_NAME=%TASK_BACKUP_DST_NAME:\=_%
set TASK_BACKUP_DST_NAME=%TASK_BACKUP_DST_NAME::=%
set TASK_BACKUP_DST_NAME=%TASK_BACKUP_DST_NAME:$=%
set TASK_BACKUP_DST_NAME=%TASK_BACKUP_DST_NAME: =%
mkdir>nul 2>nul "%TASK_BACKUP_DST%"
if not exist "%TASK_BACKUP_DST%" (
  call EchoFail Add task "Backup DHCP to %TASK_BACKUP_DST_NAME%", run mode: "hourly"
  if /I "%DEBUG%"=="YES" echo Backup path "%TASK_BACKUP_DST%" not exist
  exit /B 1
)
call Task Add "Backup DHCP to %TASK_BACKUP_DST_NAME%" "hourly" "%%SYSTEMROOT%%\ExportDHCP.bat %TASK_BACKUP_DST%\dhcp.dat"
exit /B

:Finish
