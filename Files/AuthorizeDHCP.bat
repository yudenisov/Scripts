@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Authorize this DHCP-server in AD
set USAGE=fqdn ip

call :Authorize_DHCP "%~1" "%~2"
goto Finish


:Authorize_DHCP
if "%~1"=="" exit /B 255
if "%~2"=="" exit /B 255
netsh.exe 2>&1 dhcp add server "%~1" "%~2"|findstr.exe>nul 2>nul /I "�ᯥ譮 㦥" && (
  call EchoSucc Authorize DHCP-server "%~1" with IP "%~2" in AD
  exit /B 0
)
call EchoFail Authorize DHCP-server "%~1" with IP "%~2" in AD
if /I "%DEBUG%"=="YES" netsh.exe dhcp add server "%~1" "%~2"
exit /B 1

:Finish
