@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable Windows XPx32 security updates
set USAGE=disable/enable

if /I "%~1"=="DISABLE" (
  call :Disable_WinXPx32SecurityUpdates
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_WinXPx32SecurityUpdates
  goto Finish
)
exit /B 255


:Disable_WinXPx32SecurityUpdates
reg.exe>nul 2>nul add "HKLM\SYSTEM\WPA\PosReady" /V "Installed" /T REG_DWORD /D "0" /F && (
  call EchoSucc Disable Windows XPx32 security updates
  exit /B 0
)
call EchoFail Disable Windows XPx32 security updates
if /I "%DEBUG%"=="YES" reg.exe add "HKLM\SYSTEM\WPA\PosReady" /V "Installed" /T REG_DWORD /D "0" /F
exit /B 1

:Enable_WinXPx32SecurityUpdates
reg.exe>nul 2>nul add "HKLM\SYSTEM\WPA\PosReady" /V "Installed" /T REG_DWORD /D "1" /F && (
  call EchoSucc Enable  Windows XPx32 security updates
  exit /B 0
)
call EchoFail Enable  Windows XPx32 security updates
if /I "%DEBUG%"=="YES" reg.exe add "HKLM\SYSTEM\WPA\PosReady" /V "Installed" /T REG_DWORD /D "1" /F
exit /B 1

:: http://www.xakep.ru/post/62554/default.asp

:Finish
