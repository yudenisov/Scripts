@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Backup/restore drivers to directory [C:\BACKUP\DRIVER\DoubleDriver]
set USAGE=backup/restore [backup_dir]

if /I "%~1"=="BACKUP" (
  call :Backup_Drivers "%~2"
  goto Finish
)
if /I "%~1"=="RESTORE" (
  call :Restore_Drivers "%~2"
  goto Finish
)
exit /B 255


:Backup_Drivers
setlocal
set DRIVERS_BACKUP=C:\BACKUP\DRIVER\DoubleDriver
if not "%~1"=="" set DRIVERS_BACKUP=%~1
mkdir>nul 2>nul "%DRIVERS_BACKUP%"
if not exist "%DRIVERS_BACKUP%" (
  call EchoFail Backup drivers to "%DRIVERS_BACKUP%" - can`t make directory
  exit /B 2
)
ddriverc.exe>nul 2>nul B /TARGET:"%DRIVERS_BACKUP%" || (
  call EchoFail Backup drivers to "%DRIVERS_BACKUP%"
  if /I "%DEBUG%"=="YES" ddriverc.exe B /TARGET:"%DRIVERS_BACKUP%"
  exit /B 1
)
call EchoSucc Backup drivers to "%DRIVERS_BACKUP%"
exit /B 0

:Restore_Drivers
setlocal
set DRIVERS_BACKUP=C:\BACKUP\DRIVER
if not "%~1"=="" set DRIVERS_BACKUP=%~1
if not exist "%SYSTEMROOT%\SYSTEM32\dd.dll" (
  call EchoFail Restore drivers from "%DRIVERS_BACKUP%" - file "dd.dll" not found
  exit /B 3
)
if not exist "%DRIVERS_BACKUP%" (
  call EchoFail Restore drivers from "%DRIVERS_BACKUP%" - directory not exist
  exit /B 2
)
ddriverc.exe>nul 2>nul R /SOURCE:"%DRIVERS_BACKUP%" || (
  call EchoFail Restore drivers from "%DRIVERS_BACKUP%"
  if /I "%DEBUG%"=="YES" ddriverc.exe R /SOURCE:"%DRIVERS_BACKUP%"
  exit /B 1
)
call EchoSucc Restore drivers from "%DRIVERS_BACKUP%"
exit /B 0

:Finish
