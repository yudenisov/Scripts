@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set on DHCP-server DNS credentials
set USAGE=[domain\user [pass]]

call :Set_DHCP_DNSCredentials "%~1" "%~2"
goto Finish


:Set_DHCP_DNSCredentials
for /F "tokens=1,2 delims=\" %%i in ('echo.%~1') do (
  if "%%j"=="" exit /B 255
  set DNSCREDENTIALS_DOMAIN=%%i
  set DNSCREDENTIALS_USER=%%j
)
setlocal EnableDelayedExpansion
if "%DNSCREDENTIALS_DOMAIN%"=="" (
  for /F "tokens=1-3" %%i in ('netdom.exe 2^>nul /QUERY fsmo^|%SystemRoot%\System32\find.exe 2^>nul /I "Хозяин схемы"') do if not "%%k"=="" (
    set DNSCREDENTIALS_DOMAIN=%%k
    set DNSCREDENTIALS_DOMAIN=!DNSCREDENTIALS_DOMAIN:*.=!
  )
)
if "%DNSCREDENTIALS_USER%"=="" set DNSCREDENTIALS_USER=DHCPDNSupd
set DNSCREDENTIALS_PASS=%~2
if "%DNSCREDENTIALS_PASS%"=="" set DNSCREDENTIALS_PASS=mEsIBynXb7OPwy
netsh.exe>nul 2>nul dhcp server set dnscredentials "%DNSCREDENTIALS_USER%" "%DNSCREDENTIALS_DOMAIN%" "%DNSCREDENTIALS_PASS%" && goto Set_DHCP_DNSCredentials_Succ
call EchoFail Set on DHCP-server DNS credentials. User "%DNSCREDENTIALS_DOMAIN%\%DNSCREDENTIALS_USER%"
if /I "%DEBUG%"=="YES" netsh.exe dhcp server set dnscredentials "%DNSCREDENTIALS_USER%" "%DNSCREDENTIALS_DOMAIN%" "%DNSCREDENTIALS_PASS%"
exit /B 1
:Set_DHCP_DNSCredentials_Succ
call EchoSucc Set on DHCP-server DNS credentials. User "%DNSCREDENTIALS_DOMAIN%\%DNSCREDENTIALS_USER%"
call>nul Svc Stop  DHCPServer
call>nul Svc Start DHCPServer
exit /B 0

:Finish
