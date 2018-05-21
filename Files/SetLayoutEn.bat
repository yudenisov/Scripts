@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set english keyboard layout to default
set USAGE=

call :Set_Layout_En
goto Finish


:Set_Layout_En
reg.exe>nul 2>nul add "HKU\.DEFAULT\Keyboard Layout\Preload" /V "1" /T REG_SZ /D "00000409" /F || goto Set_Layout_En_Fail
reg.exe>nul 2>nul add "HKU\.DEFAULT\Keyboard Layout\Preload" /V "2" /T REG_SZ /D "00000419" /F || goto Set_Layout_En_Fail
reg.exe>nul 2>nul add "HKCU\Keyboard Layout\Preload"         /V "1" /T REG_SZ /D "00000409" /F || goto Set_Layout_En_Fail
reg.exe>nul 2>nul add "HKCU\Keyboard Layout\Preload"         /V "2" /T REG_SZ /D "00000419" /F || goto Set_Layout_En_Fail
call EchoSucc Set english keyboard layout to default
exit /B 0
:Set_Layout_En_Fail
call EchoFail Set english keyboard layout to default
exit /B 1

:Finish
