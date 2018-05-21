@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable mobility center
set USAGE=disable/enable

call :Mobility_Center "%~1"
goto Finish


:Mobility_Center
setlocal
if /I "%~1"=="DISABLE" (
  set MODE="0"
  set MODE_NAME=Disable
  goto Mobility_Center_Begin
)
if /I "%~1"=="ENABLE" (
  set MODE="1"
  set MODE_NAME=Enable 
  goto Mobility_Center_Begin
)
start mblctr.exe
exit /B 255
:Mobility_Center_Begin
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\MobilePC\MobilityCenter" /V "RunOnDesktop" /T REG_DWORD /D "%MODE%" /F || goto Mobility_Center_Fail
)
call EchoSucc %MODE_NAME% mobility center
exit /B 0
:Mobility_Center_Fail
call EchoFail %MODE_NAME% mobility center
if /I "%DEBUG%"=="YES" (
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
    reg.exe add "%%~i\Software\Microsoft\MobilePC\MobilityCenter" /V "RunOnDesktop" /T REG_DWORD /D "%MODE%" /F
  )
)
exit /B 1

:Finish
