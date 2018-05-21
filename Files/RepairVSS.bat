@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Repair Volume Shadow Copy Service
set USAGE=

call :Repair_VSS
goto Finish


:Repair_VSS
call EchoSucc Repair Volume Shadow Copy Service
net.exe>nul 2>nul stop "vss" /Y
regsvr32.exe    /S "%SYSTEMROOT%\SYSTEM32\ole32.dll"
regsvr32.exe    /S "%SYSTEMROOT%\SYSTEM32\vss_ps.dll"
vssvc.exe    /REGISTER
regsvr32.exe /I /S "%SYSTEMROOT%\SYSTEM32\swprv.dll"
regsvr32.exe /I /S "%SYSTEMROOT%\SYSTEM32\eventcls.dll"
regsvr32.exe    /S "%SYSTEMROOT%\SYSTEM32\es.dll"
regsvr32.exe    /S "%SYSTEMROOT%\SYSTEM32\stdprov.dll"
regsvr32.exe    /S "%SYSTEMROOT%\SYSTEM32\vssui.dll"
regsvr32.exe    /S "%SYSTEMROOT%\SYSTEM32\msxml.dll"
regsvr32.exe    /S "%SYSTEMROOT%\SYSTEM32\msxml3.dll"
regsvr32.exe    /S "%SYSTEMROOT%\SYSTEM32\msxml4.dll"
exit /B

:: http://forum.kamenev.su/index.php?topic=124.0

:Finish
