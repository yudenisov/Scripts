@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable thumbnails
set USAGE=disable/enable

call :Thumbs "%~1"
goto Finish


:Thumbs
setlocal
if /I "%~1"=="DISABLE" (
  set MODE="1"
  set MODE_NAME=Disable
  goto Thumbs_Begin
)
if /I "%~1"=="ENABLE" (
  set MODE="0"
  set MODE_NAME=Enable 
  goto Thumbs_Begin
)
exit /B 255
:Thumbs_Begin
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DisableThumbnails"                 /T REG_DWORD /D "%MODE%" /F || goto Thumbs_Fail
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DisableThumbnailsOnNetworkFolders" /T REG_DWORD /D "%MODE%" /F || goto Thumbs_Fail
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisableThumbnails"                 /T REG_DWORD /D "%MODE%" /F || goto Thumbs_Fail
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisableThumbnailsOnNetworkFolders" /T REG_DWORD /D "%MODE%" /F || goto Thumbs_Fail
                                                               reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DisableThumbnails"                 /T REG_DWORD /D "%MODE%" /F || goto Thumbs_Fail
                                                               reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DisableThumbnailsOnNetworkFolders" /T REG_DWORD /D "%MODE%" /F || goto Thumbs_Fail
                                                               reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisableThumbnails"                 /T REG_DWORD /D "%MODE%" /F || goto Thumbs_Fail
                                                               reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisableThumbnailsOnNetworkFolders" /T REG_DWORD /D "%MODE%" /F || goto Thumbs_Fail
call EchoSucc %MODE_NAME% thumbnails
exit /B 0
:Thumbs_Fail
call EchoFail %MODE_NAME% thumbnails
if /I "%DEBUG%"=="YES" (
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DisableThumbnails"                 /T REG_DWORD /D "%MODE%" /F
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DisableThumbnailsOnNetworkFolders" /T REG_DWORD /D "%MODE%" /F
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisableThumbnails"                 /T REG_DWORD /D "%MODE%" /F
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisableThumbnailsOnNetworkFolders" /T REG_DWORD /D "%MODE%" /F
                                                                 reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DisableThumbnails"                 /T REG_DWORD /D "%MODE%" /F
                                                                 reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /V "DisableThumbnailsOnNetworkFolders" /T REG_DWORD /D "%MODE%" /F
                                                                 reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisableThumbnails"                 /T REG_DWORD /D "%MODE%" /F
                                                                 reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /V "DisableThumbnailsOnNetworkFolders" /T REG_DWORD /D "%MODE%" /F
)
exit /B 1

:Finish
