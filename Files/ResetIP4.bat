@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Reset IPv4 TCP/IP stack
set USAGE=

call :Reset_IP4
goto Finish


:Reset_IP4
netsh.exe>nul 2>nul int ip reset nul && (
  call EchoSucc Reset IPv4 TCP/IP stack
  exit /B 0
)
call EchoFail Reset IPv4 TCP/IP stack
if /I "%DEBUG%"=="YES" netsh.exe int ip reset nul
exit /B 1

:Finish
