@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Unwrap lines in MikroTik files [*.export *.rsc]
set USAGE=[file_names]

call :Unwrap_Lines_In_MikroTik_Export_Files %*
goto Finish


:Unwrap_Lines_In_MikroTik_Export_Files
setlocal
set FILES_OR_DIRS=%*
if "%~1"=="" set FILES_OR_DIRS=*.export *.rsc
call EchoTitl Unwrap lines in MikroTik export files
echo.
for %%i in (%FILES_OR_DIRS%) do %SystemRoot%\System32\find.exe>nul 2>nul " by RouterOS " "%%~i" && (
  call EchoSucc %%~i
  type "%%~i"|JoinLinesSplitWithBackslash "    ">"%TEMP%\%~n0.tmp"
  move>nul "%TEMP%\%~n0.tmp" "%%~i"
)
exit /B

:Finish
