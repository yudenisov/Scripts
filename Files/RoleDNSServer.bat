@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete/add role DNS Server
set USAGE=delete/add

if /I "%~1"=="DELETE" (
  call :Delete_Role_DNSServer
  goto Finish
)
if /I "%~1"=="ADD" (
  call :Add_Role_DNSServer
  goto Finish
)
exit /B 255


:Delete_Role_DNSServer
call CheckOSType|%SystemRoot%\System32\find.exe>nul 2>nul /I "Core" && goto Delete_Role_DNSServer_Core
call Feature Disable "DNS-Server-Full-Role"
exit /B
:Delete_Role_DNSServer_Core
call Feature Enable "DNS-Server-Core-Role"
exit /B

:Add_Role_DNSServer
call CheckOSType|%SystemRoot%\System32\find.exe>nul 2>nul /I "Core" && goto Add_Role_DNSServer_Core
call Feature Enable "DNS-Server-Full-Role"
exit /B
:Add_Role_DNSServer_Core
call Feature Enable "DNS-Server-Core-Role"
exit /B

:Finish
