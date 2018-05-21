@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Cleaning print queue
set USAGE=

call :Cleaning_Print_Queue
goto Finish


:Cleaning_Print_Queue
net.exe>nul 2>nul stop "spooler" /Y
del>nul 2>nul /A /F /S /Q "%SYSTEMROOT%\SYSTEM32\SPOOL\PRINTERS\*.*"
net.exe start "spooler"|findstr.exe>nul 2>nul /I "�ᯥ譮 㦥" && goto Cleaning_Print_Queue_Succ
dir>nul 2>nul /A-D "%SYSTEMROOT%\SYSTEM32\SPOOL\PRINTERS"      || goto Cleaning_Print_Queue_Succ
call EchoFail Cleaning print queue
if /I "%DEBUG%"=="YES" (
  net.exe stop "spooler" /Y
  del /A /F /S /Q "%SYSTEMROOT%\SYSTEM32\SPOOL\PRINTERS\*.*"
  net.exe start "spooler"
)
exit /B 1
:Cleaning_Print_Queue_Succ
call EchoSucc Cleaning print queue
exit /B 0

:Finish
