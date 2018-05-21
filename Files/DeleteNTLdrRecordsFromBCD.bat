@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete NTLDR-based records from BCD
set USAGE=

call :Delete_NTLdr_Records_From_BCD
goto Finish


:Delete_NTLdr_Records_From_BCD
bcdedit.exe>nul 2>nul /DELETE {ntldr} /F && (
  call EchoSucc Delete NTLDR-based records from BCD
  exit /B 0
)
call EchoFail Delete NTLDR-based records from BCD
if /I "%DEBUG%"=="YES" bcdedit.exe /DELETE {ntldr} /F
exit /B 1

:Finish
