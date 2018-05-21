@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete Disallowed Certs
set USAGE=

call :Delete_DisallowedCerts
goto Finish


:Delete_DisallowedCerts
reg.exe>nul 2>nul delete "HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\Disallowed\Certificates" /F && (
  call EchoSucc Delete Disallowed Certs
  exit /B 0
)
reg.exe 2>&1 delete "HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\Disallowed\Certificates" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "найти указанный раздел или параметр" && exit /B 2
reg.exe 2>&1 delete "HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\Disallowed\Certificates" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "эрщЄш єърчрээ√щ Ёрчфхы шыш ярЁрьхЄЁ" && exit /B 2
call EchoFail Delete Disallowed Certs
if /I "%DEBUG%"=="YES" reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\Disallowed\Certificates" /F
exit /B 1

:Finish
