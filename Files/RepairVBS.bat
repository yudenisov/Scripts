@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Repair Visual Basic Script engine
set USAGE=

call :Repair_VBS
goto Finish


:Repair_VBS
call EchoSucc Repair Visual Basic Script engine
regsvr32.exe /S "%SYSTEMROOT%\SYSTEM32\vbscript.dll"
exit /B

:: http://forum.oszone.net/post-1482725.html

:Finish
