@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Suspend computer
set USAGE=

call :Suspend
goto Finish


:Suspend
rundll32.exe>nul 2>nul powrprof.dll,SetSuspendState && (
  call EchoSucc Suspend computer
  exit /B 0
)
call EchoFail Suspend computer
if /I "%DEBUG%"=="YES" rundll32.exe powrprof.dll,SetSuspendState
exit /B 1

:Finish
