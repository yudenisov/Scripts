@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set on DHCP-server DNS-suffix
set USAGE=dns_suffix

call :Set_DHCP_DNSSuffix  "%~1"
goto Finish


:Set_DHCP_DNSSuffix
if "%~1"=="" exit /B 255
netsh.exe>nul 2>nul dhcp server set optionvalue 015 string "%~1" && (
  call EchoSucc Set on DHCP-server DNS-suffix: "%~1"
  exit /B 0
)
call EchoFail Set on DHCP-server DNS-suffix: "%~1"
if /I "%DEBUG%"=="YES" netsh.exe dhcp server set optionvalue 015 string "%~1"
exit /B 1

:Finish
