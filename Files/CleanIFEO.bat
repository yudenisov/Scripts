@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Cleaning Image File Execution Options registry keys
set USAGE=

call :Cleaning_IFEO
goto :EoF


:Cleaning_IFEO
reg.exe>nul 2>nul delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options"             /F || goto Cleaning_IFEO_Fail
reg.exe>nul 2>nul add    "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options"             /F || goto Cleaning_IFEO_Fail
reg.exe>nul 2>nul delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" /F || goto Cleaning_IFEO_Fail
reg.exe>nul 2>nul add    "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options" /F || goto Cleaning_IFEO_Fail
call EchoSucc Cleaning "Image File Execution Options" registry keys
exit /B 0
:Cleaning_IFEO_Fail
call EchoFail Cleaning "Image File Execution Options" registry keys
exit /B 1
