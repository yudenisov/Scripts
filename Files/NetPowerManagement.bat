@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable power management on all network interfaces
set USAGE=disable/enable

call :Net_Power_Management "%~1"
goto Finish


:Net_Power_Management
setlocal
if /I "%~1"=="DISABLE" (
::set MODE="0x118"
  set MODE="0x18"
  set MODE_NAME=Disable
  goto Net_Power_Management_Begin
)
if /I "%~1"=="ENABLE" (
::set MODE="0x100"
  set MODE="0x0"
  set MODE_NAME=Enable
  goto Net_Power_Management_Begin
)
exit /B 255
:: Снимаем/ставим галочку "Разрешить отключение этого устройства для
:: экономии энергии" на вкладке "Управление электропитанием" для всех
:: сетевых адаптеров.
:Net_Power_Management_Begin
for /F %%i in ('reg.exe 2^>nul query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}" /S /V "PnPCapabilities"^|%SystemRoot%\System32\find.exe /I "HKEY"') ^
do reg.exe>nul 2>nul add "%%i" /V "PnPCapabilities" /T REG_DWORD /D "%MODE%" /F || goto Net_Power_Management_Fail
call EchoSucc %MODE_NAME% power management on all network interfaces
exit /B 0
:Net_Power_Management_Fail
call EchoFail %MODE_NAME% power management on all network interfaces
if /I "%DEBUG%"=="YES" (
  for /F %%i in ('reg.exe 2^>nul query "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}" /S /V "PnPCapabilities"^|%SystemRoot%\System32\find.exe /I "HKEY"') ^
  do reg.exe add "%%i" /V "PnPCapabilities" /T REG_DWORD /D "%MODE%" /F
)
exit /B 1

:Finish
