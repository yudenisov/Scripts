@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Reboot computer
set USAGE=

call :Reboot
goto Finish


:Reboot
call>nul 2>nul CleanIFEO
shutdown.exe>nul 2>nul /F /R /T 15 && (
  call EchoSucc Reboot computer
  call EchoTitl Reboot. Press any key to cancel...
  call Wait
  shutdown.exe>nul 2>nul /A
  exit /B 0
)
call EchoFail Reboot computer
if /I "%DEBUG%"=="YES" shutdown.exe /F /R /T 15
exit /B 1

:Finish
