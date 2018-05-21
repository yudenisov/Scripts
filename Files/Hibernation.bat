@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable/check hibernation
set USAGE=disable/enable/check

if /I "%~1"=="DISABLE" (
  call :Disable_Hibernation
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_Hibernation
  goto Finish
)
if /I "%~1"=="CHECK" (
  call :Check_Hibernation
  goto Finish
)
exit /B 255


:Disable_Hibernation
powercfg.exe>nul 2>nul /H off
if not exist "%SYSTEMDRIVE%\hiberfil.sys" (
  call EchoSucc Disable hibernation
  exit /B 0
)
call EchoFail Disable hibernation
if /I "%DEBUG%"=="YES" powercfg.exe /H off
exit /B 1

:Enable_Hibernation
powercfg.exe>nul 2>nul /H on && if exist "%SYSTEMDRIVE%\hiberfil.sys" (
  call EchoSucc Enable  hibernation
  exit /B 0
)
call EchoFail Enable  hibernation
if /I "%DEBUG%"=="YES" powercfg.exe /H on
exit /B 1

:Check_Hibernation
if exist "%SYSTEMDRIVE%\hiberfil.sys" (
  call EchoWarn Hibernation is enabled
  exit /B 0
)
call EchoWarn Hibernation is disabled
exit /B 1

:Finish
