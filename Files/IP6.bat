@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable IPv6 on all network interfaces
set USAGE=disable/enable

if /I "%~1"=="DISABLE" (
  call :Disable_IP6
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_IP6
  goto Finish
)
exit /B 255


:Disable_IP6
reg.exe  >nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DisabledComponents" /T REG_DWORD /D "0xFFFFFFFF" /F || goto Disable_IP6_Fail
netsh.exe>nul 2>nul int ipv6 isatap set state disabled                                                                                     || goto Disable_IP6_Fail
netsh.exe>nul 2>nul int ipv6 set teredo disabled                                                                                           || goto Disable_IP6_Fail
netsh.exe>nul 2>nul int teredo set state disabled                                                                                          || goto Disable_IP6_Fail
::netsh.exe>nul 2>nul int tcp  set global autotuninglevel=disabled                                                                         || goto Disable_IP6_Fail
::netsh.exe>nul 2>nul int 6to4 set state disabled disabled                                                                                 || goto Disable_IP6_Fail
call EchoSucc Disable IPv6 on all network interfaces
exit /B 0
:Disable_IP6_Fail
call EchoFail Disable IPv6 on all network interfaces
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DisabledComponents" /T REG_DWORD /D "0xFF" /F
  netsh.exe int ipv6 isatap set state disabled
  netsh.exe int ipv6 set teredo disabled
  netsh.exe int teredo set state disabled
::netsh.exe int tcp  set global autotuninglevel=disabled
::netsh.exe int 6to4 set state disabled disabled
)
exit /B 1

:Enable_IP6
call :Delete_Reg_Key_Val "HKLM\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" "DisabledComponents" || goto Enable_IP6_Fail
netsh.exe>nul 2>nul int ipv6 isatap set state default                                                    || goto Enable_IP6_Fail
netsh.exe>nul 2>nul int ipv6 set teredo default                                                          || goto Enable_IP6_Fail
netsh.exe>nul 2>nul int teredo set state default                                                         || goto Enable_IP6_Fail
::netsh.exe>nul 2>nul int tcp  set global autotuninglevel=disabled                                       || goto Enable_IP6_Fail
::netsh.exe>nul 2>nul int 6to4 set state default default                                                 || goto Enable_IP6_Fail
call EchoSucc Enable  IPv6 on all network interfaces
exit /B 0
:Enable_IP6_Fail
call EchoFail Enable  IPv6 on all network interfaces
if /I "%DEBUG%"=="YES" (
  reg.exe delete "HKLM\SYSTEM\CurrentControlSet\Services\TCPIP6\Parameters" /V "DisabledComponents" /F
  netsh.exe int ipv6 isatap set state default
  netsh.exe int ipv6 set teredo default
  netsh.exe int teredo set state default
::netsh.exe int tcp  set global autotuninglevel=disabled
::netsh.exe int 6to4 set state default default                                                       || goto Disable_IP6_Fail
)
exit /B 1

:Delete_Reg_Key_Val
if "%~1"=="" exit /B 255
if "%~2"=="" exit /B 255
reg.exe>nul 2>nul delete "%~1" /V "%~2" /F && exit /B 0
reg.exe 2>&1      delete "%~1" /V "%~2" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "найти указанный раздел или параметр" && exit /B 0
reg.exe 2>&1      delete "%~1" /V "%~2" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "эрщЄш єърчрээ√щ Ёрчфхы шыш ярЁрьхЄЁ" && exit /B 0
exit /B 1

:Finish
