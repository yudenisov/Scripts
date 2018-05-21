@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Closure of all shared files
set USAGE=

call :Close_All_Shared_Files
goto Finish


:Close_All_Shared_Files
if /I "%DEBUG%"=="YES" (
  call EchoTitl Closure of all shared files
  for /f "skip=4 tokens=1" %%i in ('net.exe file') do net.exe file "%%~i" /close
  exit /B
)
call EchoSucc Closure of all shared files
for /f "skip=4 tokens=1" %%i in ('net.exe 2^>nul file') do net.exe>nul 2>nul file "%%~i" /close
exit /B

:Finish
