@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Add on DHCP-server scope
set USAGE=scope_ip scope_mask scope_name

call :Add_DHCP_Scope "%~1" "%~2" "%~3"
goto Finish


:Add_DHCP_Scope
if "%~1"=="" exit /B 255
if "%~2"=="" exit /B 255
if "%~3"=="" exit /B 255
netsh.exe>nul 2>nul dhcp server delete scope "%~1" dhcpfullforce
netsh.exe>nul 2>nul dhcp server add scope "%~1" "%~2" "%~3" && (
  call EchoSucc Add on DHCP-server scope: "%~1" "%~2" "%~3"
  exit /B 0
)
call EchoFail Add on DHCP-server scope: "%~1" "%~2" "%~3"
if /I "%DEBUG%"=="YES" (
  netsh.exe>nul 2>nul dhcp server delete scope "%~1" dhcpfullforce
  netsh.exe dhcp server add scope "%~1" "%~2" "%~3"
)
exit /B 1

:Finish
