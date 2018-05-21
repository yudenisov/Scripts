@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable/check feature [Show list]
set USAGE=[disable/enable/check feature_name]

if "%~1"=="" (
  call :Show_Features_List
  goto Finish
)
if /I "%~1"=="DISABLE" (
  call :Disable_Feature "%~2"
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_Feature "%~2"
  goto Finish
)
if /I "%~1"=="CHECK" (
  call :Check_Feature "%~2"
  goto Finish
)
exit /B 255


:Show_Features_List
:: oclist.exe
for /F "tokens=1-4" %%i in ('dism.exe 2^>nul /ONLINE /GET-FEATURES^|%SystemRoot%\System32\find.exe 2^>nul ":"') do (
  if "%%i"=="Имя" set TMP_FEATURE=%%l
  if "%%i"=="Состояние" (
    if "%%k"=="Отключен" call EchoFail [ ] %%TMP_FEATURE%%
    if "%%k"=="Включен"  call EchoSucc [x] %%TMP_FEATURE%%
  )
)
exit /B

:Disable_Feature
if "%~1"=="" exit /B 255
if /I "%~1"=="TelnetClient" if not exist "%SYSTEMROOT%\SYSTEM32\telnet.exe" (
  call EchoSucc Disable feature "TelnetClient"
  exit /B 0
)
dism.exe>nul 2>nul /ONLINE /QUIET /NORESTART /DISABLE-FEATURE:"%~1" && (
  call EchoSucc Disable feature "%~1"
  exit /B 0
)
ocsetup.exe>nul 2>nul "%~1" /QUIET /NORESTART /UNINSTALL && (
  call EchoSucc Disable feature "%~1"
  exit /B 0
)
call EchoFail Disable feature "%~1"
if /I "%DEBUG%"=="YES" (
  dism.exe /ONLINE /NORESTART /DISABLE-FEATURE:"%~1"
  ocsetup.exe "%~1" /NORESTART /UNINSTALL
)
exit /B 1

:Enable_Feature
if "%~1"=="" exit /B 255
if /I "%~1"=="TelnetClient" if exist "%SYSTEMROOT%\SYSTEM32\telnet.exe" (
  call EchoSucc Enable  feature "TelnetClient"
  exit /B 0
)
dism.exe>nul 2>nul /ONLINE /QUIET /NORESTART /ENABLE-FEATURE:"%~1" && (
  call EchoSucc Enable  feature "%~1"
  exit /B 0
)
ocsetup.exe>nul 2>nul "%~1" /QUIET /NORESTART && (
  call EchoSucc Enable  feature "%~1"
  exit /B 0
)
call EchoFail Enable  feature "%~1"
if /I "%DEBUG%"=="YES" (
  dism.exe /ONLINE /NORESTART /ENABLE-FEATURE:"%~1"
  ocsetup.exe "%~1" /NORESTART
)
exit /B 1

:Check_Feature
if "%~1"=="" exit /B 255
if /I "%~1"=="TelnetClient" if exist "%SYSTEMROOT%\SYSTEM32\telnet.exe" (
  call EchoWarn Feature "TelnetClient" is enabled
  exit /B 0
)
(dism.exe 2>&1 /ONLINE /GET-FEATUREINFO /FEATURENAME:"%~1")|%SystemRoot%\System32\find.exe>nul 2>nul /I "Состояние : Включен" && (
  call EchoWarn Feature "%~1" is enabled
  exit /B 0
)
(dism.exe 2>&1 /ONLINE /GET-FEATUREINFO /FEATURENAME:"%~1")|%SystemRoot%\System32\find.exe>nul 2>nul /I "Состояние : Отключен" && (
  call EchoWarn Feature "%~1" is disabled
  exit /B 1
)
call EchoFail Feature "%~1" is unknown
if /I "%DEBUG%"=="YES" (
  dism.exe /ONLINE /GET-FEATUREINFO /FEATURENAME:"%~1"
)
exit /B 2

:Finish
