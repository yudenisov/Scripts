@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete HKCU registry key or value
set USAGE=hkcu_reg_key [reg_val]

call :Delete_Reg_HKCU "%~1" "%~2"
goto Finish


:Delete_Reg_HKCU
if "%~1"=="" exit /B 255
if "%~2"=="" (
  call>nul 2>nul :Delete_RegKey_HKCU "%~1" && (
    call EchoSucc Delete RegKey "HKCU\%~1"
    exit /B 0
  )
  reg.exe 2>&1 delete "HKCU\%~1" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "­ ©â¨ ãª § ­­ë© à §¤¥« ¨«¨ ¯ à ¬¥âà" && exit /B 2
  reg.exe 2>&1 delete "HKCU\%~1" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "íàéòè óêàçàííûé ðàçäåë èëè ïàðàìåòð" && exit /B 2
  set DELETE_REG_ENTRY_ERROR=YES
  call EchoFail Delete RegKey "HKCU\%~1"
  if /I "%DEBUG%"=="YES" call :Delete_RegKey_HKCU "%~1"
  exit /B 1
)
call>nul 2>nul :Delete_RegVal_HKCU "%~1" "%~2" && (
  call EchoSucc Delete RegVal "HKCU\%~1" "%~2"
  exit /B 0
)
reg.exe 2>&1 delete "HKCU\%~1" /V "%~2" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "­ ©â¨ ãª § ­­ë© à §¤¥« ¨«¨ ¯ à ¬¥âà" && exit /B 2
reg.exe 2>&1 delete "HKCU\%~1" /V "%~2" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "íàéòè óêàçàííûé ðàçäåë èëè ïàðàìåòð" && exit /B 2
set DELETE_REG_ENTRY_ERROR=YES
call EchoFail Delete RegVal "HKCU\%~1" "%~2"
if /I "%DEBUG%"=="YES" call :Delete_RegVal_HKCU "%~1" "%~2"
exit /B 1

:Delete_RegKey_HKCU
if "%~1"=="" exit /B 255
setlocal
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe delete "%%~i\%~1" /F && set success=yes
if /I "%success%"=="yes" exit /B 0
exit /B 1

:Delete_RegVal_HKCU
if "%~1"=="" exit /B 255
if "%~2"=="" exit /B 255
setlocal
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do reg.exe delete "%%~i\%~1" /V "%~2" /F && set success=yes
if /I "%success%"=="yes" exit /B 0
exit /B 1

:Finish
