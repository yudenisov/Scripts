@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete HKLM\SOFTWARE[\Wow6432Node] registry key or value
set USAGE=hklm_software_reg_key [reg_val]

                             call :Delete_Reg_HKLM_Software "%~1"             "%~2"
if defined ProgramFiles(x86) call :Delete_Reg_HKLM_Software "Wow6432Node\%~1" "%~2"
goto Finish


:Delete_Reg_HKLM_Software
if "%~1"==""             exit /B 255
if "%~1"=="Wow6432Node\" exit /B 255
if "%~2"=="" (
  reg.exe>nul 2>nul delete "HKLM\Software\%~1" /F && (
    call EchoSucc Delete RegKey "HKLM\Software\%~1"
    exit /B 0
  )
  reg.exe 2>&1 delete "HKLM\Software\%~1" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "найти указанный раздел или параметр" && exit /B 2
  reg.exe 2>&1 delete "HKLM\Software\%~1" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "эрщЄш єърчрээ√щ Ёрчфхы шыш ярЁрьхЄЁ" && exit /B 2
  set DELETE_REG_ENTRY_ERROR=YES
  call EchoFail Delete RegKey "HKLM\Software\%~1"
  if /I "%DEBUG%"=="YES" reg.exe delete "HKLM\Software\%~1" /F
  exit /B 1
)
reg.exe>nul 2>nul delete "HKLM\Software\%~1" /V "%~2" /F && (
  call EchoSucc Delete RegVal "HKLM\Software\%~1\%~2"
  exit /B 0
)
reg.exe 2>&1 delete "HKLM\Software\%~1" /V "%~2" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "найти указанный раздел или параметр" && exit /B 2
reg.exe 2>&1 delete "HKLM\Software\%~1" /V "%~2" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "эрщЄш єърчрээ√щ Ёрчфхы шыш ярЁрьхЄЁ" && exit /B 2
set DELETE_REG_ENTRY_ERROR=YES
call EchoFail Delete RegVal "HKLM\Software\%~1\%~2"
if /I "%DEBUG%"=="YES" reg.exe delete "HKLM\Software\%~1" /V "%~2" /F
exit /B 1

:Finish
