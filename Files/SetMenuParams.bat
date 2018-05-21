@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set menu parameters
set USAGE=

call :Set_Menu_Params
goto Finish


:Set_Menu_Params
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
  :: Раскрывать "Сетевые подключения" при использовании классического меню (для Windows XP)
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "CascadeNetworkConnections" /T REG_SZ    /D "yes" /F || goto Set_Menu_Params_Fail
  :: Не использовать сокращенное меню (для Windows XP)
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "IntelliMenus"              /T REG_DWORD /D "0"   /F || goto Set_Menu_Params_Fail
  :: Не показывать пункт "Помощь" в меню (не для классического меню)
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Start_ShowHelp"            /T REG_DWORD /D "0"   /F || goto Set_Menu_Params_Fail
  :: Включить классическое меню
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "WebView"                   /T REG_DWORD /D "1"   /F || goto Set_Menu_Params_Fail
  :: Разрешить запуск "Панели управления" и показывать соответствующий пункт в меню
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoControlPanel"            /T REG_DWORD /D "0"   /F || goto Set_Menu_Params_Fail
  :: Не показывать пункт "Справка и поддержка" в меню (для классического меню)
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoSMHelp"                  /T REG_DWORD /D "1"   /F || goto Set_Menu_Params_Fail
)
:: Разрешить запуск "Панели управления" и показывать соответствующий пункт в меню
reg.exe>nul 2>nul add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoControlPanel" /T REG_DWORD /D "0" /F || goto Set_Menu_Params_Fail
:: Не показывать пункт "Справка и поддержка" в меню (для классического меню)
reg.exe>nul 2>nul add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoSMHelp"       /T REG_DWORD /D "1" /F || goto Set_Menu_Params_Fail
call EchoSucc Set menu parameters
exit /B 0
:Set_Menu_Params_Fail
call EchoFail Set menu parameters
if /I "%DEBUG%"=="YES" (
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
    :: Раскрывать "Сетевые подключения" при использовании классического меню (для Windows XP)
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "CascadeNetworkConnections" /T REG_SZ    /D "yes" /F
    :: Не использовать сокращенное меню (для Windows XP)
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "IntelliMenus"              /T REG_DWORD /D "0"   /F
    :: Не показывать пункт "Помощь" в меню (не для классического меню)
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "Start_ShowHelp"            /T REG_DWORD /D "0"   /F
    :: Включить классическое меню
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "WebView"                   /T REG_DWORD /D "1"   /F
    :: Разрешить запуск "Панели управления" и показывать соответствующий пункт в меню
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoControlPanel"            /T REG_DWORD /D "0"   /F
    :: Не показывать пункт "Справка и поддержка" в меню (для классического меню)
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoSMHelp"                  /T REG_DWORD /D "1"   /F
  )
  :: Разрешить запуск "Панели управления" и показывать соответствующий пункт в меню
  reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoControlPanel" /T REG_DWORD /D "0" /F
  :: Не показывать пункт "Справка и поддержка" в меню (для классического меню)
  reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoSMHelp"       /T REG_DWORD /D "1" /F
)
exit /B 1

:Finish
