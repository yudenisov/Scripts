@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Cleaning log events
set USAGE=

call :Cleaning_Log_Events
goto Finish


:Cleaning_Log_Events
if not exist "%SYSTEMROOT%\SYSTEM32\WINEVT\LOGS\security.evtx" goto Cleaning_Log_Events_Succ
taskkill.exe>nul 2>nul /FI "IMAGENAME eq svchost.exe" /FI "SERVICES eq eventlog" /F
ping.exe    >nul 2>nul 127.0.0.1 -n 2
del         >nul 2>nul /A /F /Q "%SYSTEMROOT%\SYSTEM32\WINEVT\LOGS\*.evtx"
if not exist "%SYSTEMROOT%\SYSTEM32\WINEVT\LOGS\*.evtx" goto Cleaning_Log_Events_Succ
ping.exe    >nul 2>nul 127.0.0.1 -n 2
net.exe     >nul 2>nul start "eventlog"
call EchoFail Cleaning Log Events
exit /B 1
:Cleaning_Log_Events_Succ
ping.exe    >nul 2>nul 127.0.0.1 -n 2
net.exe     >nul 2>nul start "eventlog"
call EchoSucc Cleaning Log Events
exit /B 0

:Finish
