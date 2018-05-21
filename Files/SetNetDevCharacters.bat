@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Setting characteristics of network device
set USAGE=device_id characters_dword

call :SetNetDevCharacters "%~1" "%~2"
goto Finish

:SetNetDevCharacters
if "%~1"=="" exit /B 255
if "%~2"=="" exit /B 255
setlocal EnableDelayedExpansion
set key=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}
set add=
set err=
for /F "tokens=1,2,*" %%i in ('reg.exe query "%key%" /S') do (
  if "%%~j"=="" call :MatchStr "%%~i" "%key%\0" && (
      set subkey=%%~i
      if defined subkey set subkey=!subkey:%key%\=!
      if defined subkey set subkey=!subkey:~0,4!
  )
  if /I "%%~i"=="ComponentId" if /I "%%~k"=="%~1" (
    set add=1
    reg.exe>nul 2>nul add "!key!\!subkey!" /V "Characteristics" /T REG_DWORD /D "%~2" /F || set err=1
  )
)
if not defined add exit /B
if not defined err (
  call EchoSucc Setting characteristics of network device "%~1" in "%~2"
  exit /B 0
)
call EchoFail Setting characteristics of network device "%~1" in "%~2"
if /I "%DEBUG%"=="YES" reg.exe add "!key!\!subkey!" /V "Characteristics" /T REG_DWORD /D "%~2" /F
exit /B 1

:MatchStr
if "%~1"=="" exit /B 1
if "%~2"=="" exit /B 1
setlocal
set str="%~1"
set str=%str:&=^&%
set str=%str:"=%
call :MatchStr2 "%str%" "%%str:%~2=%%"
endlocal
exit /B
:MatchStr2
if "%~1"=="%~2" exit /B 1
exit /B 0

:Finish

:: Hide the TAP-Adapter in Network Connections:
::   call :SetNetDevCharacters "tap0901" "0x81"
::
:: Show the TAP-Adapter in Network Connections:
::   call :SetNetDevCharacters "tap0901" "0x89"
