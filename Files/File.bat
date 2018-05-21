@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete/empty/make/check file
set USAGE=delete/empty/make/check file_name

if /I "%~1"=="DELETE" (
  call :Delete_File "%~2"
  goto Finish
)
if /I "%~1"=="EMPTY" (
  call :Empty_File "%~2"
  goto Finish
)
if /I "%~1"=="MAKE" (
  call :Make_File "%~2"
  goto Finish
)
if /I "%~1"=="CHECK" (
  call :Check_File "%~2"
  goto Finish
)
exit /B 255


:Delete_File
if "%~1"=="" exit /B 255
if not exist "%~1" exit /B 2
del>nul 2>nul /A /F /Q "%~1"
if not exist "%~1" (
  call EchoSucc Delete file "%~1"
  exit /B 0
)
call>nul 2>nul SetAccessMode "%~1" "Full"
del >nul 2>nul /A /F /Q      "%~1"
if not exist "%~1" (
  call EchoSucc Delete file "%~1"
  exit /B 0
)
attrib.exe>nul 2>nul -R -S -H "%~1"
move>nul 2>nul "%~1" "%TEMP%\"
if not exist "%~1" (
  call EchoSucc Delete file "%~1"
  exit /B 0
)
set DELETE_OBJECT_ERROR=YES
call EchoFail Delete file "%~1"
if /I "%DEBUG%"=="YES" del /A /F /Q "%~1"
exit /B 1

:Empty_File
if "%~1"=="" exit /B 255
if not exist "%~1" exit /B 2
del>nul 2>nul /A /F /Q "%~1"
if not exist "%~1" (
  touch.exe>nul 2>nul "%~1" && (
    call EchoSucc Empty file "%~1"
    exit /B 0
  )
)
call EchoFail Empty file "%~1"
if /I "%DEBUG%"=="YES" (
  del /A /F /Q "%~1"
  touch.exe "%~1"
)
exit /B 1

:Make_File
if "%~1"=="" exit /B 255
touch.exe>nul 2>nul "%~1" && (
  call EchoSucc Make file "%~1"
  exit /B 0
)
call EchoFail Make file "%~1"
if /I "%DEBUG%"=="YES" touch.exe "%~1"
exit /B 1

:Check_File
if "%~1"=="" exit /B 255
if not exist "%~1" (
  call EchoFail File "%~1" is not exist
  exit /B 2
)
dir>nul 2>nul /A:D "%~1" || (
  call EchoSucc File "%~1" is exist
  if /I "%DEBUG%"=="YES" dir 2>&1 /A:-D "%~1"|%SystemRoot%\System32\find.exe /I "%~nx1"
  exit /B 0
)
call EchoFail It is not file: "%~1"
if /I "%DEBUG%"=="YES" dir 2>&1 /A:-D "%~1"|%SystemRoot%\System32\find.exe /I "%~nx1"
exit /B 1

:Finish
