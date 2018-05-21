@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Show inactive users [rdn [24weeks]]
set USAGE=[dn/rdn/upn/samid [weeks]]

call :Show_Inactive_Users "%~1" "%~2"
goto Finish


:Show_Inactive_Users
setlocal
set OUTMODE=RDN
set   WEEKS=24
if not "%~1"=="" set OUTMODE=%~1
if not "%~2"=="" set   WEEKS=%~2
dsquery.exe 2>nul user /LIMIT 99999 /O %OUTMODE% /INACTIVE %WEEKS%
exit /B

:Finish
