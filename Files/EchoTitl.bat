@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Echo title
set USAGE=[message]

call :Echo_Titl %*
goto Finish


:Echo_Titl
if "%~1"=="" exit /B 255
echo.
hs_color.exe 2>nul 14 && echo %* || echo *** %* ***
hs_color.exe 2>nul  7
exit /B

:Finish
