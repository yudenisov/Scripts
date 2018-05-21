@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete/add role DHCP Server
set USAGE=delete/add

if /I "%~1"=="DELETE" (
  call :Delete_Role_DHCPServer
  goto Finish
)
if /I "%~1"=="ADD" (
  call :Add_Role_DHCPServer
  goto Finish
)
exit /B 255


:Delete_Role_DHCPServer
call CheckOSType|%SystemRoot%\System32\find.exe>nul 2>nul /I "Core" && goto Delete_Role_DHCPServer_Core
call Svc Disable DHCPServer
call Feature Disable "DHCPServer"
exit /B
:Delete_Role_DHCPServer_Core
call Svc Disable DHCPServer
call Feature Enable "DHCPServerCore"
exit /B

:Add_Role_DHCPServer
call CheckOSType|%SystemRoot%\System32\find.exe>nul 2>nul /I "Core" && goto Add_Role_DHCPServer_Core
call Feature Enable "DHCPServer"
call Svc Auto  DHCPServer
call Svc Start DHCPServer
exit /B
:Add_Role_DHCPServer_Core
call Feature Enable "DHCPServerCore"
call Svc Auto  DHCPServer
call Svc Start DHCPServer
exit /B

:Finish
