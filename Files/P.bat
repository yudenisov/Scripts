@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Ping to host [8.8.8.8]
set USAGE=[host]

call :Ping_Host "%~1"
goto Finish


:Ping_Host
set HOST=8.8.8.8
if not "%~1"=="" set HOST=%~1
ping.exe 2>&1 %HOST% -n 5|%SystemRoot%\System32\find.exe>nul 2>nul /I "TTL=" && (
  call EchoSucc Ping to "%HOST%"
  exit /B 0
)
call EchoFail Ping to "%HOST%"
if /I "%DEBUG%"=="YES" ping.exe %HOST% -n 5
exit /B 1

:Finish
