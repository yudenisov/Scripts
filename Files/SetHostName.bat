@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set host name
set USAGE=host_name

call :Set_Hostname "%~1"
goto Finish


:Set_Hostname
if "%~1"=="" exit /B 255
if /I "%~1"=="%COMPUTERNAME%" (
  call EchoSucc Set host name to "%~1"
  exit /B 0
)
netdom.exe>nul 2>nul renamecomputer . /NEWNAME:%~1 /FORCE && (
  call EchoSucc Set host name to "%~1"
  call Reboot
  exit /B 0
)
call EchoFail Set host name to "%~1"
if /I "%DEBUG%"=="YES" netdom.exe renamecomputer . /NEWNAME:%~1 /FORCE
exit /B 1

:Finish
