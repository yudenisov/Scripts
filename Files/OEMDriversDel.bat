@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete all OEM drivers
set USAGE=


call EchoTitl Display all OEM drivers
pnputil.exe /E|%SystemRoot%\System32\find.exe /I ".inf"

call EchoTitl Delete all OEM drivers
for /F %%d in ('pnputil.exe /E^|%SystemRoot%\System32\find.exe /I ".inf"') do pnputil.exe>nul /F /D "%%d"

call EchoTitl Display all OEM drivers
pnputil.exe /E|%SystemRoot%\System32\find.exe /I ".inf"
