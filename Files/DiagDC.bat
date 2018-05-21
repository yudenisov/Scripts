@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Diagnostics DC
set USAGE=

call CheckDC && (
  call :Diag_DC
  goto Finish
)
goto Finish


:Diag_DC
setlocal EnableDelayedExpansion
for /F "tokens=2" %%i in ('nslookup.exe 2^>nul _msdcs^|%SystemRoot%\System32\find.exe 2^>nul /I "_msdcs."') do set DNSDOMAIN=%%~i
set DNSDOMAIN=%DNSDOMAIN:_msdcs.=%
call EchoTitl Diagnostics DC
dcdiag.exe>   C:\DiagDC.txt 2>&1 /V
echo.>>       C:\DiagDC.txt
echo>>        C:\DiagDC.txt --------------------------------------------------------------------------------
echo.>>       C:\DiagDC.txt
dcdiag.exe>>  C:\DiagDC.txt 2>&1 /TEST:DNS /DNSALL /E /V
echo.>>       C:\DiagDC.txt
echo>>        C:\DiagDC.txt --------------------------------------------------------------------------------
echo.>>       C:\DiagDC.txt
dcdiag.exe>>  C:\DiagDC.txt 2>&1 /TEST:DCPROMO /DNSDOMAIN:%DNSDOMAIN% /REPLICADC /E /V
echo.>>       C:\DiagDC.txt
echo>>        C:\DiagDC.txt --------------------------------------------------------------------------------
echo.>>       C:\DiagDC.txt
dcdiag.exe>>  C:\DiagDC.txt 2>&1 /TEST:REGISTERINDNS /DNSDOMAIN:%DNSDOMAIN%
echo.>>       C:\DiagDC.txt
echo>>        C:\DiagDC.txt --------------------------------------------------------------------------------
echo.>>       C:\DiagDC.txt
netdiag.exe>> C:\DiagDC.txt 2>&1 /V
echo.>>       C:\DiagDC.txt
echo>>        C:\DiagDC.txt --------------------------------------------------------------------------------
echo.>>       C:\DiagDC.txt
netsh.exe>>   C:\DiagDC.txt 2>&1 dhcp show server
echo.>>       C:\DiagDC.txt
echo>>        C:\DiagDC.txt --------------------------------------------------------------------------------
echo.>>       C:\DiagDC.txt
repadmin.exe>>C:\DiagDC.txt 2>&1 /SHOWREPS
echo.>>       C:\DiagDC.txt
echo>>        C:\DiagDC.txt --------------------------------------------------------------------------------
echo.>>       C:\DiagDC.txt
repadmin.exe>>C:\DiagDC.txt 2>&1 /REPLSUM /ERRORSONLY
call EchoTitl Quick Report (view details in "C:\DiagDC.txt")
for /F "tokens=*" %%s in (C:\DiagDC.txt) do (
  set str=%%~s
  set str=!str:.........................=!
  set str2=!str:- пройдена=!
  set str3=!str:- не пройдена=!
  if not "!str!"=="!str2!" call EchoSucc !str!
  if not "!str!"=="!str3!" call EchoFail !str!
)
exit /B

:Finish
