@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Show users profiles
set USAGE=

call :Show_Users_Profiles
goto Finish


:Show_Users_Profiles
setlocal
cd>nul 2>nul /D "%SYSTEMDRIVE%\Users" || ^
cd>nul 2>nul /D "%SYSTEMDRIVE%\Documents and Settings" || exit /B 1
for /D %%i in ("*.*") do echo %%i
exit /B

:Finish
