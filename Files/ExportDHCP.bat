@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Export DHCP-server params to file [DHCP.dat]
set USAGE=[file_name]

call :Export_DHCP "%*"
goto Finish


:Export_DHCP
setlocal
set EXPORT_FILE_NAME=%*
set EXPORT_FILE_NAME=%EXPORT_FILE_NAME:"=%
:Export_DHCP_Loop
if "%EXPORT_FILE_NAME:~-1%"==" " (
  set EXPORT_FILE_NAME=%EXPORT_FILE_NAME:~0,-1%
  goto Export_DHCP_Loop
)
if "%EXPORT_FILE_NAME%"=="" set EXPORT_FILE_NAME=DHCP.dat
netsh.exe 2>&1 >"%TEMP%\ExportDHCP.tmp" dhcp server export "%EXPORT_FILE_NAME%" all && (
  call EchoSucc Export DHCP-server params to file "%EXPORT_FILE_NAME%"
  del>nul 2>nul /A /F /Q "%TEMP%\ExportDHCP.tmp"
  call Wait 15
  exit /B 0
)
call EchoFail Export DHCP-server params to file "%EXPORT_FILE_NAME%"
if /I "%DEBUG%"=="YES" type 2>nul "%TEMP%\ExportDHCP.tmp"
del>nul 2>nul /A /F /Q "%TEMP%\ExportDHCP.tmp"
call Wait 15
exit /B 1

::     Если хотите всего-лишь дублицировать информацию с 1го сервера  на  другой,
:: на случай выхода из строя первого, или еще чего подобного, то не  останавливая
:: DHCP прекрасно работает такая штука:
::
::     netsh dhcp server export "\\х.х.х.х\d$\dhcp\dhcp.txt" all
::
::     Где х.х.х.х - адрес вторго дхцп.  В  случае  выхода  из  строя  первого  -
:: достаточно загрузить данный бецкап на втором, и все. Батник с такой строчкой в
:: шедуллер на выполнение раз в н-минут. А на втором сервере -  дхцп  поднят,  но
:: скопы не настроены. Т.е. служба запущена и все. В  ад  сервер  авторизован.  В
:: случае необходится при восстановлении с бекапа - все скопы  и  настройки  сами
:: восстанавливаются.

:Finish
