@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Show run registry keys
set USAGE=

call :Show_Run_Reg_Keys
goto :EoF

:Show_Run_Reg_Keys
call EchoWarn [HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]
for /F "tokens=*" %%i in ('reg.exe 2^>nul query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"^|%SystemRoot%\System32\find.exe "REG_SZ"') do echo %%i
echo.
call EchoWarn [HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]
for /F "tokens=*" %%i in ('reg.exe 2^>nul query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"^|%SystemRoot%\System32\find.exe "REG_SZ"') do echo %%i
echo.
call EchoWarn [HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run]
for /F "tokens=*" %%i in ('reg.exe 2^>nul query "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Run"^|%SystemRoot%\System32\find.exe "REG_SZ"') do echo %%i
exit /B
