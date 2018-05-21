@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable or enable AutoLogon
set USAGE=disable/enable [[[domain] user] pass]

if /I "%~1"=="DISABLE" (
  call :Disable_AutoLogon
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_AutoLogon "%~2" "%~3" "%~4"
  goto Finish
)
exit /B 255


:Disable_AutoLogon
reg.exe>nul 2>nul add    "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "AutoAdminLogon" /T REG_SZ /D "0" /F || goto Disable_AutoLogon_Fail
reg.exe>nul 2>nul delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "AutoLogonCount"                  /F
reg.exe>nul 2>nul delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "DefaultDomainName"               /F
reg.exe>nul 2>nul delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "DefaultUserName"                 /F
reg.exe>nul 2>nul delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "DefaultPassword"                 /F
call EchoSucc Disable AutoLogon
exit /B 0
:Disable_AutoLogon_Fail
call EchoFail Disable Disable AutoLogon
if /I "%DEBUG%"=="YES" (
  reg.exe add    "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "AutoAdminLogon" /T REG_SZ /D "0" /F
  reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "AutoLogonCount"                  /F
  reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "DefaultDomainName"               /F
  reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "DefaultUserName"                 /F
  reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "DefaultPassword"                 /F
)
exit /B 1

:Enable_AutoLogon
setlocal
set DOMAIN=%USERDOMAIN%
set   USER=%USERNAME%
set   PASS=
:: Без параметров - интерактивный ввод
if "%~1"=="" (
  set /P DOMAIN="Domain: "
  set /P   USER="User: "
  set /P   PASS="Password: "
  if not defined DOMAIN set DOMAIN=%USERDOMAIN%
  if not defined USER   set   USER=%USERNAME%
  echo.
)
:: 1 параметр - это пароль
if not "%~1"=="" (
  set   PASS=%~1
)
:: 2 параметра - это пользователь, пароль
if not "%~2"=="" (
  set   USER=%~1
  set   PASS=%~2
)
:: 3 параметра - это домен, пользователь, пароль
if not "%~3"=="" (
  set DOMAIN=%~1
  set   USER=%~2
  set   PASS=%~3
)
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "AutoAdminLogon"    /T REG_SZ /D "1"        /F || goto Enable_AutoLogon_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "DefaultDomainName" /T REG_SZ /D "%DOMAIN%" /F || goto Enable_AutoLogon_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "DefaultUserName"   /T REG_SZ /D "%USER%"   /F || goto Enable_AutoLogon_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "DefaultPassword"   /T REG_SZ /D "%PASS%"   /F || goto Enable_AutoLogon_Fail
call EchoSucc Enable AutoLogon for user "%DOMAIN%\%USER%"
exit /B 0
:Enable_AutoLogon_Fail
call EchoFail Enable AutoLogon for user "%DOMAIN%\%USER%"
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "AutoAdminLogon"    /T REG_SZ /D "1"        /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "DefaultDomainName" /T REG_SZ /D "%DOMAIN%" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "DefaultUserName"   /T REG_SZ /D "%USER%"   /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "DefaultPassword"   /T REG_SZ /D "%PASS%"   /F
)
exit /B 1

:: http://w7q.ru/windows7/zagruzka-windows-7-bez-vvoda-parolya-pri-rabote-v-domene-i-ne-tolko/

:Finish
