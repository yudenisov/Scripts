@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Show KMS-server license status for Windows and/or Office
set USAGE=win/off/all

call :Show_KMS "%~1"
goto Finish


:Show_KMS
if /I "%~1"=="WIN" (
  call :Show_KMS_Windows
  exit /B
)
if /I "%~1"=="OFF" (
  call :Show_KMS_Office
  exit /B
)
if /I "%~1"=="ALL" (
  call :Show_KMS_Windows
  call :Show_KMS_Office
  exit /B
)
exit /B 255

:Show_KMS_Windows
cscript.exe 2>&1 /NOLOGO %SYSTEMROOT%\SYSTEM32\slmgr.vbs /DLV
exit /B

:Show_KMS_Office
cscript.exe 2>&1 /NOLOGO %SYSTEMROOT%\SYSTEM32\slmgr.vbs /DLV bfe7a195-4f8f-4f0b-a622-cf13c7d16864
cscript.exe 2>&1 /NOLOGO %SYSTEMROOT%\SYSTEM32\slmgr.vbs /DLV 2e28138a-847f-42bc-9752-61b03fff33cd
exit /B

:Finish
