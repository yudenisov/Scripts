@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Discards DHCP configuration for all adapters
set USAGE=

call :DHCP_Release
goto Finish


:DHCP_Release
ipconfig.exe>nul 2>nul /RELEASE && (
  call EchoSucc Discards DHCP configuration for all adapters
  exit /B 0
)
call EchoFail Discards DHCP configuration for all adapters
if /I "%DEBUG%"=="YES" ipconfig.exe /RELEASE
exit /B 1

:Finish
