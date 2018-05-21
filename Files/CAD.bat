@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable CTRL+ALT+DEL on logon
set USAGE=disable/enable

if /I "%~1"=="DISABLE" (
  call :Disable_CAD
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_CAD
  goto Finish
)
exit /B 255


:Disable_CAD
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "DisableCAD" /T REG_DWORD /D "1" /F && (
  call EchoSucc Disable CTRL+ALT+DEL on logon
  exit /B 0
)
call EchoFail Disable CTRL+ALT+DEL on logon
if /I "%DEBUG%"=="YES" reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "DisableCAD" /T REG_DWORD /D "1" /F
exit /B 1

:Enable_CAD
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "DisableCAD" /T REG_DWORD /D "0" /F && (
  call EchoSucc Enable  CTRL+ALT+DEL on logon
  exit /B 0
)
call EchoFail Enable  CTRL+ALT+DEL on logon
if /I "%DEBUG%"=="YES" reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "DisableCAD" /T REG_DWORD /D "0" /F
exit /B 1

:Finish
