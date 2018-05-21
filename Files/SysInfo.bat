@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=System info
set USAGE=

call :Sys_Info
goto Finish


:Sys_Info
call EchoSucc Host Name: "%COMPUTERNAME%"
call EchoSucc User Name: "%USERNAME%"
call CheckOSType
call CheckBootTime
call CheckAdminRights
call>nul CheckMasterDC && call EchoWarn It is master domain controller
call>nul CheckSlaveDC  && call EchoWarn It is slave domain controller
call CheckMemberOfDomain
call CheckIEVersion
call EchoSucc Windows Directory: "%SYSTEMROOT%"
call CheckDocsDir
call CheckPicsDir
call CheckRealPrinters
call CheckLANInterfaces
call CheckWirelessInterfaces
call CheckGateway
if not "%GATEWAY%"=="" call P %GATEWAY%
call CheckInet
exit /B

:Finish
