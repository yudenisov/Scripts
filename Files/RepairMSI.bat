@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Repair Microsoft Windows Installer
set USAGE=

call :Repair_MSI
goto Finish


:Repair_MSI
net.exe    >nul 2>nul stop "msiserver" /Y
hidec.exe  >nul 2>nul regsvr32.exe /U /S "%SYSTEMROOT%\SYSTEM32\msi.dll"
hidec.exe  >nul 2>nul regsvr32.exe /U /S "%SYSTEMROOT%\SYSTEM32\msihnd.dll"
hidec.exe  >nul 2>nul regsvr32.exe /U /S "%SYSTEMROOT%\SYSTEM32\msisip.dll"
hidec.exe  >nul 2>nul regsvr32.exe /S    "%SYSTEMROOT%\SYSTEM32\msi.dll"
hidec.exe  >nul 2>nul regsvr32.exe /S    "%SYSTEMROOT%\SYSTEM32\msihnd.dll"
hidec.exe  >nul 2>nul regsvr32.exe /S    "%SYSTEMROOT%\SYSTEM32\msisip.dll"
"%SYSTEMROOT%\SYSTEM32\msiexec.exe">nul 2>nul /QN /UNREGISTER
"%SYSTEMROOT%\SYSTEM32\msiexec.exe">nul 2>nul /QN /REGSERVER
"%SYSTEMROOT%\SYSWOW64\msiexec.exe">nul 2>nul /QN /UNREGISTER
"%SYSTEMROOT%\SYSWOW64\msiexec.exe">nul 2>nul /QN /REGSERVER
net.exe    2>&1       start "msiserver"|findstr.exe>nul 2>nul /I "�ᯥ譮 㦥" (
  call EchoSucc Repair Microsoft Windows Installer
  exit /B 0
)
call EchoFail Repair Microsoft Windows Installer
if /I "%DEBUG%"=="YES" (
  net.exe      stop "msiserver" /Y
  regsvr32.exe /U /S "%SYSTEMROOT%\SYSTEM32\msi.dll"
  regsvr32.exe /U /S "%SYSTEMROOT%\SYSTEM32\msihnd.dll"
  regsvr32.exe /U /S "%SYSTEMROOT%\SYSTEM32\msisip.dll"
  regsvr32.exe /S    "%SYSTEMROOT%\SYSTEM32\msi.dll"
  regsvr32.exe /S    "%SYSTEMROOT%\SYSTEM32\msihnd.dll"
  regsvr32.exe /S    "%SYSTEMROOT%\SYSTEM32\msisip.dll"
  "%SYSTEMROOT%\SYSTEM32\msiexec.exe" /QN /UNREGISTER
  "%SYSTEMROOT%\SYSTEM32\msiexec.exe" /QN /REGSERVER
  "%SYSTEMROOT%\SYSWOW64\msiexec.exe" /QN /UNREGISTER
  "%SYSTEMROOT%\SYSWOW64\msiexec.exe" /QN /REGSERVER
  net.exe      start "msiserver"
)
exit /B 1

:: http://it-like.ru/ne-rabotaet-ustanovshhik-windows-installer-oshibka-msi/#ixzz39Ao8DWjt

:Finish
