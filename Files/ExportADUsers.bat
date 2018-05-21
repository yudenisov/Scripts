@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Export AD users to file [ADUsers.csv]
set USAGE=[file_name]

call :Export_ADUsers "%*"
goto Finish


:Export_ADUsers
setlocal
set FILE_NAME=ADUsers.csv
if not "%~1"=="" set FILE_NAME=%~1
csvde.exe>nul 2>nul -u -r "(objectClass=user)" -l displayName -f "%FILE_NAME%" && (
  call EchoSucc Export AD users to file "%FILE_NAME%"
  exit /B 0
)
call EchoFail Export AD users to file "%FILE_NAME%"
if /I "%DEBUG%"=="YES" csvde.exe -u -r "(objectClass=user)" -l displayName -f "%FILE_NAME%"
exit /B 1

:Finish
