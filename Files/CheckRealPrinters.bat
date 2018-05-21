@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check real printers
set USAGE=

call :Check_Real_Printers
goto Finish


:Check_Real_Printers
set CHECK_REAL_PRINTERS=NO
call ShowPrinters "Real"|%SystemRoot%\System32\find.exe>nul 2>nul """" && (
  set CHECK_REAL_PRINTERS=YES
  call EchoSucc Real printers found
  exit /B 0
)
call EchoWarn Real printers not found
if /I "%DEBUG%"=="YES" wmic.exe PRINTER GET "Caption" /FORMAT:LIST
exit /B 1

:Finish
