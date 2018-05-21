@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set desktop parameters
set USAGE=

call :Set_Desktop_Params
goto Finish


:Set_Desktop_Params
:: Отображать значок "Компьютер" на рабочем столе (для Windows XP)
reg.exe>nul 2>nul add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" /V "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /T REG_DWORD /D "0" /F || goto Set_Desktop_Params_Fail
:: Отобразить значок "Корзина" на рабочем столе (для Windows XP)
reg.exe>nul 2>nul add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" /V "{645FF040-5081-101B-9F08-00AA002F954E}" /T REG_DWORD /D "0" /F || goto Set_Desktop_Params_Fail
:: Отображать значок "Компьютер" на рабочем столе (для Windows 7)
reg.exe>nul 2>nul add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"    /V "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /T REG_DWORD /D "0" /F || goto Set_Desktop_Params_Fail
:: Отобразить значок "Корзина" на рабочем столе (для Windows 7)
reg.exe>nul 2>nul add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"    /V "{645FF040-5081-101B-9F08-00AA002F954E}" /T REG_DWORD /D "0" /F || goto Set_Desktop_Params_Fail
:: Отобразить значок "Корзина" на рабочем столе
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{645FF040-5081-101B-9F08-00AA002F954E}" /VE /T REG_SZ /D "Recycle Bin"           /F || goto Set_Desktop_Params_Fail
call EchoSucc Set desktop parameters
exit /B 0
:Set_Desktop_Params_Fail
call EchoFail Set desktop parameters
if /I "%DEBUG%"=="YES" (
  :: Отображать значок "Компьютер" на рабочем столе (для Windows XP)
  reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" /V "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /T REG_DWORD /D "0" /F
  :: Отобразить значок "Корзина" на рабочем столе (для Windows XP)
  reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" /V "{645FF040-5081-101B-9F08-00AA002F954E}" /T REG_DWORD /D "0" /F
  :: Отображать значок "Компьютер" на рабочем столе (для Windows 7)
  reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"    /V "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /T REG_DWORD /D "0" /F
  :: Отобразить значок "Корзина" на рабочем столе (для Windows 7)
  reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel"    /V "{645FF040-5081-101B-9F08-00AA002F954E}" /T REG_DWORD /D "0" /F
  :: Отобразить значок "Корзина" на рабочем столе
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{645FF040-5081-101B-9F08-00AA002F954E}" /VE /T REG_SZ /D "Recycle Bin"           /F
)
exit /B 1

:Finish
