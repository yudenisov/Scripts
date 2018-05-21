@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Activate Windows and/or Office
set USAGE=win/off/all [kms_server]

call :Activate "%~1" "%~2"
goto Finish


:Activate
if /I "%~1"=="WIN" goto Activate_Begin
if /I "%~1"=="OFF" goto Activate_Begin
if /I "%~1"=="ALL" goto Activate_Begin
exit /B 255
:Activate_Begin
call SetTimeSyncParams
call SyncTime
if "%~2"=="" (
  call CheckKMSinDNS && call SetKMS %~1
) else (
  call SetKMS %~1 %~2
)
if /I "%~1"=="WIN" (
  call :Activate_Windows
  exit /B
)
if /I "%~1"=="OFF" (
  call :Activate_Office
  exit /B
)
if /I "%~1"=="ALL" (
  call :Activate_Windows
  call :Activate_Office
  exit /B
)

:Activate_Windows
call CheckOSType|%SystemRoot%\System32\find.exe>nul 2>nul /I "Windows XP" && (
  cscript.exe /NOLOGO %SYSTEMROOT%\SYSTEM32\actwinxp.vbs|%SystemRoot%\System32\find.exe>nul 2>nul /I "successful" && (
    call EchoSucc Activate Windows
    exit /B 0
  )
  call EchoFail Activate Windows
  if /I "%DEBUG%"=="YES" cscript.exe /NOLOGO %SYSTEMROOT%\SYSTEM32\actwinxp.vbs
  exit /B 1
)
cscript.exe 2>&1 /NOLOGO %SYSTEMROOT%\SYSTEM32\slmgr.vbs /ATO|%SystemRoot%\System32\find.exe>nul 2>nul /I "Активация выполнена успешно" && (
  call EchoSucc Activate Windows
  exit /B 0
)
call EchoFail Activate Windows
if /I "%DEBUG%"=="YES" cscript.exe /NOLOGO %SYSTEMROOT%\SYSTEM32\slmgr.vbs /ATO
exit /B 1

:Activate_Office
for /D %%i in ("%PROGRAMFILES: (x86)=%" "%PROGRAMFILES(x86)%" ) do if exist "%%~i" ^
for /D %%j in ("%%~i\Microsoft Office"                        ) do if exist "%%~j" ^
for /D %%k in ("%%~j\Office14" "%%~j\Office15" "%%~j\Office16") do if exist "%%~k\ospp.vbs" ^
set OSPP_VBS=%%~k\ospp.vbs
cscript.exe 2>&1 /NOLOGO "%OSPP_VBS%" /ACT|%SystemRoot%\System32\find.exe>nul 2>nul /I "Product activation successful" && (
  call EchoSucc Activate Office
  exit /B 0
)
call EchoFail Activate Office
if /I "%DEBUG%"=="YES" cscript.exe 2>&1 /NOLOGO "%OSPP_VBS%" /ACT
exit /B 1

:Finish
