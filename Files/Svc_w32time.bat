@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Unregister/register service w32time
set USAGE=unregister/register

if /I "%~1"=="UNREGISTER" (
  call :Unregister_Svc_w32time
  goto Finish
)
if /I "%~1"=="REGISTER" (
  call :Register_Svc_w32time
  goto Finish
)
exit /B 255


:Unregister_Svc_w32time
w32tm.exe 2>&1 /unregister|%SystemRoot%\System32\find.exe>nul 2>nul /I "успешно" && (
  call EchoSucc Unregister service "w32time"
  exit /B 0
)
call EchoFail Unregister service "w32time"
if /I "%DEBUG%"=="YES" w32tm.exe /unregister
exit /B 1

:Register_Svc_w32time
w32tm.exe 2>&1 /register|%SystemRoot%\System32\find.exe>nul 2>nul /I "успешно зарегистрирована" && (
  call EchoSucc Register service "w32time"
  exit /B 0
)
w32tm.exe 2>&1 /register|%SystemRoot%\System32\find.exe>nul 2>nul /I "отказано в доступе" && (
  call :Unregister_Svc_w32time
  w32tm.exe 2>&1 /register|%SystemRoot%\System32\find.exe>nul 2>nul /I "успешно зарегистрирована" && (
    call EchoSucc Register service "w32time"
    exit /B 0
  )
)
call EchoFail Register service "w32time"
if /I "%DEBUG%"=="YES" w32tm.exe /register
exit /B 1

:Finish
