@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check on domain controller
set USAGE=

call :Check_DC
goto Finish


:Check_DC
if exist "%SYSTEMROOT%\ADWS" (
  call EchoWarn It is domain controller
  if /I "%DEBUG%"=="YES" dir "%SYSTEMROOT%\ADWS"|%SystemRoot%\System32\find.exe /I "\ADWS"
  exit /B 0
)
call EchoWarn It is not domain controller
if /I "%DEBUG%"=="YES" dir "%SYSTEMROOT%\ADWS"|%SystemRoot%\System32\find.exe /I "\ADWS"
exit /B 1

:Finish
