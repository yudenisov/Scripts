@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Backup/restore/list USB storage to/from image [C:\image.imz]
set USAGE=[backup/restore drive [image]]

if /I "%~1"=="BACKUP" (
  call :USB_Storage "BACKUP"  "%~2" "%~3"
  goto Finish
)
if /I "%~1"=="RESTORE" (
  call :USB_Storage "RESTORE" "%~2" "%~3"
  goto Finish
)
call :USB_Storage "LIST"
exit /B 255


:USB_Storage
setlocal
set MODE=%~1
if /I "%MODE%"=="LIST" (
  usbitcmd.exe L
  exit /B 0
)
set DRIVE=%~2
if "%DRIVE%"=="" (
  echo ERROR: Drive %DRIVE%: not specified
  exit /B 1
)
set DRIVE=%DRIVE::=%:
for /F %%i in ('disknum.exe 2^>nul %DRIVE%') do set DRIVENUM=%%i
if "%DRIVENUM%"=="" (
  echo ERROR: Drive %DRIVE%: not detected
  exit /B 2
)
if "%DRIVENUM%"=="0" (
  echo ERROR: Drive %DRIVE%: is not USB device
  exit /B 3
)
set IMAGE=%~3
if "%IMAGE%"=="" (
  set IMAGE=C:\image.imz
)
if /I "%MODE%"=="BACKUP"  usbitcmd.exe B %DRIVENUM% %IMAGE% /P /D /C
if /I "%MODE%"=="RESTORE" usbitcmd.exe R %DRIVENUM% %IMAGE% /P /D
exit /B

:Finish
