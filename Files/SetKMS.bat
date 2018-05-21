@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set KMS-server for Windows and/or Office
set USAGE=win/off/all [kms_server]

call :Set_KMS "%~1" "%~2"
goto Finish


:Set_KMS
for /D %%i in ("%PROGRAMFILES: (x86)=%" "%PROGRAMFILES(x86)%" ) do if exist "%%~i" ^
for /D %%j in ("%%~i\Microsoft Office"                        ) do if exist "%%~j" ^
for /D %%k in ("%%~j\Office14" "%%~j\Office15" "%%~j\Office16") do if exist "%%~k\ospp.vbs" ^
set OSPP_VBS=%%~k\ospp.vbs
if /I "%~1"=="WIN" (
  call :Set_KMS_Windows %~2
  exit /B
)
if /I "%~1"=="OFF" (
  call :Set_KMS_Office  %~2
  exit /B
)
if /I "%~1"=="ALL" (
  call :Set_KMS_Windows %~2
  call :Set_KMS_Office  %~2
  exit /B
)
exit /B 255

:Set_KMS_Windows
if "%~1"=="" goto Clear_KMS_Windows
cscript.exe 2>&1 %SYSTEMROOT%\SYSTEM32\slmgr.vbs /SKMS %~1|%SystemRoot%\System32\find.exe>nul 2>nul /I "Задано имя компьютера со службой управления ключами" && (
  call EchoSucc Set KMS-server for Windows: %~1
  exit /B 0
)
call EchoFail Set KMS-server for Windows: %~1
if /I "%DEBUG%"=="YES" cscript.exe /NOLOGO %SYSTEMROOT%\SYSTEM32\slmgr.vbs /SKMS %~1
exit /B 1

:Clear_KMS_Windows
cscript.exe 2>&1 %SYSTEMROOT%\SYSTEM32\slmgr.vbs /CKMS|%SystemRoot%\System32\find.exe>nul 2>nul /I "успешно удалено" && (
  call EchoSucc Clear KMS-server for Windows
  exit /B 0
)
call EchoFail Clear KMS-server for Windows
if /I "%DEBUG%"=="YES" cscript.exe /NOLOGO %SYSTEMROOT%\SYSTEM32\slmgr.vbs /CKMS
exit /B 1

:Set_KMS_Office
if "%~1"=="" goto Clear_KMS_Office
cscript.exe 2>&1 "%OSPP_VBS%" /SETHST:%~1|%SystemRoot%\System32\find.exe>nul 2>nul /I "Successfully applied setting" && (
  call EchoSucc Set KMS-server for Office: %~1
  exit /B 0
)
call EchoFail Set KMS-server for Office: %~1
if /I "%DEBUG%"=="YES" cscript.exe 2>&1 /NOLOGO "%OSPP_VBS%" /SETHST:%~1
exit /B 1

:Clear_KMS_Office
cscript.exe 2>&1 "%OSPP_VBS%" /REMHST|%SystemRoot%\System32\find.exe>nul 2>nul /I "Successfully applied setting" && (
  call EchoSucc Clear KMS-server for Office
  exit /B 0
)
call EchoFail Clear KMS-server for Office
if /I "%DEBUG%"=="YES" cscript.exe 2>&1 /NOLOGO "%OSPP_VBS%" /REMHST
exit /B 1

:Finish
