@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Terminates a session
set USAGE=

call :Logout
goto Finish


:Logout
logoff.exe>nul 2>nul
exit /B

:Finish
