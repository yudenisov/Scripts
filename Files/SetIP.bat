@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set IP, mask and gateway on interface
set USAGE=interface_id [ip mask [gateway [metric]]]

call :Set_IP "%~1" "%~2" "%~3" "%~4" "%~5"
goto Finish


:Set_IP
if "%~1"=="" exit /B 255
if "%~2"=="" (
  netsh.exe>nul 2>nul int ip set addr name="%~1" dhcp && (
    call EchoSucc Set on interface "%~1" DHCP mode
    call Wait 5
    exit /B 0
  )
  netsh.exe 2>&1 int ip set addr name="%~1" dhcp|%SystemRoot%\System32\find.exe>nul 2>nul /I "DHCP уже включено на этом интерфейсе" && (
    call EchoSucc Set on interface "%~1" DHCP mode
    call Wait 5
    exit /B 0
  )
  call EchoFail Set on interface "%~1" DHCP mode
  if /I "%DEBUG%"=="YES" netsh.exe int ip set addr name="%~1" dhcp
  exit /B 1
)
if "%~3"=="" (
  call EchoFail Set on interface "%~1" IP: %~2
  if /I "%DEBUG%"=="YES" netsh.exe int ip set addr name="%~1" static %~2
  exit /B 1
)
if "%~4"=="" (
  netsh.exe>nul 2>nul int ip set addr name="%~1" static %~2 %~3 && (
    call EchoSucc Set on interface "%~1" IP/Mask: %~2/%~3
    call Wait 5
    exit /B 0
  )
  call EchoFail Set on interface "%~1" IP/Mask: %~2/%~3
  if /I "%DEBUG%"=="YES" netsh.exe int ip set addr name="%~1" static %~2 %~3
  exit /B 1
)
if "%~5"=="" (
  netsh.exe>nul 2>nul int ip set addr name="%~1" static %~2 %~3 %~4 1 && (
    call EchoSucc Set on interface "%~1" IP/Mask/GW: %~2/%~3/%~4
    call Wait 5
    exit /B 0
  )
  call EchoFail Set on interface "%~1" IP/Mask/GW: %~2/%~3/%~4
  if /I "%DEBUG%"=="YES" netsh.exe int ip set addr name="%~1" static %~2 %~3 %~4 1
  exit /B 1
)
netsh.exe>nul 2>nul int ip set addr name="%~1" static %~2 %~3 %~4 %~5 && (
  call EchoSucc Set on interface "%~1" IP/Mask/GW/Metric: %~2/%~3/%~4/%~5
  call Wait 5
  exit /B 0
)
call EchoFail Set on interface "%~1" IP/Mask/GW/Metric: %~2/%~3/%~4/%~5
if /I "%DEBUG%"=="YES" netsh.exe int ip set addr name="%~1" static %~2 %~3 %~4 %~5
exit /B 1

:Finish
