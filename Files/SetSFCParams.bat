@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable or enable SFC
set USAGE=disable/enable

if /I "%~1"=="DISABLE" (
  call :Disable_SFC
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_SFC
  goto Finish
)
exit /B 255


:Disable_SFC
reg.exe>nul 2>nul add "HLKM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "SFCQuota"   /T REG_DWORD /D "0" /F
reg.exe>nul 2>nul add "HLKM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "SFCScan"    /T REG_DWORD /D "2" /F
reg.exe>nul 2>nul add "HLKM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "SFCDisable" /T REG_DWORD /D "2" /F && (
  call EchoSucc Disable SFC
  exit /B 0
)
call EchoFail Disable SFC
if /I "%DEBUG%"=="YES" reg.exe add "HLKM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "SFCDisable" /T REG_DWORD /D "2" /F
exit /B 1

:Enable_SFC
reg.exe>nul 2>nul add "HLKM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "SFCQuota"   /T REG_DWORD /D "0xFFFFFFFF" /F
reg.exe>nul 2>nul add "HLKM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "SFCScan"    /T REG_DWORD /D "0" /F
reg.exe>nul 2>nul add "HLKM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "SFCDisable" /T REG_DWORD /D "0" /F && (
  call EchoSucc Enable  SFC
  exit /B 0
)
call EchoFail Enable  SFC
if /I "%DEBUG%"=="YES" reg.exe add "HLKM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "SFCDisable" /T REG_DWORD /D "0" /F
exit /B 1

:Finish

:: SFC - служба проверки системных файлов. Все системные файлы находятся в
:: папках %SYSTEMROOT% и %SYSTEMROOT%\System32. SFC автоматически
:: восстанавливает их из папки %SYSTEMROOT%\System32\dllcache, если они были
:: случайно удалены или повреждены.
::
:: KEY Name: HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon
::
:: Entry Name: SFCDisable
:: Data Type: REG_DWORD
:: Value: 0,1,2,3,4
::   0 - SFC включена (по умолчанию).
::   1 - SFC отключена, но спрашивает пользователя о включении при загрузке ОС.
::   2 - SFC отключена полностью и пользователи не могут снова включить её.
::   4 - SFC включена, но всплывающие окна блокируются.
::
:: Параметр SFCScan может быть полезен для выполнения сканирования файлов,
:: защищенных системой.
::
:: Entry Name: SFCScan
:: Data Type: REG_DWORD
:: Value: 0,1,2
::   0 - не проверять защищенные файлы при загрузке системы (по умолчанию).
::   1 - сканировать защищенные файлы при каждой загрузке.
::   2 - разово сканировать файлы, защищенные системой.
::
:: Параметр SFCQuota задает размер папки %SYSTEMROOT%\System32\dllcache. По
:: умолчанию её размер - 400 Мб (0xFFFFFFFF). Размер папки можно сократить до
:: нуля с помощью команды: sfc /cachesize=0.
::
:: Entry Name: SFCQuota
:: Data Type: REG_DWORD
:: Value: 0x00000000..0xFFFFFFFF
::
:: http://winitpro.ru/index.php/2010/07/28/windows-sfc-i-klyuchi-reestra/
:: http://citforum.ru/operating_systems/windows/optimXP/
