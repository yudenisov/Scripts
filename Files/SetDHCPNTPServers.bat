@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set on DHCP-server NTP-servers
set USAGE=ntp_server1 [ntp_server2 [..]]

call :Set_DHCP_NTPServers "%*"
goto Finish


:Set_DHCP_NTPServers
set DHCP_NTPSERVERS=%*
set DHCP_NTPSERVERS=%DHCP_NTPSERVERS:"=%
:Set_DHCP_NTPServers_Loop
if "%DHCP_NTPSERVERS:~-1%"==" " (
  set DHCP_NTPSERVERS=%DHCP_NTPSERVERS:~0,-1%
  goto Set_DHCP_NTPServers_Loop
)
if "%DHCP_NTPSERVERS%"=="" exit /B 255
netsh.exe>nul 2>nul dhcp server set optionvalue 042 ipaddress %DHCP_NTPSERVERS% && (
  call EchoSucc Set on DHCP-server NTP-servers: "%DHCP_NTPSERVERS%"
  exit /B 0
)
call EchoFail Set on DHCP-server NTP-servers: "%DHCP_NTPSERVERS%"
if /I "%DEBUG%"=="YES" netsh.exe dhcp server set optionvalue 042 ipaddress %DHCP_NTPSERVERS%
exit /B 1

:Finish
