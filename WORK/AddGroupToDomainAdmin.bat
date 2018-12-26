@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Add Local Administrator Group to Domain Administrator group
set USAGE=DOMAIN

call :AddGroupToDomainAdmin "%~1"
goto Finish


:AddGroupToDomainAdmin
if "%~1"=="" exit /B 255
net.exe 2>&1 localgroup Administrators /ADD "%~1\Domain Administrators"|findstr.exe>nul 2>nul /I "успешно уже" && goto Add_User_To_DCOMUsers_Succ
net.exe 2>&1 localgroup "Администраторы" /ADD "%~1\Администраторы домена"|findstr.exe>nul 2>nul /I "успешно уже" && goto Add_User_To_DCOMUsers_Succ
call EchoFail Add user "%~1" to group "Domain Administrators"
exit /B 1
:Add_User_To_DCOMUsers_Succ
call EchoSucc Add user "%~1" to group "Domain Administrators"
exit /B 0

:Finish
