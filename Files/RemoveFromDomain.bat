@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Remove from domain
set USAGE=[account]

call :Remove_From_Domain "%~1"
goto Finish


:Remove_From_Domain
set ACCOUNT=%~1
if "%ACCOUNT%"=="" set ACCOUNT=Администратор
call EchoTitl Remove from domain. Enter password for "%ACCOUNT%":
netdom.exe>nul 2>nul remove localhost /userd:%ACCOUNT% /passwordd:* && (
  call EchoSucc Remove from domain
  call Reboot
  exit 0
)
call EchoFail Remove from domain
if /I "%DEBUG%"=="YES" netdom.exe remove localhost /userd:%ACCOUNT% /passwordd:*
exit /B 1

:Finish
