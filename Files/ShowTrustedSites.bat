@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Show trusted sites
set USAGE=

call :Show_Trusted_Sites "%~1"
goto Finish


:Show_Trusted_Sites
for /F "tokens=1" %%i in ('reg.exe 2^>nul query "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /S^|%SystemRoot%\System32\find.exe 2^>nul /I "REG_SZ"') do call EchoSucc "%%~i"
exit /B

:Finish
