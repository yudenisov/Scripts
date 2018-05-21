@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete/check process [Show list]
set USAGE=[delete/check process_name]

if "%~1"=="" (
  call :Show_Processes_List
  goto Finish
)
if /I "%~1"=="DELETE" (
  call :Delete_Process "%~2"
  goto Finish
)
if /I "%~1"=="CHECK" (
  call :Check_Process "%~2"
  goto Finish
)
exit /B 255


:Show_Processes_List
for /F "delims=," %%i in ('tasklist.exe 2^>nul /NH /FO CSV') do for /F "tokens=*" %%j in (%%i) do (
  if /I not "%%j"=="tasklist.exe" if /I not "%%j"=="%SystemRoot%\System32\find.exe" echo %%j
)
exit /B

:Delete_Process
if "%~1"=="" exit /B 255
if /I "%DEBUG%"=="YES" (
  call           :Check_Process "%~1"
) else (
  call>nul 2>nul :Check_Process "%~1"
)
if errorlevel 2 goto :Delete_Process_Fail
if errorlevel 1 exit /B 2
taskkill.exe>nul 2>nul /F /T /IM "%~1" && (
  call EchoSucc Delete process "%~1"
  exit /B 0
)
taskkill.exe 2>&1 /F /T /IM "%~1"|%SystemRoot%\System32\find.exe>nul 2>nul /I "не удается найти процесс" && (
  call EchoSucc Delete process "%~1"
  exit /B 0
)
:Delete_Process_Fail
set DELETE_PROCESS_ERROR=YES
call EchoFail Delete process "%~1"
if /I "%DEBUG%"=="YES" taskkill.exe /F /T /IM "%~1"
exit /B 1

:Check_Process
if "%~1"=="" exit /B 255
tasklist.exe>nul 2>nul || exit /B 2
for /F "delims=," %%i in ('tasklist.exe 2^>nul /NH /FO CSV') do echo %%i|%SystemRoot%\System32\find.exe>nul 2>nul /I """%~1""" && goto Check_Process_Succ
call EchoWarn Process "%~1" is not exist
if /I "%DEBUG%"=="YES" (
  tasklist.exe 2>nul /NH /FO CSV|%SystemRoot%\System32\find.exe /I """%~1"""
)
exit /B 1
:Check_Process_Succ
call EchoSucc Process "%~1" is exist
exit /B 0

:Finish
