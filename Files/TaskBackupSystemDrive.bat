@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete/add/check task backup system drive [to D:]
set USAGE=delete/add/check [backup_target]

if /I "%~1"=="DELETE" (
  call :Delete_Task_Backup_System_Drive
  goto Finish
)
if /I "%~1"=="ADD" (
  call :Add_Task_Backup_System_Drive "%~2"
  goto Finish
)
if /I "%~1"=="CHECK" (
  call :Check_Task_Backup_System_Drive
  goto Finish
)
exit /B 255


:Delete_Task_Backup_System_Drive
wbadmin.exe>nul 2>nul disable backup -quiet && (
  call EchoSucc Delete task backup system drive
  exit /B 0
)
call EchoFail Delete task backup system drive
if /I "%DEBUG"=="YES" wbadmin.exe disable backup -quiet
exit /B 1

:Add_Task_Backup_System_Drive
setlocal
set TASK_BACKUP_DST=%~1
if "%TASK_BACKUP_DST%"=="" set TASK_BACKUP_DST=D:
wbadmin.exe>nul 2>nul disable backup -quiet
wbadmin.exe>nul 2>nul enable  backup -quiet -allcritical -addtarget:%TASK_BACKUP_DST% -include:%SYSTEMDRIVE% -schedule:21:00 && (
  call EchoSucc Add task backup system drive, run mode: "daily, 21:00", target: "%TASK_BACKUP_DST%"
  exit /B 0
)
call EchoFail Add task backup system drive, run mode: "daily, 21:00", target: "%TASK_BACKUP_DST%"
if /I "%DEBUG%"=="YES" wbadmin.exe enable backup -quiet -allcritical -addtarget:%TASK_BACKUP_DST% -include:%SYSTEMDRIVE% -schedule:21:00
exit /B 1

:Check_Task_Backup_System_Drive
schtasks.exe>nul 2>nul /QUERY /TN "\Microsoft\Windows\Backup\Microsoft-Windows-WindowsBackup" && (
  call EchoSucc Task backup system drive is exist
  exit /B 0
)
call EchoFail Task backup system drive is not exist
if /I "%DEBUG%"=="YES" schtasks.exe /QUERY /TN "\Microsoft\Windows\Backup\Microsoft-Windows-WindowsBackup"
exit /B 1

:Finish
