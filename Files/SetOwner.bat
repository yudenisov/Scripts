@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set owner for file or directory
set USAGE=file_or_dir [user]

call :Set_Owner "%~1" "%~2"
goto Finish


:Set_Owner
if "%~1"=="" exit /B 255
if not exist "%~1" exit /B 2
set OWNER=%~2
if "%OWNER%"=="" set OWNER=%USERNAME%
hidec.exe subinacl.exe /file "%~1" /owner=%OWNER%
call>nul Directory Check "%~1" && hidec.exe subinacl.exe /subdirectories "%~1\*.*" /owner=%OWNER%
call EchoSucc Set owner "%OWNER%" to "%~1"
exit /B 0

:Finish
