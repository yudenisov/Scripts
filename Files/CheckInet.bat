@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check Internet connection
set USAGE=

call :Check_Internet
goto Finish


:Check_Internet
if /I "%CHECK_INTERNET%"=="YES" goto Check_Internet_Succ
if /I "%CHECK_INTERNET%"=="NO"  goto Check_Internet_Fail
ping.exe 2>&1 8.8.8.8 -n 5|%SystemRoot%\System32\find.exe>nul 2>nul /I "TTL=" && goto Check_Internet_Succ
:Check_Internet_Fail
set CHECK_INTERNET=NO
call EchoWarn Internet connection failed
if /I "%DEBUG%"=="YES" ping.exe 8.8.8.8 -n 5
exit /B 1
:Check_Internet_Succ
set CHECK_INTERNET=YES
call EchoSucc Internet connection established
exit /B 0

:Finish
