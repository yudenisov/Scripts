@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check documents directory
set USAGE=

call :Check_Docs_Dir
goto Finish


:Check_Docs_Dir
call :Get_Docs_Dir
if defined DOCS_DIR (
  call EchoSucc Documents directory: "%DOCS_DIR%"
  exit /B 0
)
call EchoWarn Documents directory not found
if /I "%DEBUG%"=="YES" reg.exe query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "Personal"
exit /B 1

:Get_Docs_Dir
chcp>nul 2>nul 1251
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "Personal"') do if /I "%%j"=="REG_SZ" if not "%%k"=="" set DOCS_DIR=%%k
chcp>nul 2>nul 866
exit /B

:Finish
