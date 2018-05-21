@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set on DHCP-server in scope gateway
set USAGE=scope_ip gateway

call :Set_DHCP_Scope_Gateway "%~1" "%~2"
goto Finish


:Set_DHCP_Scope_Gateway
if "%~1"=="" exit /B 255
if "%~2"=="" exit /B 255
netsh.exe>nul 2>nul dhcp server scope "%~1" set optionvalue 003 ipaddress "%~2" && (
  call EchoSucc Set on DHCP-server in scope "%~1" gateway: "%~2"
  exit /B 0
)
call EchoFail Set on DHCP-server in scope "%~1" gateway: "%~2"
if /I "%DEBUG%"=="YES" netsh.exe dhcp server scope "%~1" set optionvalue 003 ipaddress "%~2"
exit /B 1

:Finish
