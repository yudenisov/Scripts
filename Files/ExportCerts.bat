@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Export Disallowed and Trusted Publisher Certs to files
set USAGE=

call :Export_Certs
goto Finish


:Export_Certs
setlocal
reg.exe>nul 2>nul export "HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\Disallowed\Certificates"       "DisallowedCerts.reg"       /Y || goto Export_Certs_Fail
reg.exe>nul 2>nul export "HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\TrustedPublisher\Certificates" "TrustedPublisherCerts.reg" /Y || goto Export_Certs_Fail
call EchoSucc Export Certs
exit /B 0
:Export_Certs_Fail
call EchoFail Export Certs
if /I "%DEBUG%"=="YES" (
  reg.exe export "HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\Disallowed\Certificates"       "DisallowedCerts.reg" /Y
  reg.exe export "HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\TrustedPublisher\Certificates" "TrustedPublisherCerts.reg" /Y
)
exit /B 1

:Finish
