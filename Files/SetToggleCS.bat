@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set keyboard switch to CTRL+SHIFT
set USAGE=

call :Set_Toggle_CS
goto Finish


:Set_Toggle_CS
reg.exe>nul 2>nul add "HKU\.DEFAULT\Keyboard Layout\Toggle" /V "Hotkey"          /T REG_SZ /D "2" /F || goto Set_Toggle_CS_Fail
reg.exe>nul 2>nul add "HKU\.DEFAULT\Keyboard Layout\Toggle" /V "Language Hotkey" /T REG_SZ /D "2" /F || goto Set_Toggle_CS_Fail
reg.exe>nul 2>nul add "HKCU\Keyboard Layout\Toggle"         /V "Hotkey"          /T REG_SZ /D "2" /F || goto Set_Toggle_CS_Fail
reg.exe>nul 2>nul add "HKCU\Keyboard Layout\Toggle"         /V "Language Hotkey" /T REG_SZ /D "2" /F || goto Set_Toggle_CS_Fail
call EchoSucc Set keyboard switch to "CTRL+SHIFT"
exit /B 0
:Set_Toggle_CS_Fail
call EchoFail Set keyboard switch to "CTRL+SHIFT"
exit /B 1

:Finish
