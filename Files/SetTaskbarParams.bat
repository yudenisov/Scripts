@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set taskbar parameters
set USAGE=

call :Set_Taskbar_Params
goto Finish


:Set_Taskbar_Params
:: Восстанавливаем панель задач (для Windows XP)
mkdir  >nul 2>nul       "%APPDATA%\Microsoft\Internet Explorer\Quick Launch"
ren    >nul 2>nul       "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\Запустить обозреватель Internet Explorer.lnk" "Internet Explorer.lnk"
copy   >nul 2>nul /Y /Z "%ALLUSERSPROFILE%\Главное меню\Программы\Google Chrome.lnk" "%APPDATA%\Microsoft\Internet Explorer\Quick Launch\"
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
  :: Всегда отображать все значки и уведомления на панели задач
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer"          /V "EnableAutoTray"        /T REG_DWORD /D "0"      /F || goto Set_Taskbar_Params_Fail
  :: Отключить значок "Центр поддержи" из области уведомлений
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "HideSCAHealth"         /T REG_DWORD /D "1"      /F || goto Set_Taskbar_Params_Fail
  :: Отключить предварительный просмотр рабочего стола (для Windows 7)
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisablePreviewDesktop" /T REG_DWORD /D "1"      /F || goto Set_Taskbar_Params_Fail
  :: Отключить предварительный просмотр окон над панелью задач (для Windows 7)
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ExtendedUIHoverTime"   /T REG_DWORD /D "240000" /F || goto Set_Taskbar_Params_Fail
  :: Отключить все всплывающие уведомления в трее
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "EnableBalloonTips"     /T REG_DWORD /D "0"      /F || goto Set_Taskbar_Params_Fail
  :: Не группировать кнопки на панели задач (для Windows XP)
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarGlomming"       /T REG_DWORD /D "0"      /F || goto Set_Taskbar_Params_Fail
  :: Не группировать кнопки на панели задач (для Windows 7)
  rem reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarGlomLevel"  /T REG_DWORD /D "2"      /F || goto Set_Taskbar_Params_Fail
)
:: Не группировать кнопки на панели задач (для Windows 7)
reg.exe>nul 2>nul add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"   /V "TaskbarGlomLevel"      /T REG_DWORD /D "2"      /F || goto Set_Taskbar_Params_Fail
:: Отключить предупреждения системы антивирусной защиты
reg.exe>nul 2>nul add "HKLM\Software\Microsoft\Security Center" /V "AntiVirusDisableNotify" /T REG_DWORD /D "1" /F || goto Set_Taskbar_Params_Fail
:: Отключить предупреждения системы антивирусной защиты
reg.exe>nul 2>nul add "HKLM\Software\Microsoft\Security Center" /V "AntiVirusOverride"      /T REG_DWORD /D "1" /F || goto Set_Taskbar_Params_Fail
:: Отключить предупреждения брандмауэра
reg.exe>nul 2>nul add "HKLM\Software\Microsoft\Security Center" /V "FirewallDisableNotify"  /T REG_DWORD /D "1" /F || goto Set_Taskbar_Params_Fail
:: Отключить предупреждения брандмауэра
reg.exe>nul 2>nul add "HKLM\Software\Microsoft\Security Center" /V "FirewallOverride"       /T REG_DWORD /D "1" /F || goto Set_Taskbar_Params_Fail
:: Отключить сообщения центра безопасности
reg.exe>nul 2>nul add "HKLM\Software\Microsoft\Security Center" /V "FirstRunDisabled"       /T REG_DWORD /D "1" /F || goto Set_Taskbar_Params_Fail
:: Отключить предупреждения службы автоматического обновления
reg.exe>nul 2>nul add "HKLM\Software\Microsoft\Security Center" /V "UpdatesDisableNotify"   /T REG_DWORD /D "1" /F || goto Set_Taskbar_Params_Fail
call EchoSucc Set taskbar parameters
exit /B 0
:Set_Taskbar_Params_Fail
call EchoFail Set taskbar parameters
if /I "%DEBUG%"=="YES" (
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
    :: Всегда отображать все значки и уведомления на панели задач
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer"          /V "EnableAutoTray"        /T REG_DWORD /D "0"      /F
    :: Отключить значок "Центр поддержи" из области уведомлений
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "HideSCAHealth"         /T REG_DWORD /D "1"      /F
    :: Отключить предварительный просмотр рабочего стола (для Windows 7)
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisablePreviewDesktop" /T REG_DWORD /D "1"      /F
    :: Отключить предварительный просмотр окон над панелью задач (для Windows 7)
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "ExtendedUIHoverTime"   /T REG_DWORD /D "240000" /F
    :: Отключить все всплывающие уведомления в трее
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "EnableBalloonTips"     /T REG_DWORD /D "0"      /F
    :: Не группировать кнопки на панели задач (для Windows XP)
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarGlomming"       /T REG_DWORD /D "0"      /F
    :: Не группировать кнопки на панели задач (для Windows 7)
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "TaskbarGlomLevel"      /T REG_DWORD /D "2"      /F
  )
  :: Отключить предупреждения системы антивирусной защиты
  reg.exe add "HKLM\Software\Microsoft\Security Center" /V "AntiVirusDisableNotify" /T REG_DWORD /D "1" /F
  :: Отключить предупреждения системы антивирусной защиты
  reg.exe add "HKLM\Software\Microsoft\Security Center" /V "AntiVirusOverride"      /T REG_DWORD /D "1" /F
  :: Отключить предупреждения брандмауэра
  reg.exe add "HKLM\Software\Microsoft\Security Center" /V "FirewallDisableNotify"  /T REG_DWORD /D "1" /F
  :: Отключить предупреждения брандмауэра
  reg.exe add "HKLM\Software\Microsoft\Security Center" /V "FirewallOverride"       /T REG_DWORD /D "1" /F
  :: Отключить сообщения центра безопасности
  reg.exe add "HKLM\Software\Microsoft\Security Center" /V "FirstRunDisabled"       /T REG_DWORD /D "1" /F
  :: Отключить предупреждения службы автоматического обновления
  reg.exe add "HKLM\Software\Microsoft\Security Center" /V "UpdatesDisableNotify"   /T REG_DWORD /D "1" /F
)
exit /B 1

:Finish
