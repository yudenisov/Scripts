@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set on DHCP-server in scope ip range
set USAGE=scope_ip ip_min ip_max

call :Set_DHCP_Scope_Range "%~1" "%~2" "%~3"
goto Finish


:Set_DHCP_Scope_Range
if "%~1"=="" exit /B 255
if "%~2"=="" exit /B 255
if "%~3"=="" exit /B 255
netsh.exe>nul 2>nul dhcp server scope "%~1" add iprange "%~2" "%~3" && (
  call EchoSucc Set on DHCP-server in scope "%~1" range: "%~2-%~3"
  exit /B 0
)
call EchoFail Set on DHCP-server in scope "%~1" range: "%~2-%~3"
if /I "%DEBUG%"=="YES" netsh.exe dhcp server scope "%~1" add iprange "%~2" "%~3"
exit /B 1

:Finish
