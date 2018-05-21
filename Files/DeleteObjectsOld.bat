@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete old files or directory
set USAGE=base_dir

call :Delete_Objects_Old "%~1"
goto Finish


:Delete_Objects_Old
if "%~1"=="" exit /B 255
if not exist "%~1" (
  if /I "%DEBUG%"=="YES" call EchoFail Directory "%~1" is not exist
  exit /B 3
)
dir>nul 2>nul /A:D "%~1" || (
  if /I "%DEBUG%"=="YES" call EchoFail It is not directory: "%~1"
  exit /B 2
)
set DELETE_OBJECT_ERROR=NO
if /I "%DEBUG%"=="YES" (
  call           :Delete_Objects_Old_Sub "%~1"
) else (
  call>nul 2>nul :Delete_Objects_Old_Sub "%~1"
)
if /I "%DEBUG%"=="YES" (
  echo.
  if /I "%DELETE_OBJECT_ERROR%"=="YES" (
    exit /B 1
  )
  exit /B 0
)
if /I "%DELETE_OBJECT_ERROR%"=="YES" (
  call EchoFail Delete old files or directory "%~1"
  exit /B 1
)
call EchoSucc Delete old files or directory "%~1"
exit /B 0
:Delete_Objects_Old_Sub
call EchoTitl Delete old files or directory "%~1"
for /F "tokens=*" %%i in ('forfiles.exe 2^>nul /S /D -7 /P "%~1" /C "%COMSPEC% /C echo @path"') do call DeleteObject "%%~i"
exit /B

:Finish
