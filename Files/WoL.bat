@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable/check Wake on LAN for interface
set USAGE=disable/enable/check interface_id

if /I "%~1"=="DISABLE" (
  call :Disable_WOL "%~2"
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_WOL "%~2"
  goto Finish
)
if /I "%~1"=="CHECK" (
  call :Check_WOL "%~2"
  goto Finish
)
exit /B 255


:Disable_WOL
if "%~1"=="" exit /B 255
netsh.exe>nul 2>nul int ip set int "%~1" forcearpndwolpattern=disabled && (
  call EchoSucc Disable WoL on interface "%~1"
  exit /B 0
)
call EchoFail Disable WoL on interface "%~1"
if /I "%DEBUG%"=="YES" netsh.exe int ip set int "%~1" forcearpndwolpattern=disabled
exit /B 1

:Enable_WOL
if "%~1"=="" exit /B 255
netsh.exe>nul 2>nul int ip set int "%~1" forcearpndwolpattern=enabled && (
  call EchoSucc Enable WoL on interface "%~1"
  exit /B 0
)
call EchoFail Enable WoL on interface "%~1"
if /I "%DEBUG%"=="YES" netsh.exe int ip set int "%~1" forcearpndwolpattern=enabled
exit /B 1

:Check_WOL
if "%~1"=="" exit /B 255
netsh.exe 2>nul int ip show int "%~1"|%SystemRoot%\System32\find.exe 2>nul /I "ARPND"|%SystemRoot%\System32\find.exe 2>nul /I "enabled" && (
  call EchoWarn WoL on interface "%~1" is enabled
  exit /B 0
)
call EchoWarn WoL on interface "%~1" is disabled
if /I "%DEBUG%"=="YES" netsh.exe int ip show int "%~1"|%SystemRoot%\System32\find.exe /I "ARPND"
exit /B 1

::    Чтобы включить пробуждение через сетевой адаптер с помощью протоколов ARP
:: и  NS,  введите  команду  netsh  interface  ipv4  set   interface   [индекс]
:: forcearpndwolpattern=enabled. В случае успешного  выполнения  команды  будет
:: возвращено значение OK.
:: http://technet.microsoft.com/ru-ru/library/ee617165%28v=ws.10%29.aspx

:Finish
