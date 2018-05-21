@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check OS type [Show returned values]
set USAGE=[list]

call :Check_OS_Type "%~1"
goto Finish


:Check_OS_Type
if /I "%~1"=="LIST" (
  call EchoTitl Returned values:
  echo   Unknown
  echo   Microsoft Windows XP
  echo   Microsowt Windows Server 2003 R2
  echo   Windows Server 2008 R2 Enterprise
  echo   Windows Server 2008 R2 Enterprise Core
  echo   Windows Server 2012 Datacenter
  echo   Hyper-V Server
  echo   Hyper-V Server Core
  exit /B 1
)
setlocal EnableDelayedExpansion
set CHECK_OS_TYPE=Unknown
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion"') do if /I "%%i"=="ProductName" if not "%%k"=="" (
  set CHECK_OS_TYPE=%%k
  call :Check_OS_Core && set CHECK_OS_TYPE=!CHECK_OS_TYPE! Core
  call EchoSucc OS Type: "%%CHECK_OS_TYPE%%"
  exit /B 0
)
call :Check_OS_Core && set CHECK_OS_TYPE=!CHECK_OS_TYPE! Core
call EchoWarn OS Type: "%%CHECK_OS_TYPE%%"
if /I "%DEBUG%"=="YES" reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /V "ProductName"
exit /B 1

:Check_OS_Core
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"') do if /I "%%i"=="Shell" if /I not "%%k"=="explorer.exe" exit /B 0
exit /B 1

:Finish
