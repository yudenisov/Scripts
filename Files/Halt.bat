@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Shutdown computer
set USAGE=

call :Halt
goto Finish


:Halt
call>nul 2>nul CleanIFEO
shutdown.exe>nul 2>nul /F /S /T 15 && (
  call EchoSucc Shutdown computer
  call EchoTitl Shutdown. Press any key to cancel...
  call Wait
  shutdown.exe>nul 2>nul /A
  exit /B 0
)
call EchoFail Shutdown computer
if /I "%DEBUG%"=="YES" shutdown.exe /F /S /T 15
exit /B 1

:Finish
