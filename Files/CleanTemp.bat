@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Cleaning users and windows temp files
set USAGE=

call :Cleaning_Temp
goto Finish


:Cleaning_Temp
set DELETE_OBJECT_ERROR=NO
if /I "%DEBUG%"=="YES" (
  call           :Cleaning_Temp_Sub
) else (
  call>nul 2>nul :Cleaning_Temp_Sub
)
if /I "%DEBUG%"=="YES" (
  echo.
  if /I "%DELETE_OBJECT_ERROR%"=="YES" (
    exit /B 1
  )
  exit /B 0
)
if /I "%DELETE_OBJECT_ERROR%"=="YES" (
  call EchoFail Cleaning temp
  exit /B 1
)
call EchoSucc Cleaning temp
exit /B 0
:Cleaning_Temp_Sub
setlocal
call EchoTitl Cleaning temp
if /I not "%TEMP%"=="" mkdir>nul 2>nul "%TEMP%"
if /I not "%TEMP%"=="%SYSTEMDRIVE%\TEMP" call :Delete_Objects_Old "%SYSTEMDRIVE%\TEMP"
if /I not "%TEMP%"=="%SYSTEMROOT%\TEMP"  call :Delete_Objects_Old "%SYSTEMROOT%\TEMP"
                                         call :Delete_Objects_Old "%SYSTEMROOT%\System32\spool\PRINTERS"
                                         call :Delete_Objects_Old "%SYSTEMROOT%\SoftwareDistribution\Download"
for /D %%i in ("%SYSTEMDRIVE%\Users" "%SYSTEMDRIVE%\Documents and Settings") do ^
for /D %%j in ("%%~i\All Users" "%%~i\Default" "%%~i\Public" "%%~i\Администратор" "%%~i\*.*") do ^
for /D %%k in ("%%~j\AppData\Local" "%%~j\AppData\Local\Microsoft\Windows" "%%~j\AppData\Roaming" "%%~j\Application Data" "%%~j\Local Settings") do ^
for /D %%l in ("%%~k\Temp" "%%~k\Temporary Internet Files") do ^
call :Delete_Objects_Old "%%~l"
for /D %%i in ("%SYSTEMROOT%\ServiceProfiles") do ^
for /D %%j in ("%%~i\LocalService" "%%~i\NetworkService") do ^
for /D %%k in ("%%~j\AppData\Local" "%%~j\AppData\Local\Microsoft\Windows" "%%~j\AppData\Roaming" "%%~j\Application Data" "%%~j\Local Settings") do ^
for /D %%l in ("%%~k\Temp" "%%~k\Temporary Internet Files") do ^
call :Delete_Objects_Old "%%~l"
for /D %%i in ("%SYSTEMROOT%\System32" "%SYSTEMROOT%\SysWOW64") do ^
for /D %%j in ("%%~i\config\systemprofile") do ^
for /D %%k in ("%%~j\AppData\Local" "%%~j\AppData\Local\Microsoft\Windows" "%%~j\AppData\Roaming" "%%~j\Application Data" "%%~j\Local Settings") do ^
for /D %%l in ("%%~k\Temp" "%%~k\Temporary Internet Files") do ^
call :Delete_Objects_Old "%%~l"
exit /B

:Delete_Objects_Old
if "%~1"=="" exit /B 1
for /F "tokens=*" %%i in ('forfiles.exe 2^>nul /S /D -7 /P "%~1" /C "%COMSPEC% /C echo @path"') do call DeleteObject "%%~i"
exit /B

:Finish
