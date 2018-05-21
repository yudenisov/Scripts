@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Display Message Box
set USAGE=[message]

call :Msg_Box %*
goto Finish

:Msg_Box
if "%~1"=="" exit /B 255
chcp    >nul 2>nul 1251
echo.>"%TEMP%\msgbox.jse"
echo>>"%TEMP%\msgbox.jse" var WSHShell=WScript.CreateObject("WScript.Shell");
echo>>"%TEMP%\msgbox.jse" WSHShell.Popup("%~1");
chcp    >nul 2>nul 866
start   >nul 2>nul %TEMP%\msgbox.jse
ping.exe>nul 2>nul 127.0.0.1 -n 3
del     >nul 2>nul /A /F /Q "%TEMP%\msgbox.jse"
exit /B

:Finish
