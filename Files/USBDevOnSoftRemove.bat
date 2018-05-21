@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable USB devices on soft remove
set USAGE=disable/enable

if /I "%~1"=="DISABLE" (
  call :Disable_USB_Dev_On_Soft_Remove
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_USB_Dev_On_Soft_Remove
  goto Finish
)
exit /B 255


:Disable_USB_Dev_On_Soft_Remove
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\services\usbhub\HubG" /V "DisableOnSoftRemove" /T REG_DWORD /D "1" /F && (
  call EchoSucc Disable USB devices on soft remove
  exit /B 0
)
call EchoFail Disable USB devices on soft remove
if /I "%DEBUG%"=="YES" reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\usbhub\HubG" /V "DisableOnSoftRemove" /T REG_DWORD /D "1" /F
exit /B 1

:Enable_USB_Dev_On_Soft_Remove
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\services\usbhub\HubG" /V "DisableOnSoftRemove" /T REG_DWORD /D "0" /F && (
  call EchoSucc Enable  USB devices on soft remove
  exit /B 0
)
call EchoFail Enable  USB devices on soft remove
if /I "%DEBUG%"=="YES" reg.exe add "HKLM\SYSTEM\CurrentControlSet\services\usbhub\HubG" /V "DisableOnSoftRemove" /T REG_DWORD /D "0" /F
exit /B 1

:Finish
