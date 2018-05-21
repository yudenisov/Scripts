@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check boot time
set USAGE=

call :Check_Boot_Time
goto Finish

:Check_Boot_Time
set BOOT_DATE=
set BOOT_TIME=
for /F "tokens=1-4" %%i in ('net.exe 2^>nul statistics workstation^|%SystemRoot%\System32\find.exe 2^>nul ":"') do if not "%%l"=="" (
  set BOOT_DATE=%%k
  set BOOT_TIME=%%l
  call EchoSucc Boot Time: %%BOOT_DATE%% %%BOOT_TIME%%
  exit /B 0
)
call EchoFail Boot Time: unknown
if /I "%DEBUG%"=="YES" net.exe statistics workstation
exit /B 1

:Finish
