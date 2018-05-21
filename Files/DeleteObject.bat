@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete file or directory
set USAGE=file_or_dir

call :Delete_Object "%~1"
goto Finish


:Delete_Object
if "%~1"=="" exit /B 255
if not exist "%~1" (
  if /I "%DEBUG%"=="YES" call EchoFail Object "%~1" is not exist
  exit /B 2
)
dir>nul 2>nul /A:D "%~1" && (
  rmdir>nul 2>nul /S /Q "%~1"
  if not exist "%~1" (
    call EchoSucc Delete directory "%~1"
    exit /B 0
  )
  call >nul 2>nul SetAccessMode "%~1" "Full"
  rmdir>nul 2>nul /S /Q "%~1"
  if not exist "%~1" (
    call EchoSucc Delete directory "%~1"
    exit /B 0
  )
  set DELETE_OBJECT_ERROR=YES
  call EchoFail Delete directory "%~1"
  if /I "%DEBUG%"=="YES" rmdir>nul /S /Q "%~1"
  exit /B 1
)
del>nul 2>nul /A /F /Q "%~1"
if not exist "%~1" (
  call EchoSucc Delete file "%~1"
  exit /B 0
)
call>nul 2>nul SetAccessMode "%~1" "Full"
del >nul 2>nul /A /F /Q         "%~1"
if not exist "%~1" (
  call EchoSucc Delete file "%~1"
  exit /B 0
)
set DELETE_OBJECT_ERROR=YES
call EchoFail Delete file "%~1"
if /I "%DEBUG%"=="YES" del>nul /A /F /Q "%~1"
exit /B 1

:Finish
