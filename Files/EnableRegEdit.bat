@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Enable regedit
set USAGE=

call :Enable_RegEdit
goto Finish


:Enable_RegEdit
reg.exe>nul 2>nul   add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /V "DisableRegedit"       /T REG_DWORD /D "0" /F || goto Enable_RegEdit_Fail
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\System" /V "DisableRegedit"       /T REG_DWORD /D "0" /F
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\System" /V "DisableRegistryTools" /T REG_DWORD /D "0" /F
)
call EchoSucc Enable  regedit
exit /B 0
:Enable_RegEdit_Fail
call EchoFail Enable  regedit
if /I "%DEBUG%"=="YES" (
  reg.exe   add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" /V "DisableRegedit"       /T REG_DWORD /D "0" /F
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\System" /V "DisableRegedit"       /T REG_DWORD /D "0" /F
    reg.exe add "%%~i\Software\Microsoft\Windows\CurrentVersion\Policies\System" /V "DisableRegistryTools" /T REG_DWORD /D "0" /F
  )
)
exit /B 1

:Finish
