@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable remote access to the PnP interface
set USAGE=disable/enable

if /I "%~1"=="DISABLE" (
  call :Disable_Remote_Access_To_PnP
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_Remote_Access_To_PnP
  goto Finish
)
exit /B 255


:Disable_Remote_Access_To_PnP
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /V "AllowRemoteRPC" /T REG_DWORD /D "0" /F && (
  call EchoSucc Disable remote access to the PnP interface
  exit /B 0
)
call EchoFail Disable remote access to the PnP interface
if /I "%DEBUG%"=="YES" reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /V "AllowRemoteRPC" /T REG_DWORD /D "0" /F
exit /B 1

:Enable_Remote_Access_To_PnP
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /V "AllowRemoteRPC" /T REG_DWORD /D "1" /F && (
  call EchoSucc Enable  remote access to the PnP interface
  exit /B 0
)
call EchoFail Enable  remote access to the PnP interface
if /I "%DEBUG%"=="YES" reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings" /V "AllowRemoteRPC" /T REG_DWORD /D "1" /F
exit /B 1

:Finish
