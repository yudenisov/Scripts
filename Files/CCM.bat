@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Remove/check Configuration Manager Client
set USAGE=remove/check

if /I "%~1"=="REMOVE" (
  call :Remove_Config_Mgr_Client
  goto Finish
)
if /I "%~1"=="CHECK" (
  call :Check_Config_Mgr_Client
  goto Finish
)
exit /B 255


:Remove_Config_Mgr_Client
call 2>nul :Check_Config_Mgr_Client || (
  call>nul 2>nul :Remove_Config_Mgr_Client_Sub
  exit /B 2
)
if /I "%DEBUG%"=="YES" (
  call :Remove_Config_Mgr_Client_Sub
  exit /B
)
call>nul 2>nul :Remove_Config_Mgr_Client_Sub
call>nul 2>nul :Check_Config_Mgr_Client
  call EchoFail Remove Configuration Manager Client
  exit /B 1
)
call EchoSucc Remove Configuration Manager Client
exit /B 0
:Remove_Config_Mgr_Client_Sub
call EchoTitl Remove Configuration Manager Client
call Software uninstall "Configuration Manager Client"
call Process delete "ccmsetup.exe"
call Svc delete "CcmExec"
call Svc delete "CcmFramework"
call Svc delete "ccmsetup"
call Svc delete "CmRcService"
call Svc delete "smstsmgr"
call Task delete "Microsoft\Configuration Manager\Configuration Manager Health Evaluation"
call Task delete "Microsoft\Configuration Manager\Configuration Manager Idle Detection"
call Task delete "Microsoft\Microsoft\Configuration Manager\Configuration Manager Client Retry Task"
call DeleteRegHKLMSoftware "Microsoft\CCM"
call DeleteRegHKLMSoftware "Microsoft\CCMSetup"
call>nul Directory check "%SYSTEMROOT%\CCM"      || call Directory make "%SYSTEMROOT%\CCM"
call>nul Directory check "%SYSTEMROOT%\ccmcache" || call Directory make "%SYSTEMROOT%\ccmcache"
call>nul Directory check "%SYSTEMROOT%\ccmsetup" || call Directory make "%SYSTEMROOT%\ccmsetup"
call SetAccessMode   "%SYSTEMROOT%\CCM"      full
call SetAccessMode   "%SYSTEMROOT%\ccmcache" full
call SetAccessMode   "%SYSTEMROOT%\ccmsetup" full
call Directory empty "%SYSTEMROOT%\CCM"
call Directory empty "%SYSTEMROOT%\ccmcache"
call Directory empty "%SYSTEMROOT%\ccmsetup"
call SetAccessMode   "%SYSTEMROOT%\CCM"      read
call SetAccessMode   "%SYSTEMROOT%\ccmcache" read
call SetAccessMode   "%SYSTEMROOT%\ccmsetup" read
echo.
exit /B

:Check_Config_Mgr_Client
sc.exe 2>&1 query "CcmExec"     |findstr.exe>nul 2>nul /I "STOPPED RUNNING" && goto :Check_Config_Mgr_Client_Succ
sc.exe 2>&1 query "CcmFramework"|findstr.exe>nul 2>nul /I "STOPPED RUNNING" && goto :Check_Config_Mgr_Client_Succ
sc.exe 2>&1 query "CmRcService" |findstr.exe>nul 2>nul /I "STOPPED RUNNING" && goto :Check_Config_Mgr_Client_Succ
if /I "%DEBUG%"=="YES" call EchoWarn Configuration Manager Client is not exist
exit /B 1
:Check_Config_Mgr_Client_Succ
if /I "%DEBUG%"=="YES" call EchoWarn Configuration Manager Client is exist
exit /B 0

:Finish
