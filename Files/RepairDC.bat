@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Repair DC
set USAGE=

call CheckDC && (
  call :Repair_DC
  goto Finish
)
goto Finish

:Repair_DC
call EchoTitl Repair DC
dcdiag.exe>  C:\RepairDC.txt 2>&1 /FIX
echo.>>      C:\RepairDC.txt
echo>>       C:\RepairDC.txt --------------------------------------------------------------------------------
echo.>>      C:\RepairDC.txt
netdiag.exe>>C:\RepairDC.txt 2>&1 /FIX
call Svc Stop  Netlogon
call Svc Start Netlogon
call Svc Stop  DNS
call Svc Start DNS
call Svc Stop  DHCP
call Svc Start DHCP
call EchoTitl Quick Report (view details in "C:\RepairDC.txt")
setlocal EnableDelayedExpansion
for /F "tokens=*" %%s in (C:\RepairDC.txt) do (
  set str=%%~s
  set str=!str:.........................=!
  set str2=!str:- пройдена=!
  set str3=!str:- не пройдена=!
  if not "!str!"=="!str2!" call EchoSucc !str!
  if not "!str!"=="!str3!" call EchoFail !str!
)
exit /B

:Finish
