@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Uninstall software [Show list]
set USAGE=[uninstall name]

if /I "%~1"=="" (
  call :Show_Software
  exit /B
)
if /I "%~1"=="UNINSTALL" (
  call :UnInstall_Software "%~2"
  exit /B
)
exit /B 255


:::Show_Software
::for /F "tokens=1,* delims==" %%i in ('wmic.exe 2^>nul PRODUCT GET "Name" /FORMAT:LIST') do call EchoSucc %%j
::exit /B

:Show_Software
setlocal EnableDelayedExpansion
set tmpfile=%TEMP%\%~nx0.%TIME:~9,2%
reg.exe 2>nul query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"             /S|%SystemRoot%\System32\find.exe " DisplayName"  >"%tmpfile%.1"
reg.exe 2>nul query "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /S|%SystemRoot%\System32\find.exe " DisplayName" >>"%tmpfile%.1"
sort "%tmpfile%.1">"%tmpfile%.2"
for /F "tokens=1,2,*" %%i in (%tmpfile%.2) do if /I "%%~i"=="DisplayName" (
  if not "%%~k"=="!oldname!" call EchoSucc %%~k
  set oldname=%%~k
)
del /A /F /Q "%tmpfile%.*"
endlocal
exit /B

:UnInstall_Software_List
if "%~1"=="" exit /B 255
for /F "tokens=*" %%i in (%~1) do call :UnInstall_Software "%%~i"
exit /B

:::UnInstall_Software
::if "%~1"=="" exit /B 255
::wmic.exe 2>nul path win32_product where "Name like '%%%~1%%'" call UnInstall|%SystemRoot%\System32\find.exe>nul 2>nul /I "successful" && (
::  call EchoSucc Uninstall "%~1"
::  exit /B 0
::)
::call EchoFail Uninstall "%~1"
::exit /B 1

:UnInstall_Software
setlocal EnableDelayedExpansion
set sname=%~1
if defined sname set sname=!sname::=!
if defined sname set sname=!sname:"=!
if not defined sname exit /B 1
set dname=
set ktail=
for /F "tokens=*" %%s in ('reg.exe 2^>nul query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /S^|findstr.exe 2^>nul /R "^HKEY_ ^....DisplayName"') do (
  for /F "tokens=1,2,*" %%a in ("%%~s") do if not "%%~a"=="" (
    if /I "%%~a"=="DisplayName" (
      set dname=%%~c
      if defined dname set dname=!dname::=!
      if defined dname set dname=!dname:"=!
      if defined dname call :MatchStr "!dname!" "!sname!" && call :UnInstall_Software2 "!ktail!"
    ) else (
      set ktail=%%~s
      if defined ktail set ktail=!ktail::=!
      if defined ktail set ktail=!ktail:"=!
      if defined ktail set ktail=!ktail:*Uninstall\=!
    )
  )
)
set dname=
set ktail=
for /F "tokens=*" %%s in ('reg.exe 2^>nul query "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /S^|findstr.exe 2^>nul /R "^HKEY_ ^....DisplayName"') do (
  for /F "tokens=1,2,*" %%a in ("%%~s") do if not "%%~a"=="" (
    if /I "%%~a"=="DisplayName" (
      set dname=%%~c
      if defined dname set dname=!dname::=!
      if defined dname set dname=!dname:"=!
      if defined dname call :MatchStr "!dname!" "!sname!" && call :UnInstall_Software2 "!ktail!"
    ) else (
      set ktail=%%~s
      if defined ktail set ktail=!ktail::=!
      if defined ktail set ktail=!ktail:"=!
      if defined ktail set ktail=!ktail:*Uninstall\=!
    )
  )
)
set dname=
set ktail=
for /F "tokens=*" %%s in ('reg.exe 2^>nul query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Installer\UserData" /S^|findstr.exe 2^>nul /R "^HKEY_ ^....DisplayName"') do (
  for /F "tokens=1,2,*" %%a in ("%%~s") do if not "%%~a"=="" (
    if /I "%%~a"=="DisplayName" (
      set dname=%%~c
      if defined dname set dname=!dname::=!
      if defined dname set dname=!dname:"=!
      if defined dname call :MatchStr "!dname!" "!sname!" && reg.exe delete "!ktail!" /F
    ) else (
      set ktail=%%~s
      if defined ktail set ktail=!ktail::=!
      if defined ktail set ktail=!ktail:"=!
      if defined ktail set ktail=!ktail:\InstallProperties=!
    )
  )
)
set dname=
set ktail=
for /F "tokens=*" %%s in ('reg.exe 2^>nul query "HKCR\Installer\Products" /S^|findstr.exe 2^>nul /R "^HKEY_ ^....ProductName"') do (
  for /F "tokens=1,2,*" %%a in ("%%~s") do if not "%%~a"=="" (
    if /I "%%~a"=="ProductName" (
      set dname=%%~c
      if defined dname set dname=!dname::=!
      if defined dname set dname=!dname:"=!
      if defined dname call :MatchStr "!dname!" "!sname!" && reg.exe delete "!ktail!" /F
    ) else (
      set ktail=%%~s
      if defined ktail set ktail=!ktail::=!
      if defined ktail set ktail=!ktail:"=!
    )
  )
)
endlocal
exit /B
:UnInstall_Software2
if "%~1"=="" exit /B
msiexec.exe>nul 2>nul /X "%~1" /QN /NORESTART
if errorlevel 1 (
  call EchoFail Uninstall "%~1"
) else (
  call EchoSucc Uninstall "%~1"
)
reg.exe>nul 2>nul delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\%~1" /F
reg.exe>nul 2>nul delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\%~1" /F
exit /B

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
