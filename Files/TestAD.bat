@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Test Active Directory
set USAGE=[domain]

call :Test_AD "%~1"
goto Finish


:Test_AD
set LOGFILE=C:\TestAD.txt
setlocal EnableDelayedExpansion
if "%~1"=="" (
  for /F "tokens=1-3" %%i in ('netdom.exe 2^>nul /QUERY fsmo^|%SystemRoot%\System32\find.exe 2^>nul /I "Хозяин схемы"') do if not "%%k"=="" (
    set DNSDOMAIN=%%k
    set DNSDOMAIN=!DNSDOMAIN:*.=!
  )
  if "!DNSDOMAIN!"=="" (
    call EchoFail DNS Domain not detected. Set it manually!
    exit /B 1
  )
  call EchoSucc DNS Domain detected: !DNSDOMAIN!
) else (
  set DNSDOMAIN=%~1
  call EchoSucc DNS Domain: !DNSDOMAIN!
)
echo.
if not "%LOGFILE%"=="" del 2>nul /A /F /Q "%LOGFILE%"
dcdiag.exe  >>"%LOGFILE%" /V
dcdiag.exe  >>"%LOGFILE%" /E /V /TEST:DNS /DNSALL
dcdiag.exe  >>"%LOGFILE%" /E /V /TEST:DCPROMO /DNSDOMAIN:%DNSDOMAIN% /NEWFOREST
dcdiag.exe  >>"%LOGFILE%" /TEST:REGISTERINDNS /DNSDOMAIN:%DNSDOMAIN%
netsh.exe   >>"%LOGFILE%" DHCP SHOW SERVER
repadmin.exe>>"%LOGFILE%" /SHOWREPS
repadmin.exe>>"%LOGFILE%" /REPLSUM /ERRORSONLY
set /A FAILS=0
set /A PASSES=0
for /F "tokens=*" %%i in ('findstr.exe 2^>nul /I /N "fail ошибк" "%LOGFILE%"'             ) do if not "%%i"=="" (
  if /I "%DEBUG%"=="YES" call EchoFail %%i
  set /A FAILS=!FAILS!+1
)
for /F "tokens=*" %%i in ('findstr.exe 2^>nul /I /N "succ pass успех успешно" "%LOGFILE%"') do if not "%%i"=="" (
  if /I "%DEBUG%"=="YES" call EchoSucc %%i
  set /A PASSES=!PASSES!+1
)
if /I "%DEBUG%"=="YES" echo.
call EchoFail Fails : !FAILS!
call EchoSucc Passes: !PASSES!
echo.
call EchoWarn View log for details: %LOGFILE%
exit /B

:: http://it.toolbox.com/blogs/progress-bar/active-directory-health-check-tool-38496

:Finish
