@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Waiting any key press [or specified time]
set USAGE=[seconds]

call :Wait "%~1"
goto Finish


:Wait
set WAIT_TIME=%~1
if "%WAIT_TIME%"=="" (
  pause>nul 2>nul
  exit /B 0
)
setlocal EnableDelayedExpansion
set /A WAIT_TIME=%WAIT_TIME%+1
ping.exe>nul 2>nul 127.0.0.1 -n !WAIT_TIME!
exit /B

:Finish
