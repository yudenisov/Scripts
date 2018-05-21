@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;%~dp0;

set  HELP=Synchronize two directories
set USAGE=copy/mirror src_absolute_path dst_absolute_path

call :Dir_Rsync "%~1" "%~2" "%~3"
goto Finish


:Dir_Rsync
if "%~1"=="" exit /B 255
if "%~2"=="" exit /B 255
if "%~3"=="" exit /B 255
set SRC=%~2
set DST=%~3
if "%SRC%"=="%SRC::=%" exit /B 255
if "%DST%"=="%DST::=%" exit /B 255
if "%SRC%"=="%DST%"    exit /B 255
if not exist "%SRC%" (
  call EchoFail Directory "%SRC%" is not exist
  exit /B 2
)
if not exist "%DST%" (
  call EchoFail Directory "%DST%" is not exist
  exit /B 3
)
set CYGWIN=nontsec
set SRC=/cygdrive/%SRC%
set SRC=%SRC:\=/%
set SRC=%SRC::=%/
set DST=/cygdrive/%DST%
set DST=%DST:\=/%
set DST=%DST::=%/
if /I "%~1"=="COPY" (
  if /I "%DEBUG%"=="YES" (
    call EchoTitl Syncronize directories, "copy" mode: "%~2" - "%~3"
    rsync.exe --verbose --perms --links --times --recursive "%SRC%" "%DST%"
    exit /B
  )
  rsync.exe>nul 2>nul --verbose --perms --links --times --recursive "%SRC%" "%DST%" && (
    call EchoSucc Syncronize directories, "copy" mode: "%~2" - "%~3"
    exit /B 0
  )
  call EchoFail Syncronize directories, "copy" mode: "%~2" - "%~3"
  exit /B 1
)
if /I "%~1"=="MIRROR" (
  if /I "%DEBUG%"=="YES" (
    call EchoTitl Syncronize directories, "mirror" mode: "%~2" - "%~3"
    rsync.exe --verbose --perms --links --times --recursive --delete-before "%SRC%" "%DST%"
    exit /B
  )
  rsync.exe>nul 2>nul --verbose --perms --links --times --recursive --delete-before "%SRC%" "%DST%" && (
    call EchoSucc Syncronize directories, "mirror" mode: "%~2" - "%~3"
    exit /B 0
  )
  call EchoFail Syncronize directories, "mirror" mode: "%~2" - "%~3"
  exit /B 1
)
exit /B 255

:Finish
