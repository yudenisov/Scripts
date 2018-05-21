@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable firewall
set USAGE=disable/enable

if /I "%~1"=="DISABLE" (
  call :Disable_Firewall
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_Firewall
  goto Finish
)
exit /B 255


:Update_Firewall
:: Для службы управления ключами
netsh.exe 2>&1 advfirewall firewall set rule name="Служба управления ключами (входящий трафик TCP)"       new enable=yes|%SystemRoot%\System32\find.exe>nul 2>nul "ОК." || goto Update_Firewall_Fail
netsh.exe 2>&1 advfirewall firewall set rule name="Удаленное управление брандмауэром Windows (RPC)"       new enable=yes|%SystemRoot%\System32\find.exe>nul 2>nul "ОК." || goto Update_Firewall_Fail
netsh.exe 2>&1 advfirewall firewall set rule name="Удаленное управление брандмауэром Windows (RPC-EPMAP)" new enable=yes|%SystemRoot%\System32\find.exe>nul 2>nul "ОК." || goto Update_Firewall_Fail
if /I "%DEBUG%"=="YES" call EchoSucc Update  firewall
exit /B 0
:Update_Firewall_Fail
if /I "%DEBUG%"=="YES" (
  call EchoFail Update  firewall
  netsh.exe advfirewall firewall set rule name="Служба управления ключами (входящий трафик TCP)"       new enable=yes
  netsh.exe advfirewall firewall set rule name="Удаленное управление брандмауэром Windows (RPC)"       new enable=yes
  netsh.exe advfirewall firewall set rule name="Удаленное управление брандмауэром Windows (RPC-EPMAP)" new enable=yes
)
exit /B 1

:Disable_Firewall
call :Update_Firewall
netsh.exe 2>&1 advfirewall set allprofiles state off|%SystemRoot%\System32\find.exe>nul 2>nul    "ОК."                       && goto Disable_Firewall_Succ
netsh.exe 2>&1    firewall set opmode disable       |%SystemRoot%\System32\find.exe>nul 2>nul    "ОК."                       && goto Disable_Firewall_Succ
netsh.exe 2>&1    firewall set opmode disable       |%SystemRoot%\System32\find.exe>nul 2>nul /I "Команда успешно выполнена" && goto Disable_Firewall_Succ
netsh.exe 2>&1    firewall set opmode disable       |%SystemRoot%\System32\find.exe>nul 2>nul /I "Служба не запущена"        && goto Disable_Firewall_Succ
:Disable_Firewall_Fail
call EchoFail Disable firewall
if /I "%DEBUG%"=="YES" netsh.exe advfirewall set allprofiles state off || netsh.exe firewall set opmode disable
exit /B 1
:Disable_Firewall_Succ
call EchoSucc Disable firewall
exit /B 0

:Enable_Firewall
call :Update_Firewall
netsh.exe 2>&1 advfirewall set allprofiles state on|%SystemRoot%\System32\find.exe>nul 2>nul    "ОК."                       || goto Enable_Firewall_Fail
netsh.exe 2>&1    firewall set opmode enable       |%SystemRoot%\System32\find.exe>nul 2>nul    "ОК."                       || goto Enable_Firewall_Fail
netsh.exe 2>&1    firewall set opmode enable       |%SystemRoot%\System32\find.exe>nul 2>nul /I "Команда успешно выполнена" || goto Enable_Firewall_Fail
netsh.exe 2>&1    firewall set opmode enable       |%SystemRoot%\System32\find.exe>nul 2>nul /I "Служба не запущена"        && goto Enable_Firewall_Fail
:Enable_Firewall_Succ
call EchoSucc Enable  firewall
exit /B 0
:Enable_Firewall_Fail
call EchoFail Enable  firewall
if /I "%DEBUG%"=="YES" netsh.exe advfirewall set allprofiles state on || netsh.exe firewall set opmode enable
exit /B 1

:Finish
