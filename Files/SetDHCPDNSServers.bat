@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set on DHCP-server DNS-servers
set USAGE=dns_server1 [dns_server2 [..]]

call :Set_DHCP_DNSServers "%*"
goto Finish


:Set_DHCP_DNSServers
set DHCP_DNSSERVERS=%*
set DHCP_DNSSERVERS=%DHCP_DNSSERVERS:"=%
:Set_DHCP_DNSServers_Loop
if "%DHCP_DNSSERVERS:~-1%"==" " (
  set DHCP_DNSSERVERS=%DHCP_DNSSERVERS:~0,-1%
  goto Set_DHCP_DNSServers_Loop
)
if "%DHCP_DNSSERVERS%"=="" exit /B 255
netsh.exe>nul 2>nul dhcp server set optionvalue 006 ipaddress %DHCP_DNSSERVERS% && (
  call EchoSucc Set on DHCP-server DNS-servers: "%DHCP_DNSSERVERS%"
  exit /B 0
)
call EchoFail Set on DHCP-server DNS-servers: "%DHCP_DNSSERVERS%"
if /I "%DEBUG%"=="YES" netsh.exe dhcp server set optionvalue 006 ipaddress %DHCP_DNSSERVERS%
exit /B 1

:Finish
