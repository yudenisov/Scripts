@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Sync time
set USAGE=

call :Sync_Time
goto Finish


:Sync_Time
call>nul FlushDNS
w32tm.exe 2>&1 /resync /rediscover|%SystemRoot%\System32\find.exe>nul 2>nul /I "выполнена успешно" && (
  call EchoSucc Sync time
  exit /B 0
)
w32tm.exe 2>&1 /resync /rediscover|%SystemRoot%\System32\find.exe>nul 2>nul /I "выполнена успешно" && (
  call EchoSucc Sync time
  exit /B 0
)
call EchoFail Sync Time
if /I "%DEBUG%"=="YES" (
  w32tm.exe /resync /rediscover
  w32tm.exe /monitor
)
exit /B 1

:Finish
