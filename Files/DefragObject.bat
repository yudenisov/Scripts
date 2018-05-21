@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Defrag file or directory
set USAGE=file_or_dir

call :Defrag_Object "%~1"
goto Finish


:Defrag_Object
call>nul Directory Check "%~1"
if errorlevel 2 exit /B 2
if errorlevel 1 (
  contig.exe>nul 2>nul "%~1" && (
    call EchoSucc Defrag file "%~1"
    exit /B 0
  )
  call EchoFail Defrag file "%~1"
  if /I "%DEBUG%"=="YES" contig.exe "%~1"
  exit /B 1
)
contig.exe>nul 2>nul /S "%~1" && (
  call EchoSucc Defrag directory "%~1"
  exit /B 0
)
call EchoFail Defrag directory "%~1"
if /I "%DEBUG%"=="YES" contig.exe /S "%~1"
exit /B 1

:Finish
