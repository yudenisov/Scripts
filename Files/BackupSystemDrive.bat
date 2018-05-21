@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Backup system drive to target [D:]
set USAGE=[backup_target]

call :Backup_System_Drive "%~1"
goto Finish


:Backup_System_Drive
setlocal
set BACKUP_SYSTEM_DRIVE_TARGET=%~1
if "%BACKUP_SYSTEM_DRIVE_TARGET%"=="" set BACKUP_SYSTEM_DRIVE_TARGET=D:
call EchoTitl Backup system drive to target "%BACKUP_SYSTEM_DRIVE_TARGET%"
call Feature Enable "WindowsServerBackup"
wbadmin.exe 2>&1 >"%TEMP%\BackupSystemDrive.tmp" start backup -quiet -allcritical -backuptarget:%BACKUP_SYSTEM_DRIVE_TARGET% -include:%SYSTEMDRIVE% && (
  call EchoSucc Backup system drive to target "%BACKUP_SYSTEM_DRIVE_TARGET%"
  del>nul 2>nul /A /F /Q "%TEMP%\BackupSystemDrive.tmp"
  call Wait 15
  exit /B 0
)
call EchoFail Backup system drive to target "%BACKUP_SYSTEM_DRIVE_TARGET%"
if /I "%DEBUG%"=="YES" type 2>nul "%TEMP%\BackupSystemDrive.tmp"
del>nul 2>nul /A /F /Q "%TEMP%\BackupSystemDrive.tmp"
call Wait 15
exit /B 1

:Finish
