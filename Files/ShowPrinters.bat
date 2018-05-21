@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Show printers [real only]
set USAGE=[real]

call :Show_Printers "%~1"
goto Finish


:Show_Printers
for /F "tokens=*" %%i in ('reg.exe 2^>nul query "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Windows" /V "Device"^|%SystemRoot%\System32\find.exe 2^>nul /I "REG_SZ"^|sed.exe 2^>nul -e "s/^.*[ \t]\+REG_SZ[ \t]\+//; s/,.*//"') do set DEFAULT_PRINTER=%%i
for /F "tokens=*" %%i in ('reg.exe 2^>nul query "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Devices"            ^|%SystemRoot%\System32\find.exe 2^>nul /I "REG_SZ"^|sed.exe 2^>nul -e "s/[ \t]\+REG_SZ.*//"                 ') do call :Show_Printers_Sub "%~1" "%%i"
::for /F "tokens=1,* delims==" %%i in ('wmic.exe 2^>nul PRINTER WHERE "Default=TRUE" GET "Caption" /FORMAT:LIST') do if not "%%j"=="" set DEFAULT_PRINTER=%%j
::for /F "tokens=1,* delims==" %%i in ('wmic.exe 2^>nul PRINTER                      GET "Caption" /FORMAT:LIST') do if not "%%j"=="" call :Show_Printers_Sub "%~1" "%%j"
exit /B
:Show_Printers_Sub
if /I "%~1"=="REAL" (
  if /I "%~2"=="Fax"                                    exit /B
  if /I "%~2"=="Microsoft XPS Document Writer"          exit /B
  if /I "%~2"=="Microsoft Office Document Image Writer" exit /B
  if /I "%~2"=="PDFCreator"                             exit /B
  echo "%~2"|%SystemRoot%\System32\find.exe>nul 2>nul /I "OneNote" &&         exit /B
)
if /I "%~2"=="%DEFAULT_PRINTER%" (
  call EchoWarn "%~2"
  exit /B
)
call EchoSucc "%~2"
exit /B

:Finish
