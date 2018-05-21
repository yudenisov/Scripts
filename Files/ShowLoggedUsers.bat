@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Show logged users
set USAGE=

call :Show_Logged_Users
goto Finish


:Show_Logged_Users
for /F "tokens=7,8 delims=," %%i in ('tasklist.exe /V /NH /FO CSV^|%SystemRoot%\System32\find.exe /I """explorer.exe"""') do (
  for /F "tokens=*" %%k in (%%i) do (
    for /F %%l in ('echo %%k^|%SystemRoot%\System32\find.exe "\"') do if not "%%l"=="" echo %%l
  )
  for /F "tokens=*" %%k in (%%j) do (
    for /F %%l in ('echo %%k^|%SystemRoot%\System32\find.exe "\"') do if not "%%l"=="" echo %%l
  )
)
exit /B

:Finish
