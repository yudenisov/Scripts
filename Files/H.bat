@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Scripts help
set USAGE=[command]

if "%~1"=="" (
  call :Echo_Titl Scripts v1.0.441  ^(C^) SMKSoft, 2017
  echo.
  call :Help "*.bat"
) else (
  call :Help "%~1"
)
goto Finish


:Help
cd>nul 2>nul /D "%SYSTEMROOT%" || exit /B 1
setlocal EnableDelayedExpansion
set COUNT=0
set FILE=%~1
set FILE=%FILE:.bat=%
for %%i in (%FILE%.bat) do (
  if exist "%%i" (
    set FILE=%%i
    set FILE=!FILE:.bat=!
    set HLP=
    set USE=
    for /F "tokens=1,2 delims==" %%j in ('type "%%i"^|%SystemRoot%\System32\find.exe /V "find"^|%SystemRoot%\System32\find.exe "HELP="' ) do set HLP=%%k
    if not "!HLP!"=="" (
      for /F "tokens=1,2 delims==" %%j in ('type "%%i"^|%SystemRoot%\System32\find.exe /V "find"^|%SystemRoot%\System32\find.exe "USAGE="') do set USE=%%k
      if /I "%~1"=="*.bat" (
        call :Echo_2Col 10 11    "!FILE!: " "!HLP!"
        set /A COUNT=!COUNT!+1
        if "!COUNT!"=="24" (
          echo.
          call Wait
          set COUNT=0
        )
      ) else (
        call :Echo_1Col 11       "!HLP!"
        call :Echo_3Col 11 10 13 "Usage: " "!FILE! " "!USE!"
      )
    )
  )
)
exit /B

:Echo_Titl
if "%~1"=="" exit /B 255
echo.
hs_color.exe 2>nul 14 && echo %* || echo *** %* ***
hs_color.exe 2>nul  7
exit /B

:Echo_1Col
if "%~1"=="" exit /B 255
if "%~2"=="" exit /B 255
hs_color.exe 2>nul %~1   || goto Echo_1Col_Fail
hs_echo.exe  2>nul "%~2" || goto Echo_1Col_Fail
hs_color.exe 2>nul 7
echo.
exit /B 0
:Echo_1Col_Fail
hs_color.exe 2>nul 7
echo %~2
exit /B 1

:Echo_2Col
if "%~1"=="" exit /B 255
if "%~2"=="" exit /B 255
if "%~3"=="" exit /B 255
hs_color.exe 2>nul %~1   || goto Echo_2Col_Fail
hs_echo.exe  2>nul "%~3" || goto Echo_2Col_Fail
hs_color.exe 2>nul %~2
hs_echo.exe  2>nul "%~4"
hs_color.exe 2>nul 7
echo.
exit /B 0
:Echo_2Col_Fail
hs_color.exe 2>nul 7
echo %~3%~4
exit /B 1

:Echo_3Col
if "%~1"=="" exit /B 255
if "%~2"=="" exit /B 255
if "%~3"=="" exit /B 255
if "%~4"=="" exit /B 255
hs_color.exe 2>nul %~1   || goto Echo_3Col_Fail
hs_echo.exe  2>nul "%~4" || goto Echo_3Col_Fail
hs_color.exe 2>nul %~2
hs_echo.exe  2>nul "%~5"
hs_color.exe 2>nul %~3
hs_echo.exe  2>nul "%~6"
hs_color.exe 2>nul 7
echo.
exit /B 0
:Echo_3Col_Fail
hs_color.exe 2>nul 7
echo %~4%~5%~6
exit /B 1

:Finish
