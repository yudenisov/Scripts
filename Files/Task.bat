@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete/add/check task [Show list]
set USAGE=[delete/add/check task_name [hourly/daily/weekly/onstart task]]

if "%~1"=="" (
  call :Show_Tasks_List
  goto Finish
)
if /I "%~1"=="DELETE" (
  call :Delete_Task "%~2"
  goto Finish
)
if /I "%~1"=="ADD" (
  call :Add_Task "%~2" "%~3" "%~4"
  goto Finish
)
if /I "%~1"=="CHECK" (
  call :Check_Task "%~2"
  goto Finish
)
exit /B 255


:Show_Tasks_List
schtasks.exe>nul 2>nul || (
  for /F "tokens=*" %%i in ('dir 2^>nul /A:H /B "%SYSTEMROOT%\Tasks\*.job"') do echo.%%~ni
  exit /B
)
setlocal EnableDelayedExpansion
for /F "tokens=1,2,*" %%i in ('schtasks.exe 2^>nul /QUERY /FO LIST^|%SystemRoot%\System32\find.exe /I "Имя зада"') do (
  set TASK_NAME=%%k
  if "!TASK_NAME:~0,1!"=="\" (
    echo.!TASK_NAME:~1!
  ) else (
    echo.!TASK_NAME!
  )
)
exit /B

:Delete_Task
if "%~1"=="" exit /B 255
if /I "%DEBUG%"=="YES" (
  call           :Check_Task "%~1"
) else (
  call>nul 2>nul :Check_Task "%~1"
)
if errorlevel 1 exit /B 0
schtasks.exe>nul 2>nul || (
  del>nul 2>nul /A /F /Q "%SYSTEMROOT%\Tasks\%~1.job"
  if not exist "%SYSTEMROOT%\Tasks\%~1.job" (
    call EchoSucc Delete task "%~1"
    exit /B 0
  )
)
schtasks.exe>nul 2>nul /F /DELETE /TN "%~1" && (
  call EchoSucc Delete task "%~1"
  exit /B 0
)
schtasks.exe 2>&1 /F /DELETE /TN "%~1"|%SystemRoot%\System32\find.exe>nul 2>nul /I "не удается найти указанный файл" && (
  call EchoSucc Delete task "%~1"
  exit /B 0
)
:Delete_Task_Fail
set DELETE_TASK_ERROR=YES
call EchoFail Delete task "%~1"
if /I "%DEBUG%"=="YES" (
  schtasks.exe>nul 2>nul || (
    del /A /F /Q "%SYSTEMROOT%\Tasks\%~1.job"
    exit /B 1
  )
  schtasks.exe /F /DELETE /TN "%~1"
)
exit /B 1

:Add_Task
if "%~1"=="" exit /B 255
if "%~2"=="" exit /B 255
if "%~3"=="" exit /B 255
schtasks.exe 2>&1 /CREATE /TN "%~1" /SC "%~2" /TR "%~3" /RU "SYSTEM" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "успешно создана" && goto Add_Task_Succ
schtasks.exe 2>&1 /CREATE /TN "%~1" /SC "%~2" /TR "%~3" /RU "SYSTEM"   |%SystemRoot%\System32\find.exe>nul 2>nul /I "успешно создана" && goto Add_Task_Succ
call EchoFail Add task "%~1", run mode: "%~2"
if /I "%DEBUG%"=="YES" schtasks.exe /CREATE /TN "%~1" /SC "%~2" /TR "%~3" /RU "SYSTEM"
exit /B 1
:Add_Task_Succ
call EchoSucc Add task "%~1", run mode: "%~2"
exit /B 0

:Check_Task
if "%~1"=="" exit /B 255
if exist "%SYSTEMROOT%\Tasks\%~1.job"                                   goto Check_Task_Succ
schtasks.exe>nul 2>nul && (
  schtasks.exe 2>nul /QUERY /FO CSV|%SystemRoot%\System32\find.exe>nul 2>nul /I """\%~1""" && goto Check_Task_Succ
  schtasks.exe 2>nul /QUERY /FO CSV|%SystemRoot%\System32\find.exe>nul 2>nul /I """%~1"""  && goto Check_Task_Succ
)
call EchoWarn Task "%~1" is not exist
if /I "%DEBUG%"=="YES" schtasks.exe>nul && (
  schtasks.exe 2>nul /QUERY /FO CSV|%SystemRoot%\System32\find.exe 2>nul /I """\%~1"""
  schtasks.exe 2>nul /QUERY /FO CSV|%SystemRoot%\System32\find.exe 2>nul /I """%~1"""
)
exit /B 1
:Check_Task_Succ
call EchoSucc Task "%~1" is exist
exit /B 0

:Finish
