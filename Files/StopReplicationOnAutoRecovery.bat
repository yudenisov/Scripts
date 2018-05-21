@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Stopping DFS-replication after automatic recovery on failure
set USAGE=disable/enable

if /I "%~1"=="DISABLE" (
  call :Disable_StopReplicationOnAutoRecovery
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_StopReplicationOnAutoRecovery
  goto Finish
)
exit /B 255


:Disable_StopReplicationOnAutoRecovery
:: Запрещаем остановку репликации после автоматического восстановления в результате сбоя
reg.exe>nul 2>nul add "HKLM\System\CurrentControlSet\Services\DFSR\Parameters" /V "StopReplicationOnAutoRecovery" /T REG_DWORD /D "0" /F && (
  call EchoSucc Disable stopping DFS-replication after automatic recovery on failure
  exit /B 0
)
call EchoFail Disable stopping DFS-replication after automatic recovery on failure
if /I "%DEBUG%"=="YES" reg.exe add "HKLM\System\CurrentControlSet\Services\DFSR\Parameters" /V "StopReplicationOnAutoRecovery" /T REG_DWORD /D "0" /F
exit /B 1

:Enable_StopReplicationOnAutoRecovery
:: Разрешаем остановку репликации после автоматического восстановления в результате сбоя
reg.exe>nul 2>nul add "HKLM\System\CurrentControlSet\Services\DFSR\Parameters" /V "StopReplicationOnAutoRecovery" /T REG_DWORD /D "1" /F && (
  call EchoSucc Enable stopping DFS-replication after automatic recovery on failure
  exit /B 0
)
call EchoFail Enable stopping DFS-replication after automatic recovery on failure
if /I "%DEBUG%"=="YES" reg.exe add "HKLM\System\CurrentControlSet\Services\DFSR\Parameters" /V "StopReplicationOnAutoRecovery" /T REG_DWORD /D "1" /F
exit /B 1

:Finish
