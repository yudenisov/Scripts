@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=User profile settings [Show list]
set USAGE=[delete username]

if /I "%~1"=="" (
  call :Show_Users_Profile_Settings
  exit /B
)
if /I "%~1"=="DELETE" (
  call :Delete_User_Profile_Settings "%~2"
  exit /B
)
exit /B 255

:Show_Users_Profile_Settings
setlocal EnableDelayedExpansion
set tmpfile=%TEMP%\%~nx0.%TIME:~9,2%
reg.exe 2>nul query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" /S|%SystemRoot%\System32\find.exe " ProfileImagePath"|%SystemRoot%\System32\find.exe /V "\systemprofile"|%SystemRoot%\System32\find.exe /V "\ServiceProfiles"|sort>"%tmpfile%"
for /F "tokens=1,2,*" %%i in (%tmpfile%) do if /I "%%~i"=="ProfileImagePath" (
  if not "%%~k"=="!oldname!" call EchoSucc %%~k
  set oldname=%%~k
)
del /A /F /Q "%tmpfile%"
exit /B

:Delete_User_Profile_Settings
setlocal EnableDelayedExpansion
set sname=%~1
if defined sname set sname=!sname::=!
if defined sname set sname=!sname:"=!
if not defined sname exit /B 1
set value=
set ktail=
for /F "tokens=*" %%s in ('reg.exe 2^>nul query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList" /S^|findstr.exe 2^>nul /R "^HKEY_ ^....ProfileImagePath"') do (
  for /F "tokens=1,2,*" %%a in ("%%~s") do if not "%%~a"=="" (
    if /I "%%~a"=="ProfileImagePath" (
      set value=%%~c
      if defined value set value=!value::=!
      if defined value set value=!value:"=!
      if defined value call :MatchStr "!value!" "\!sname!" && (
        reg.exe delete "!ktail!" /F && (
          call EchoSucc Delete user "!sname!" profile settings
          exit /B 0
        )
        call EchoFail Delete user "!sname!" profile settings
        exit /B 1
      )
    ) else (
      set ktail=%%~s
      if defined ktail set ktail=!ktail::=!
      if defined ktail set ktail=!ktail:"=!
    )
  )
)
call EchoFail User "!sname!" profile settings not found
exit /B 255

:MatchStr
if "%~1"=="" exit /B 1
if "%~2"=="" exit /B 1
setlocal
set str="%~1"
set str=%str:&=^&%
set str=%str:"=%
call :MatchStr2 "%str%" "%%str:%~2=%%"
endlocal
exit /B
:MatchStr2
if "%~1"=="%~2" exit /B 1
exit /B 0

:Finish

:: Решение проблем:
::
::  - Служба "Клиент групповой политики" препятствует входу в систему.
::    Отказано в доступе
::
::  - Вход в систему выполнен с временным профилем Windows
::
:: http://chopen.net/logon-failure/
