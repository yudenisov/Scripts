@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Enable debug mode
set USAGE=command [parameters]

if "%~1"=="" exit /B 255
setlocal
set DEBUG=YES
%*
