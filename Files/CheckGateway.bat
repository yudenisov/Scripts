@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check gateway
set USAGE=

call :Check_Gateway
goto Finish


:Check_Gateway
set CHECK_GATEWAY=
for /F "tokens=1,2,3" %%i in ('route.exe 2^>nul print') do if "%%i"=="0.0.0.0" if "%%j"=="0.0.0.0" (
  set CHECK_GATEWAY=%%k
  call EchoSucc Gateway found: "%%CHECK_GATEWAY%%"
  exit /B 0
)
call EchoWarn Gateway not found
if /I "%DEBUG%"=="YES" route.exe print
exit /B 1

:Finish
