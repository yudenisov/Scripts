@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Echo failed
set USAGE=[message]

call :Echo_Fail %*
goto Finish


:Echo_Fail
if "%~1"=="" exit /B 255
hs_color.exe 2>nul 12
echo %*
hs_color.exe 2>nul  7
exit /B

:Finish
