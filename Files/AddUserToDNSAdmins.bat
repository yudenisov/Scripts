@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Add user to group DNS administrators
set USAGE=[host\]user

call :Add_User_To_DNSAdmins "%~1"
goto Finish


:Add_User_To_DNSAdmins
if "%~1"=="" exit /B 255
net.exe 2>&1 localgroup "DnsAdmins" /ADD %~1|findstr.exe>nul 2>nul /I "�ᯥ譮 㦥" && goto Add_User_To_DNSAdmins_Succ
call EchoFail Add user "%~1" to group "DNS administrators"
exit /B 1
:Add_User_To_DNSAdmins_Succ
call EchoSucc Add user "%~1" to group "DNS administrators"
exit /B 0

:Finish
