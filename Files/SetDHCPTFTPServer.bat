@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set on DHCP-server TFTP-server
set USAGE=tftp_server

call :Set_DHCP_TFTPServer "%~1"
goto Finish


:Set_DHCP_TFTPServer
if "%~1"=="" exit /B 255
netsh.exe>nul 2>nul dhcp server set optionvalue 066 string "%~1" && (
  call EchoSucc Set on DHCP-server TFTP-server: "%~1"
  exit /B 0
)
call EchoFail Set on DHCP-server TFTP-server: "%~1"
if /I "%DEBUG%"=="YES" netsh.exe dhcp server set optionvalue 066 string "%~1"
exit /B 1

:Finish
