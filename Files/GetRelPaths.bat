@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  NetPath=\\192.168.0.100\resource
set RelPaths=Free License

setlocal EnableDelayedExpansion
del 2>nul /A /F /Q "%~n0.lst"
for %%i in (%RelPaths%) do for /F "tokens=*" %%j in ('dir /S /B /A:-D /O:N "%NetPath%\%%~i\install.bat"') do (
  set p=%%~j
  set p=!p:%NetPath%\=!
  set p=!p:\install.bat=!
  echo>>"%~n0.lst" !p!
)
