@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Import DHCP-server params from file [DHCP.dat]
set USAGE=[file_name]

call :Import_DHCP "%*"
goto Finish


:Import_DHCP
set IMPORT_FILE_NAME=%*
set IMPORT_FILE_NAME=%IMPORT_FILE_NAME:"=%
:Import_DHCP_Loop
if "%IMPORT_FILE_NAME:~-1%"==" " (
  set IMPORT_FILE_NAME=%IMPORT_FILE_NAME:~0,-1%
  goto Import_DHCP_Loop
)
if "%IMPORT_FILE_NAME%"=="" set IMPORT_FILE_NAME=DHCP.dat
if not exist "%IMPORT_FILE_NAME%" (
  call EchoFail Import DHCP-server params from file "%IMPORT_FILE_NAME%"
  if /I "%DEBUG%"=="YES" echo File "%IMPORT_FILE_NAME%" not exist
  exit /B 1
)
call DeleteDHCPAllScopes
netsh.exe 2>&1 >"%TEMP%\ImportDHCP.tmp" dhcp server import "%IMPORT_FILE_NAME%" all && (
  call EchoSucc Import DHCP-server params from file "%IMPORT_FILE_NAME%"
  del>nul 2>nul /A /F /Q "%TEMP%\ImportDHCP.tmp"
  exit /B 0
)
call EchoFail Import DHCP-server params from file "%IMPORT_FILE_NAME%"
if /I "%DEBUG%"=="YES" type 2>nul "%TEMP%\ImportDHCP.tmp"
del>nul 2>nul /A /F /Q "%TEMP%\ImportDHCP.tmp"
exit /B 1

:Finish
