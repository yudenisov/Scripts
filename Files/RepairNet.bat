@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Repair network settings
set USAGE=

call :Repair_Net
goto Finish

:Repair_Net
call NetConf Backup
call CleanHosts
call Release
call Renew
call RegisterDNS
call FlushDNS
call ResetWinsock
call ResetIP4
call ResetIP6
call NetConf Restore
call Reboot
exit /B

:Finish
