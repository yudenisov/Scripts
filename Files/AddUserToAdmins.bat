@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Add user to group Administrators
set USAGE=[host\]user

call :Add_User_To_Admins "%~1"
goto Finish


:Add_User_To_Admins
if "%~1"=="" exit /B 255
net.exe 2>&1 localgroup "Administrators" /ADD %~1|findstr.exe>nul 2>nul /I "успешно уже" && goto Add_User_To_Admins_Succ
net.exe 2>&1 localgroup "Администраторы" /ADD %~1|findstr.exe>nul 2>nul /I "успешно уже" && goto Add_User_To_Admins_Succ
call EchoFail Add user "%~1" to group "Administrators"
exit /B 1
:Add_User_To_Admins_Succ
call EchoSucc Add user "%~1" to group "Administrators"
exit /B 0

:Finish
