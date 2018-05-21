@echo off

set  HELP=Delete/add task mount exchange databases
set USAGE=delete/add

if /I "%~1"=="DELETE" (
  call :Delete_Task_Mount_Exchange_Databases
  goto Finish
)
if /I "%~1"=="ADD" (
  call :Add_Task_Mount_Exchange_Databases
  goto Finish
)
exit /B 255


:Delete_Task_Mount_Exchange_Databases
call Task Delete "MountExchangeDatabases"
exit /B

:Add_Task_Mount_Exchange_Databases
setlocal
set COMMAND=powershell.exe """. RemoteExchange; Connect-ExchangeServer -auto; Get-MailboxDatabase^|Mount-Database -force"""
schtasks.exe 2>&1 /CREATE /TN "MountExchangeDatabases" /SC "ONSTART" /TR "%COMMAND%" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "успешно создана" && goto Add_Task_Mount_Exchange_Databases_Succ
schtasks.exe 2>&1 /CREATE /TN "MountExchangeDatabases" /SC "ONSTART" /TR "%COMMAND%"   |%SystemRoot%\System32\find.exe>nul 2>nul /I "успешно создана" && goto Add_Task_Mount_Exchange_Databases_Succ
call EchoFail Add task "MountExchangeDatabases", run mode: "onstart"
if /I "%DEBUG%"=="YES" schtasks.exe /CREATE /TN "MountExchangeDatabases" /SC "ONSTART" /TR "%COMMAND%"
exit /B 1
:Add_Task_Mount_Exchange_Databases_Succ
call EchoSucc Add task "MountExchangeDatabases", run mode: "onstart"
exit /B 0

:Finish
