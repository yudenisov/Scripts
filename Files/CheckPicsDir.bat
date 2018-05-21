@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check pictures directory
set USAGE=

call :Check_Pics_Dir
goto Finish


:Check_Pics_Dir
call :Get_Pics_Dir
if defined PICS_DIR (
  call EchoSucc Pictures directory: "%%PICS_DIR%%"
  exit /B 0
)
call EchoWarn Pictures directory not found
if /I "%DEBUG%"=="YES" reg.exe query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "My Pictures"
exit /B 1

:Get_Pics_Dir
chcp>nul 2>nul 1251
for /F "tokens=1,2,3,*" %%i in ('reg.exe 2^>nul query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" /V "My Pictures"') do if /I "%%k"=="REG_SZ" if not "%%l"=="" set PICS_DIR=%%l
chcp>nul 2>nul 866
exit /B

:Finish
