@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete registry key or value
set USAGE=reg_key [reg_val]

call :Delete_Reg_Entry "%~1" "%~2"
goto Finish


:Delete_Reg_Entry
if "%~1"=="" exit /B 255
if "%~2"=="" (
  reg.exe>nul 2>nul delete "%~1" /F && (
    call EchoSucc Delete RegKey "%~1"
    exit /B 0
  )
  reg.exe 2>&1 delete "%~1" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "найти указанный раздел или параметр" && exit /B 2
  reg.exe 2>&1 delete "%~1" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "эрщЄш єърчрээ√щ Ёрчфхы шыш ярЁрьхЄЁ" && exit /B 2
  set DELETE_REG_ENTRY_ERROR=YES
  call EchoFail Delete RegKey "%~1"
  if /I "%DEBUG%"=="YES" reg.exe delete "%~1" /F
  exit /B 1
)
reg.exe>nul 2>nul delete "%~1" /V "%~2" /F && (
  call EchoSucc Delete RegVal "%~1\%~2"
  exit /B 0
)
reg.exe 2>&1 delete "%~1" /V "%~2" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "найти указанный раздел или параметр" && exit /B 2
reg.exe 2>&1 delete "%~1" /V "%~2" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "эрщЄш єърчрээ√щ Ёрчфхы шыш ярЁрьхЄЁ" && exit /B 2
set DELETE_REG_ENTRY_ERROR=YES
call EchoFail Delete RegVal "%~1\%~2"
if /I "%DEBUG%"=="YES" reg.exe delete "%~1" /V "%~2" /F
exit /B 1

:Finish
