@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable RDP-connections to this host
set USAGE=disable/enable

if /I "%~1"=="DISABLE" (
  call :Disable_RDP
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_RDP
  goto Finish
)
exit /B 255


:Disable_RDP
cscript.exe 2>&1      %SYSTEMROOT%\SYSTEM32\scregedit.wsf /AR 1|findstr.exe>nul 2>nul /I "обновлен updated"                  && goto Disable_RDP_Succ
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "fDenyTSConnections" /T REG_DWORD /D "1" /F && goto Disable_RDP_Succ
call EchoFail Disable RDP
if /I "%DEBUG%"=="YES" (
  cscript.exe /NOLOGO %SYSTEMROOT%\SYSTEM32\scregedit.wsf /AR 1
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "fDenyTSConnections" /T REG_DWORD /D "1" /F
)
exit /B 1
:Disable_RDP_Succ
call EchoSucc Disable RDP
exit /B 0

:Enable_RDP
netsh.exe  >nul 2>nul firewall set service remoteadmin   enable
netsh.exe  >nul 2>nul firewall set service remotedesktop enable
netsh.exe  >nul 2>nul firewall add portopening TCP 3389 RDP
cscript.exe>nul 2>nul %SYSTEMROOT%\SYSTEM32\scregedit.wsf /CS 0
cscript.exe 2>&1      %SYSTEMROOT%\SYSTEM32\scregedit.wsf /AR 0|findstr.exe>nul 2>nul /I "обновлен updated"                  && goto Enable_RDP_Succ
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "fDenyTSConnections" /T REG_DWORD /D "0" /F && goto Enable_RDP_Succ
call EchoFail Enable  RDP
if /I "%DEBUG%"=="YES" (
  cscript.exe /NOLOGO %SYSTEMROOT%\SYSTEM32\scregedit.wsf /CS 0
  cscript.exe /NOLOGO %SYSTEMROOT%\SYSTEM32\scregedit.wsf /AR 0
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /V "fDenyTSConnections" /T REG_DWORD /D "0" /F
)
exit /B 1
:Enable_RDP_Succ
call EchoSucc Enable  RDP
exit /B 0

:Finish
