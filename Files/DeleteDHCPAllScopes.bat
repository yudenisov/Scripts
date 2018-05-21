@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete on DHCP-server all scopes
set USAGE=

call :Delete_DHCP_All_Scopes
goto Finish


:Delete_DHCP_All_Scopes
for /F "tokens=1,2" %%i in ('netsh.exe 2^>nul dhcp server show scope') do if "%%j"=="-" call DeleteDHCPScope "%%i"
netsh.exe>nul 2>nul dhcp server delete optionvalue 006
netsh.exe>nul 2>nul dhcp server delete optionvalue 015
netsh.exe>nul 2>nul dhcp server delete optionvalue 042
netsh.exe>nul 2>nul dhcp server delete optionvalue 066
exit /B

:Finish
