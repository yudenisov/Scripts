@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete on DHCP-server scope
set USAGE=scope_ip

call :Delete_DHCP_Scope "%~1"
goto Finish


:Delete_DHCP_Scope
if "%~1"=="" exit /B 255
netsh.exe>nul 2>nul dhcp server delete scope "%~1" dhcpfullforce && (
  call EchoSucc Delete on DHCP-server scope "%~1"
  exit /B 0
)
call EchoFail Delete on DHCP-server scope "%~1"
if /I "%DEBUG%"=="YES" netsh.exe dhcp server delete scope "%~1" dhcpfullforce
exit /B 1

:Finish
