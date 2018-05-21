@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Enable NTP-server
set USAGE=

call :Enable_NTP_Server
goto Finish


:Enable_NTP_Server
:: w32tm.exe 2>&1 /config /update /reliable:YES|%SystemRoot%\System32\find.exe>nul 2>nul /I "выполнена успешно"
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer" /V "Enabled" /T REG_DWORD /D "1" /F && (
  call EchoSucc Enable  NTP-server
  exit /B 0
)
call EchoFail Enable  NTP-server
if /I "%DEBUG%"=="YES" reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer" /V "Enabled" /T REG_DWORD /D "1" /F
exit /B 1

:Finish
