@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check IE version
set USAGE=

call :Check_IE_Version
goto Finish


:Check_IE_Version
set IE_VERSION=
for /F "tokens=3" %%i in ('reg.exe 2^>nul query "HKLM\Software\Microsoft\Internet Explorer" /V "version"^|%SystemRoot%\System32\find.exe 2^>nul /I "version"') do (
  set IE_VERSION=%%~i
  call EchoSucc IE Version: %%IE_VERSION%%
  exit /B 0
)
call EchoFail IE Version: unknown
if /I "%DEBUG%"=="YES" reg.exe query "HKLM\Software\Microsoft\Internet Explorer" /V "version"
exit /B 1

:Finish
