@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check on slave domain controller
set USAGE=

call :Check_Slave_DC
goto Finish


:Check_Slave_DC
if /I "%CHECK_SLAVE_DC%"=="YES"  goto Check_Slave_DC_Succ
if /I "%CHECK_SLAVE_DC%"=="NO"   goto Check_Slave_DC_Fail
if not exist "%SYSTEMROOT%\ADWS" goto Check_Slave_DC_Fail
dsquery.exe 2>&1 server -o rdn -hasfsmo pdc|findstr.exe>nul 2>nul /I /X "%COMPUTERNAME%" && goto Check_Slave_DC_Fail
:Check_Slave_DC_Succ
set CHECK_SLAVE_DC=YES
call EchoWarn It is slave domain controller
if /I "%DEBUG%"=="YES" dsquery.exe server -o rdn -hasfsmo pdc
exit /B 0
:Check_Slave_DC_Fail
set CHECK_SLAVE_DC=NO
call EchoWarn It is not slave domain controller
if /I "%DEBUG%"=="YES" dsquery.exe server -o rdn -hasfsmo pdc
exit /B 1

:Finish
