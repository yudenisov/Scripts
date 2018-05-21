@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Install driver
set USAGE=inf-file

call :Install_Driver "%~1"
goto Finish


:Install_Driver
if "%~1"=="" exit /B 255
pnputil.exe>nul 2>nul /F /A "%~1" && (
  call EchoSucc Install Driver "%~nx1"
  exit /B 0
)
call EchoFail Install Driver: "%~nx1"
if /I "%DEBUG%"=="YES" pnputil.exe /F /A "%~1"
exit /B 1

:Finish
