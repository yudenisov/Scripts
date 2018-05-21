@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Microsoft Security Client control
set USAGE=sigremove/sigupdate/quickscan/fullscan [Show quarantined list]

if /I "%~1"=="SIGREMOVE" (
  call :MSE_SigRemove
  goto Finish
)
if /I "%~1"=="SIGUPDATE" (
  call :MSE_SigUpdate
  goto Finish
)
if /I "%~1"=="QUICKSCAN" (
  call :MSE_QuickScan
  goto Finish
)
if /I "%~1"=="FULLSCAN" (
  call :MSE_FullScan
  goto Finish
)
goto MSE_ShowQuarantinedList
exit /B 255

:MSE_ShowQuarantinedList
setlocal
set PROGRAM_DIR=%ProgramFiles: (x86)=%
if exist "%PROGRAM_DIR%\Microsoft Security Client\MpCmdRun.exe" (
  "%PROGRAM_DIR%\Microsoft Security Client\MpCmdRun.exe" -Restore -ListAll
)
exit /B

:MSE_SigRemove
setlocal
set PROGRAM_DIR=%ProgramFiles: (x86)=%
if exist "%PROGRAM_DIR%\Microsoft Security Client\MpCmdRun.exe" (
  "%PROGRAM_DIR%\Microsoft Security Client\MpCmdRun.exe" -RemoveDefinitions -All
)
exit /B

:MSE_SigUpdate
setlocal
set PROGRAM_DIR=%ProgramFiles: (x86)=%
if exist "%PROGRAM_DIR%\Microsoft Security Client\MpCmdRun.exe" (
  "%PROGRAM_DIR%\Microsoft Security Client\MpCmdRun.exe" -SignatureUpdate -MMPC
)
exit /B

:MSE_QuickScan
setlocal
set PROGRAM_DIR=%ProgramFiles: (x86)=%
if exist "%PROGRAM_DIR%\Microsoft Security Client\MpCmdRun.exe" (
  "%PROGRAM_DIR%\Microsoft Security Client\MpCmdRun.exe" -Scan -ScanType 1
)
exit /B

:MSE_FullScan
setlocal
set PROGRAM_DIR=%ProgramFiles: (x86)=%
if exist "%PROGRAM_DIR%\Microsoft Security Client\MpCmdRun.exe" (
  "%PROGRAM_DIR%\Microsoft Security Client\MpCmdRun.exe" -Scan -ScanType 2
)
exit /B

:Finish
