@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check wireless interfaces
set USAGE=
set CHECK_WIRELESS_INTERFACES=

call :Check_Wireless
goto Finish


:Check_Wireless
if /I "%CHECK_WIRELESS_INTERFACES%"=="YES" goto Succ
if /I "%CHECK_WIRELESS_INTERFACES%"=="NO"  goto Fail
ipconfig.exe 2>&1|%SystemRoot%\System32\find.exe>nul 2>nul /I "Беспроводное сетевое соединение" && goto Succ
ipconfig.exe 2>&1|%SystemRoot%\System32\find.exe>nul 2>nul /I "┴хёяЁютюфэюх ёхЄхтюх ёюхфшэхэшх" && goto Succ
ipconfig.exe 2>&1|%SystemRoot%\System32\find.exe>nul 2>nul /I "Адаптер беспроводной локальной сети" && goto Succ
ipconfig.exe 2>&1|%SystemRoot%\System32\find.exe>nul 2>nul /I "└фряЄхЁ схёяЁютюфэющ ыюъры№эющ ёхЄш" && goto Succ
:Fail
set CHECK_WIRELESS_INTERFACES=NO
call EchoWarn Wireless interfaces not found
if /I "%DEBUG%"=="YES" ipconfig.exe
exit /B 1
:Succ
set CHECK_WIRELESS_INTERFACES=YES
call EchoSucc Wireless interfaces found
exit /B 0

:Finish
