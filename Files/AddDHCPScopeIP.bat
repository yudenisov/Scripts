@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Add on DHCP-server in scope reserved IP
set USAGE=scope_ip host_ip host_mac host_name

call :Add_DHCP_Scope_IP "%~1" "%~2" "%~3" "%~4"
goto Finish


:Add_DHCP_Scope_IP
if "%~1"=="" exit /B 255
if "%~2"=="" exit /B 255
if "%~3"=="" exit /B 255
if "%~4"=="" exit /B 255
set HOST_MAC=%~3
set HOST_MAC=%HOST_MAC::=%
set HOST_MAC=%HOST_MAC:-=%
netsh.exe>nul 2>nul dhcp server scope "%~1" add reservedip "%~2" "%HOST_MAC%" "%~4" && (
  call EchoSucc Add on DHCP-server in scope "%~1" reserved IP: "%~2"
  exit /B 0
)
call EchoFail Add on DHCP-server in scope "%~1" reserved IP: "%~2"
if /I "%DEBUG%"=="YES" netsh.exe dhcp server scope "%~1" add reservedip "%~2" "%HOST_MAC%" "%~4"
exit /B 1

:Finish
