@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete/empty/make/check directory
set USAGE=delete/empty/make/check directory_name

if /I "%~1"=="DELETE" (
  call :Delete_Dir "%~2"
  goto Finish
)
if /I "%~1"=="EMPTY" (
  call :Empty_Dir "%~2"
  goto Finish
)
if /I "%~1"=="MAKE" (
  call :Make_Dir "%~2"
  goto Finish
)
if /I "%~1"=="CHECK" (
  call :Check_Dir "%~2"
  goto Finish
)
exit /B 255


:Delete_Dir_Tree
if "%~1"=="" exit /B 255
if not exist "%~1" exit /B 2
rmdir>nul 2>nul /S /Q "%~f1"
if not exist "%~1" exit /B 0
:Delete_Dir_Tree_Sub
setlocal
set tmp=%~3
if "%tmp%"=="" set tmp=%TEMP%\tmp_deltree_%RANDOM%
mkdir>nul 2>nul "%tmp%"
set i=%~2
if "%i%"=="" set i=0
set /A i=%i% + 1
del>nul 2>nul /A /F /Q "%~f1"\*
for /D %%d in ("%~f1"\*) do move>nul 2>nul "%%~d" "%tmp%\%i%_%%~nd"
rmdir>nul 2>nul /S /Q "%~f1"
for /D %%d in ("%tmp%\%i%"_*) do call :Delete_Dir_Tree_Sub "%%~d" "%i%" "%tmp%"
rmdir>nul 2>nul /S /Q "%tmp%"
exit /B

:Delete_Dir
if "%~1"=="" exit /B 255
if not exist "%~1" exit /B 2
call :Delete_Dir_Tree "%~1"
if not exist "%~1" (
  call EchoSucc Delete directory "%~1"
  exit /B 0
)
call>nul 2>nul SetAccessMode "%~1" "Full"
call :Delete_Dir_Tree "%~1"
if not exist "%~1" (
  call EchoSucc Delete directory "%~1"
  exit /B 0
)
attrib.exe>nul 2>nul -R -S -H "%~1"
move>nul 2>nul "%~1" "%TEMP%\"
if not exist "%~1" (
  call EchoSucc Delete directory "%~1"
  exit /B 0
)
set DELETE_OBJECT_ERROR=YES
call EchoFail Delete directory "%~1"
if /I "%DEBUG%"=="YES" rmdir /S /Q "%~1"
exit /B 1

:Empty_Dir
if "%~1"=="" exit /B 255
if not exist "%~1" exit /B 2
call :Delete_Dir_Tree "%~1"
mkdir>nul 2>nul       "%~1" && (
  call EchoSucc Empty directory "%~1"
  exit /B 0
)
call EchoFail Empty directory "%~1"
if /I "%DEBUG%"=="YES" (
  rmdir /S /Q     "%~1"
  mkdir>nul 2>nul "%~1"
)
exit /B 1

:Make_Dir
if "%~1"=="" exit /B 255
mkdir>nul 2>nul "%~1" && (
  call EchoSucc Make directory "%~1"
  exit /B 0
)
if exist "%~1" (
  call EchoSucc Make directory "%~1"
  exit /B 0
)
call EchoFail Make directory "%~1"
if /I "%DEBUG%"=="YES" mkdir "%~1"
exit /B 1

:Check_Dir
if "%~1"=="" exit /B 255
if not exist "%~1" (
  call EchoFail Directory "%~1" is not exist
  exit /B 2
)
dir>nul 2>nul /A:D "%~1" && (
  call EchoSucc Directory "%~1" is exist
  if /I "%DEBUG%"=="YES" dir 2>&1 /A:D "%~1"|%SystemRoot%\System32\find.exe /I "Содержимое папки"
  exit /B 0
)
call EchoFail It is not directory: "%~1"
if /I "%DEBUG%"=="YES" dir 2>&1 /A:-D "%~1"|find /I "%~nx1"
exit /B 1

:Finish
