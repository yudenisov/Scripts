@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Make active specified partition
set USAGE=[disk_number [part_number]]

call :Make_Active_Part "%~1" "%~2"
goto Finish


:Make_Active_Part
set TMPFILE=%TEMP%\MakeActivePart.tmp
if "%~1"=="" (
  echo> "%TMPFILE%" list disk
  goto Make_Active_Part_DiskPart
)
if "%~2"=="" (
  echo> "%TMPFILE%" select disk %~1
  echo>>"%TMPFILE%" list part
  goto Make_Active_Part_DiskPart
)
echo>>"%TMPFILE%" select disk %~1
echo>>"%TMPFILE%" select part %~2
echo>>"%TMPFILE%" active
:Make_Active_Part_DiskPart
echo>>"%TMPFILE%" exit
if not exist "%TMPFILE%" exit /B 1
diskpart.exe 2>nul /S "%TMPFILE%" && (
  del>nul 2>nul /A /F /Q "%TMPFILE%"
  exit /B 0
)
del>nul 2>nul /A /F /Q "%TMPFILE%"
exit /B 1

:Finish
