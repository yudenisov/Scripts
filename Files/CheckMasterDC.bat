@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check on master domain controller
set USAGE=

call :Check_Master_DC
goto Finish


:Check_Master_DC
if /I "%CHECK_MASTER_DC%"=="YES" goto Check_Master_DC_Succ
if /I "%CHECK_MASTER_DC%"=="NO"  goto Check_Master_DC_Fail
if not exist "%SYSTEMROOT%\ADWS" goto Check_Master_DC_Fail
dsquery.exe 2>&1 server -o rdn -hasfsmo pdc|findstr.exe>nul 2>nul /I /X "%COMPUTERNAME%" && goto Check_Master_DC_Succ
:Check_Master_DC_Fail
set CHECK_MASTER_DC=NO
call EchoWarn It is not master domain controller
if /I "%DEBUG%"=="YES" dsquery.exe server -o rdn -hasfsmo pdc
exit /B 1
:Check_Master_DC_Succ
set CHECK_MASTER_DC=YES
call EchoWarn It is master domain controller
if /I "%DEBUG%"=="YES" dsquery.exe server -o rdn -hasfsmo pdc
exit /B 0

:Finish
