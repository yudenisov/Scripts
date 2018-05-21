@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Repair disk
set USAGE=disk

call :Repair_Disk "%~1"
goto Finish


:Repair_Disk
if "%~1"=="" exit /B 255
chkdsk.exe %~1 /F /X
exit /B

:Finish
