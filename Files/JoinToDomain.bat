@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Join to domain
set USAGE=domain [account]

call :Join_Domain "%~1" "%~2"
goto Finish


:Join_Domain
if "%~1"=="" exit /B 255
set ACCOUNT=%~2
if "%ACCOUNT%"=="" set ACCOUNT=Администратор
call CheckMemberOfDomain && exit /B 0
call EchoTitl Join to domain "%~1". Enter password for "%ACCOUNT%":
netdom.exe>nul 2>nul join . /domain:%~1 /userd:%ACCOUNT% /passwordd:* && (
  call EchoSucc Join to domain "%~1"
  call Reboot
  exit 0
)
call EchoFail Join to domain
if /I "%DEBUG%"=="YES" netdom.exe join . /domain:%~1 /userd:%ACCOUNT% /passwordd:*
exit /B 1

:Finish
