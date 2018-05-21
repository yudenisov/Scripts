@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable thumbnail cache
set USAGE=disable/enable

call :ThumbCache "%~1"
goto Finish


:ThumbCache
setlocal
if /I "%~1"=="DISABLE" (
  set MODE="1"
  set MODE_NAME=Disable
  call :ThumbCache_Begin
)
if /I "%~1"=="ENABLE" (
  set MODE="0"
  set MODE_NAME=Enable 
  call :ThumbCache_Begin
)
exit /B 255
:ThumbCache_Begin
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe>nul 2>nul add "%%~i\Software\Policies\Microsoft\Windows\Explorer"                /V "DisableThumbsDBOnNetworkFolders" /T REG_DWORD /D "%MODE%" /F || goto ThumbCache_Fail
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoThumbnailCache"                /T REG_DWORD /D "%MODE%" /F || goto ThumbCache_Fail
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DisableThumbnailCache"           /T REG_DWORD /D "%MODE%" /F || goto ThumbCache_Fail
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NoThumbnailCache"                /T REG_DWORD /D "%MODE%" /F || goto ThumbCache_Fail
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisableThumbnailCache"           /T REG_DWORD /D "%MODE%" /F || goto ThumbCache_Fail
                                                               reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoThumbnailCache"                /T REG_DWORD /D "%MODE%" /F || goto ThumbCache_Fail
                                                               reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DisableThumbnailCache"           /T REG_DWORD /D "%MODE%" /F || goto ThumbCache_Fail
                                                               reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NoThumbnailCache"                /T REG_DWORD /D "%MODE%" /F || goto ThumbCache_Fail
                                                               reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisableThumbnailCache"           /T REG_DWORD /D "%MODE%" /F || goto ThumbCache_Fail
call EchoSucc %MODE_NAME% thumbnail cache
exit /B 0
:ThumbCache_Fail
call EchoFail %MODE_NAME% thumbnail cache
if /I "%DEBUG%"=="YES" (
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe add "%%~i\Software\Policies\Microsoft\Windows\Explorer"                /V "DisableThumbsDBOnNetworkFolders" /T REG_DWORD /D "%MODE%" /F
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoThumbnailCache"                /T REG_DWORD /D "%MODE%" /F
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DisableThumbnailCache"           /T REG_DWORD /D "%MODE%" /F
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NoThumbnailCache"                /T REG_DWORD /D "%MODE%" /F
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisableThumbnailCache"           /T REG_DWORD /D "%MODE%" /F
                                                                 reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "NoThumbnailCache"                /T REG_DWORD /D "%MODE%" /F
                                                                 reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DisableThumbnailCache"           /T REG_DWORD /D "%MODE%" /F
                                                                 reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "NoThumbnailCache"                /T REG_DWORD /D "%MODE%" /F
                                                                 reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisableThumbnailCache"           /T REG_DWORD /D "%MODE%" /F
)
exit /B 1

:Finish
