@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check on child domain
set USAGE=

call :Check_Child_Domain
goto Finish


:Check_Child_Domain
if /I "%CHECK_CHILD_DOMAIN%"=="YES" goto Check_Child_Domain_Succ
if /I "%CHECK_CHILD_DOMAIN%"=="NO"  goto Check_Child_Domain_Fail
for /F "tokens=1-3" %%i in ('netdom.exe 2^>nul /QUERY fsmo^|%SystemRoot%\System32\find.exe 2^>nul /I "Хозяин схемы"') do set FSMO_SCHEMA_MASTER=%%~k
if "%FSMO_SCHEMA_MASTER%"=="" goto Check_Child_Domain_Fail
for /F "tokens=1-2" %%i in ('netdom.exe 2^>nul /QUERY fsmo^|%SystemRoot%\System32\find.exe 2^>nul /I "PDC"') do set FSMO_PDC_EMULATOR=%%~j
if "%FSMO_PDC_EMULATOR%"=="" goto Check_Child_Domain_Fail
if /I not "%FSMO_SCHEMA_MASTER:*.=%"=="%FSMO_PDC_EMULATOR:*.=%" goto Check_Child_Domain_Succ
:Check_Child_Domain_Fail
set CHECK_CHILD_DOMAIN=NO
call EchoWarn It is not child domain
if /I "%DEBUG%"=="YES" netdom.exe /QUERY fsmo|findstr.exe /I "доменов PDC"
exit /B 1
:Check_Child_Domain_Succ
set CHECK_CHILD_DOMAIN=YES
call EchoWarn It is child domain
if /I "%DEBUG%"=="YES" netdom.exe /QUERY fsmo|findstr.exe /I "доменов PDC"
exit /B 0

:Finish
