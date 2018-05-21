@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set NumLock mode
set USAGE=off/on

call :Set_NumLock "%~1"
goto Finish


:Set_NumLock
if /I "%~1"=="OFF" (
  set MODE=0
  set MODE_NAME=Off
  goto Set_NumLock_Begin
)
if /I "%~1"=="ON" (
  set MODE=2
  set MODE_NAME=On
  goto Set_NumLock_Begin
)
exit /B 255
:Set_NumLock_Begin
reg.exe>nul 2>nul add "HKU\.DEFAULT\Control Panel\Keyboard" /V "InitialKeyboardIndicators" /T REG_SZ /D "%MODE%" /F  && (
  call EchoSucc Set NumLock mode to "%MODE_NAME%"
  exit /B 0
)
call EchoFail Set NumLock mode to "%MODE_NAME%"
if /I "%DEBUG%"=="YES" reg.exe add "HKU\.DEFAULT\Control Panel\Keyboard" /V "InitialKeyboardIndicators" /T REG_SZ /D "%MODE%" /F
exit /B 1

:Finish
