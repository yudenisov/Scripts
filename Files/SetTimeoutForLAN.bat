@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set timeout for LAN connections
set USAGE=minuts

call :Set_Timeout_For_LAN "%~1"
goto Finish


:Set_Timeout_For_LAN
if "%~1"=="" exit /B 255
net.exe 2>&1 config server /Y /AUTODISCONNECT:%~1|%SystemRoot%\System32\find.exe>nul 2>nul /I "успешно" && (
  call EchoSucc Set timeout for LAN connections: "%~1" min
  exit /B 0
)
call EchoFail Set timeout for LAN connections: "%~1" min
if /I "%DEBUG%"=="YES" net.exe config server /Y /AUTODISCONNECT:%~1
exit /B 1

:: Задание времени до автоматического отключения соединения серверной службы:
:: net config server /autodisconnect:N
:: Где N - количество минут (макс. 65535), соответствующее интервалу ожидания,
:: по истечении которого будет прервано соединение с подключенным сетевым
:: диском. При N=0 серверная служба прерывает соединение с подключенными
:: сетевыми дисками после нескольких секунд бездействия. При N=-1
:: автоматическое отключение отменяется. По умолчанию N=15.

:Finish
