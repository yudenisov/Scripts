@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Run a command with administrator rights
set USAGE=[command [parameters]]

call :Elevate_Cmd %*
goto Finish


:Elevate_Cmd
nircmd.exe elevate "%COMSPEC%" /K %*
exit /B

:Finish
