@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Reset IPv6 TCP/IP stack
set USAGE=

call :Reset_IP6
goto Finish


:Reset_IP6
netsh.exe>nul 2>nul int ipv6 reset nul && (
  call EchoSucc Reset IPv6 TCP/IP stack
  exit /B 0
)
call EchoFail Reset IPv6 TCP/IP stack
if /I "%DEBUG%"=="YES" netsh.exe int ipv6 reset nul
exit /B 1

:Finish
