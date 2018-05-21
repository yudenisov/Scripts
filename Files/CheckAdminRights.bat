@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check admin rights
set USAGE=

call :Check_Admin_Rights
goto Finish


:Check_Admin_Rights
net.exe>nul 2>nul session && goto Succ
::reg.exe 2>nul query "HKEY_USERS\S-1-5-19\Environment" /V "TEMP"|%SystemRoot%\System32\find.exe>nul 2>nul /I "REG_EXPAND_SZ" && goto Succ
set CHECK_ADMIN_RIGHTS=NO
call EchoFail.bat Admin rights is not present
if /I "%DEBUG%"=="YES" net.exe session
::if /I "%DEBUG%"=="YES" reg.exe query "HKEY_USERS\S-1-5-19\Environment" /V "TEMP"
exit /B 1
:Succ
set CHECK_ADMIN_RIGHTS=YES
call EchoSucc.bat Admin rights present
exit /B 0

:Finish
