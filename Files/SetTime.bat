@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set Time and Date
set USAGE=

call :Set_Time
goto Finish


:Set_Time
control.exe>nul 2>nul timedate.cpl
exit /B

:Finish
