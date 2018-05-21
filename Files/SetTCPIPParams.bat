@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set TCP/IP parameters
set USAGE=

call :Optimize_TCPIP
exit /B 255


:Optimize_TCPIP
reg.exe  >nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "MaxUserPort"       /T REG_DWORD /D "655354" /F || goto Optimize_TCPIP_Fail
reg.exe  >nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TcpTimedWaitDelay" /T REG_DWORD /D "30"     /F || goto Optimize_TCPIP_Fail
reg.exe  >nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TcpFinWait2Delay"  /T REG_DWORD /D "30"     /F || goto Optimize_TCPIP_Fail
netsh.exe>nul 2>nul int tcp set global autotuninglevel=disabled                                                                      || goto Optimize_TCPIP_Fail
call EchoSucc Set TCP/IP parameters
exit /B 0
:Optimize_TCPIP_Fail
call EchoFail Set TCP/IP parameters
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "MaxUserPort"       /T REG_DWORD /D "655354" /F
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TcpTimedWaitDelay" /T REG_DWORD /D "30"     /F
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TCPIP\Parameters" /V "TcpFinWait2Delay"  /T REG_DWORD /D "30"     /F
  netsh.exe int tcp set global autotuninglevel=disabled
)
exit /B 1

:Finish

:: http://it-consulting.koloshko.com/2014/10/windows-server-optimization.html
