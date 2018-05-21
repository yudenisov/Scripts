@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Echo success
set USAGE=[message]

call :Echo_Succ %*
goto Finish


:Echo_Succ
if "%~1"=="" exit /B 255
hs_color.exe 2>nul 10
echo %*
hs_color.exe 2>nul 7
exit /B

:Finish
