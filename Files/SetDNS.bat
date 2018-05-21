@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set DNS on interface
set USAGE=interface_id [dns_server1 [dns_server2 [dns_server3]]]

call :Set_DNS "%~1" "%~2" "%~3" "%~4"
goto Finish


:Set_DNS
if "%~1"=="" exit /B 255
if "%~2"=="" (
  netsh.exe>nul 2>nul int ip set dns name="%~1" dhcp && (
    call EchoSucc Set on interface "%~1" auto mode
    call Wait 5
    exit /B 0
  )
  call EchoFail Set on interface "%~1" auto mode
  exit /B 1
)
netsh.exe>nul 2>nul int ip set  dns name="%~1" static address="%~2" register=primary
netsh.exe     2>&1  int ip show dns name="%~1"|findstr.exe>nul 2>nul /R "\<%~2\>" && (
  call EchoSucc Set on interface "%~1" primary   DNS: %~2
) || (
  call EchoFail Set on interface "%~1" primary   DNS: %~2
  exit /B 1
)
if "%~3"=="" exit /B 0
netsh.exe>nul 2>nul int ip add  dns name="%~1" address="%~3"
netsh.exe     2>&1  int ip show dns name="%~1"|findstr.exe 2>&1 /R /V "\<%~2\>"|findstr.exe>nul 2>nul /R "\<%~3\>" && (
  call EchoSucc Set on interface "%~1" secondary DNS: %~3
) || (
  call EchoFail Set on interface "%~1" secondary DNS: %~3
  exit /B 1
)
if "%~4"=="" exit /B 0
netsh.exe>nul 2>nul int ip add  dns name="%~1" address="%~4"
netsh.exe     2>&1  int ip show dns name="%~1"|findstr.exe 2>&1 /R /V "\<%~2\>"|findstr.exe>nul 2>nul /R "\<%~4\>" && (
  call EchoSucc Set on interface "%~1" third     DNS: %~4
) || (
  call EchoFail Set on interface "%~1" third     DNS: %~4
  exit /B 1
)
exit /B 0

:Finish
