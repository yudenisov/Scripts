@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check KMS-server records in DNS
set USAGE=

call :Check_KMS_In_DNS
goto Finish


:Check_KMS_In_DNS
setlocal EnableDelayedExpansion
call :Get_DNS_Suffixes
if "%DNS_SUFFIXES%"=="" (
  call EchoWarn DNS-suffixes not found
  nslookup.exe 2>&1 -type=srv _vlmcs._tcp|%SystemRoot%\System32\find.exe>nul 2>nul /I "svr hostname" && (
    call EchoSucc KMS-server records found in DNS
    if /I "%DEBUG%"=="YES" nslookup.exe -type=srv _vlmcs._tcp
    exit /B 0
  )
  call EchoFail KMS-server records not found in DNS
  if /I "%DEBUG%"=="YES" nslookup.exe -type=srv _vlmcs._tcp
  exit /B 1
)
call EchoWarn Found DNS-suffixes: "%DNS_SUFFIXES%"
for %%i in (%DNS_SUFFIXES%) do nslookup.exe 2>&1 -type=srv _vlmcs._tcp.%%i|%SystemRoot%\System32\find.exe>nul 2>nul /I "svr hostname" && (
  call EchoSucc KMS-server records found in "%%i"
  if /I "%DEBUG%"=="YES" nslookup.exe -type=srv _vlmcs._tcp.%%i
  exit /B 0
)
call EchoFail KMS-server records not found in DNS
if /I "%DEBUG%"=="YES" for %%i in (%DNS_SUFFIXES%) do (
  nslookup.exe -type=srv _vlmcs._tcp.%%i
  echo.
)
exit /B 1

:Get_DNS_Suffixes
set DNS_SUFIXES=
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /S') do if not "%%k"=="" (
  if /I "%%i"=="Domain" (
    echo ,!DNS_SUFFIXES!,|%SystemRoot%\System32\find.exe>nul 2>nul /I ",%%k,"
    if errorlevel 1 set DNS_SUFFIXES=!DNS_SUFFIXES!,%%k
  )
  if /I "%%i"=="SearchList" (
    echo ,!DNS_SUFFIXES!,|%SystemRoot%\System32\find.exe>nul 2>nul /I ",%%k,"
    if errorlevel 1 set DNS_SUFFIXES=!DNS_SUFFIXES!,%%k
  )
)
if "!DNS_SUFFIXES:~0,1!"=="," set DNS_SUFFIXES=!DNS_SUFFIXES:~1!
if not "!DNS_SUFFIXES!"==""   set DNS_SUFFIXES=!DNS_SUFFIXES:,= !
exit /B 0

:Finish
