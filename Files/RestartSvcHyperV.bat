@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Restart Hyper-V service
set USAGE=

call :Restart_Svc_HyperV
goto Finish


:Restart_Svc_HyperV
net.exe>nul 2>nul stop  "winmgmt" /Y
net.exe>nul 2>nul start "winmgmt"
net.exe>nul 2>nul start "vmms"
net.exe>nul 2>nul start "vhdsvc"
net.exe 2>&1 start "nvspwmi"|findstr.exe>nul 2>nul /I "успешно не" && (
  call EchoSucc Restart Hyper-V service
  exit /B 0
)
call EchoFail Restart Hyper-V service
if /I "%DEBUG%"=="YES" net.exe start "nvspwmi"
exit /B 1

:Finish
