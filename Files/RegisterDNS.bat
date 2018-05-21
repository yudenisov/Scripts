@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Refresh all DHCP leases and re-register DNS names
set USAGE=

call :DNS_Register
goto Finish


:DNS_Register
ipconfig.exe>nul 2>nul /REGISTERDNS && (
  call EchoSucc Refresh all DHCP leases and re-register DNS names
  exit /B 0
)
call EchoFail Refresh all DHCP leases and re-register DNS names
if /I "%DEBUG%"=="YES" ipconfig.exe /REGISTERDNS
exit /B 1

:Finish
