@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Renews DHCP configuration for all adapters
set USAGE=

call :DHCP_Renew
goto Finish


:DHCP_Renew
ipconfig.exe>nul 2>nul /RENEW && (
  call EchoSucc Renews DHCP configuration for all adapters
  exit /B 0
)
call EchoFail Renews DHCP configuration for all adapters
if /I "%DEBUG%"=="YES" ipconfig.exe /RENEW
exit /B 1

:Finish
