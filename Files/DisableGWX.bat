@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable Get Windows 10
set USAGE=

call :Disable_GWX
goto Finish


:Disable_GWX
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GWX"                           /V "DisableGWX"           /T REG_DWORD /D 1 /F || goto Disable_GWX_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"                 /V "DisableOSUpgrade"     /T REG_DWORD /D 1 /F || goto Disable_GWX_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /V "AllowOSUpgrade"       /T REG_DWORD /D 0 /F || goto Disable_GWX_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /V "KickoffDownload"      /T REG_DWORD /D 0 /F || goto Disable_GWX_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /V "OSUpgradeInteractive" /T REG_DWORD /D 0 /F || goto Disable_GWX_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /V "ReservationsAllowed"  /T REG_DWORD /D 0 /F || goto Disable_GWX_Fail
call EchoSucc Disable Get Windows 10
exit /B 0
:Disable_GWX_Fail
call EchoFail Disable Get Windows 10
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GWX"                           /V "DisableGWX"           /T REG_DWORD /D 1 /F
  reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"                 /V "DisableOSUpgrade"     /T REG_DWORD /D 1 /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /V "AllowOSUpgrade"       /T REG_DWORD /D 0 /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /V "KickoffDownload"      /T REG_DWORD /D 0 /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /V "OSUpgradeInteractive" /T REG_DWORD /D 0 /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\OSUpgrade" /V "ReservationsAllowed"  /T REG_DWORD /D 0 /F
)
exit /B 1

:Finish

:: https://github.com/s3luX/windows-10-off
