@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Hibernate computer
set USAGE=

call :Hibernate
goto Finish


:Hibernate
call>nul Hibernation Check && (
  call EchoSucc Hibernate computer
  call Wait 5
  shutdown.exe>nul 2>nul /F /H
  exit /B 0
)
call EchoFail Hibernate computer
if /I "%DEBUG%"=="YES" shutdown.exe /F /H
exit /B 1

:Finish
