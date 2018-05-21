@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Flush DNS cache
set USAGE=

call :DNS_Flush
goto Finish


:DNS_Flush
ipconfig.exe>nul 2>nul /FLUSHDNS && (
  call EchoSucc Flush DNS cache
  exit /B 0
)
call EchoFail Flush DNS cache
if /I "%DEBUG%"=="YES" ipconfig.exe /FLUSHDNS
exit /B 1

:Finish
