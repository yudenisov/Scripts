@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable IE protected mode
set USAGE=disable/enable

call :IE_Protected_Mode "%~1"
goto Finish


:IE_Protected_Mode
setlocal
if /I "%~1"=="DISABLE" (
  set MODE="3"
  set MODE_NAME=Disable
  goto IE_Protected_Mode_Begin
)
if /I "%~1"=="ENABLE" (
  set MODE="0"
  set MODE_NAME=Enable 
  goto IE_Protected_Mode_Begin
)
exit /B 255
:IE_Protected_Mode_Begin
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /V "2500" /T REG_DWORD /D "%MODE%" /F || goto IE_Protected_Mode_Fail
)
call EchoSucc %MODE_NAME% IE protected mode
exit /B 0
:IE_Protected_Mode_Fail
call EchoFail %MODE_NAME% IE protected mode
if /I "%DEBUG%"=="YES" (
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3" /V "2500" /T REG_DWORD /D "%MODE%" /F
)
exit /B 1

:: http://wa7.ru/reestr-windows/ie/zash-regim-ie-8.html

:Finish
