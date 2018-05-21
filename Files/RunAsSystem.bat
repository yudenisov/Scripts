@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Run a command with SYSTEM rights
set USAGE=[command [parameters]]

call :Run_As_System %*
goto Finish


:Run_As_System
if "%~1"=="" (
  psx.exe /ACCEPTEULA /E /S "%COMSPEC%"
) else (
  psx.exe /ACCEPTEULA /E /S %*
)
exit /B

:Finish
