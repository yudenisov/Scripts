@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Import the proxy settings from IE
set USAGE=

call :Import_Proxy_Settings_From_IE
goto Finish


:Import_Proxy_Settings_From_IE
netsh.exe>nul 2>nul winhttp import proxy ie && (
  call EchoSucc Import the proxy settings from IE
  exit /B 0
)
call EchoFail Import the proxy settings from IE
if /I "%DEBUG%"=="YES" netsh.exe winhttp import proxy ie
exit /B 1

:Finish

:: Импортирование настроек прокси из IE в API WinHttp.
:: Это API используется, например, при обновлениях MSE.
:: http://pcportal.org.ru/forum/47-304-7
