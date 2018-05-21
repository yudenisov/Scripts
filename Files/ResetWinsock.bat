@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Reset winsock entries
set USAGE=

call :Reset_Winsock
goto Finish


:Reset_Winsock
netsh.exe>nul 2>nul winsock reset && (
  call EchoSucc Reset winsock entries
  exit /B 0
)
call EchoFail Reset winsock entries
if /I "%DEBUG%"=="YES" netsh.exe winsock reset
exit /B 1

:Finish
