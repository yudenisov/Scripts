@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Echo warning
set USAGE=[message]

call :Echo_Warn %*
goto Finish


:Echo_Warn
if "%~1"=="" exit /B 255
hs_color.exe 2>nul 13
echo %*
hs_color.exe 2>nul  7
exit /B

:Finish
