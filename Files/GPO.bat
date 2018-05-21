@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Backup or restore all GPOs [to C:\BACKUP\GPO\%DATE:~6%-%DATE:~3,2%-%DATE:~0,2%]
set USAGE=backup/restore [backup_dir]

if /I "%~1"=="BACKUP" (
  call :Backup_All_GPOs "%~2"
  goto Finish
)
if /I "%~1"=="RESTORE" (
  call :Restore_All_GPOs "%~2"
  goto Finish
)
exit /B 255


:Backup_All_GPOs
setlocal
set GPOS_BACKUP=C:\BACKUP\GPO\%DATE:~6%-%DATE:~3,2%-%DATE:~0,2%
if not "%~1"=="" set GPOS_BACKUP=%~1
if exist "%GPOS_BACKUP%" (
  call EchoFail Backup all GPOs to "%GPOS_BACKUP%" - directory already exist
  exit /B 3
)
mkdir>nul 2>nul "%GPOS_BACKUP%"
if not exist "%GPOS_BACKUP%" (
  call EchoFail Backup all GPOs to "%GPOS_BACKUP%" - can`t make directory
  exit /B 2
)
mkdir  >nul 2>nul "%TEMP%"
cscript.exe 2>&1 >"%TEMP%\GPO_Backup.tmp" /NOLOGO "%SYSTEMROOT%\SYSTEM32\BackupAllGPOs.wsf" "%GPOS_BACKUP%" /Comment:"GPO Backup on %DATE%"
type 2>nul "%TEMP%\GPO_Backup.tmp"|%SystemRoot%\System32\find.exe>nul 2>nul /I "Backup failed for 0 GPOs" || (
  call EchoFail Backup all GPOs to "%GPOS_BACKUP%"
  if /I "%DEBUG%"=="YES" type 2>nul "%TEMP%\GPO_Backup.tmp"
  del>nul 2>nul /A /F /Q "%TEMP%\GPO_Backup.tmp"
  exit /B 1
)
call EchoSucc Backup all GPOs to "%GPOS_BACKUP%"
del>nul 2>nul /A /F /Q "%TEMP%\GPO_Backup.tmp"
exit /B 0

:Restore_All_GPOs
setlocal
set GPOS_BACKUP=C:\BACKUP\GPO\%DATE:~6%-%DATE:~3,2%-%DATE:~0,2%
if not "%~1"=="" set GPOS_BACKUP=%~1
if not exist "%GPOS_BACKUP%" (
  call EchoFail Restore all GPOs from "%GPOS_BACKUP%" - directory not exist
  exit /B 2
)
mkdir  >nul 2>nul "%TEMP%"
cscript.exe 2>&1 >"%TEMP%\GPO_Restore.tmp" /NOLOGO "%SYSTEMROOT%\SYSTEM32\RestoreAllGPOs.wsf" "%GPOS_BACKUP%"
type 2>nul "%TEMP%\GPO_Restore.tmp"|%SystemRoot%\System32\find.exe>nul 2>nul /I "Restore failed for 0 GPOs" || (
  call EchoFail Restore all GPOs from "%GPOS_BACKUP%"
  if /I "%DEBUG%"=="YES" type 2>nul "%TEMP%\GPO_Restore.tmp"
  del>nul 2>nul /A /F /Q "%TEMP%\GPO_Restore.tmp"
  exit /B 1
)
call EchoSucc Restore all GPOs from "%GPOS_BACKUP%"
del>nul 2>nul /A /F /Q "%TEMP%\GPO_Restore.tmp"
exit /B 0

:Finish
