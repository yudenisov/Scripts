@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set time synchronization parameters
set USAGE=

call :Set_Time_Sync_Params
goto Finish


:Set_Time_Sync_Params
call>nul Svc Auto   "NetLogon" || if /I "%DEBUG%"=="YES" call Svc Auto   "NetLogon"
call>nul Svc Start  "NetLogon" || if /I "%DEBUG%"=="YES" call Svc Start  "NetLogon"
:: call Svc_w32time Register
call>nul Svc Demand "w32time"  || if /I "%DEBUG%"=="YES" call Svc Demand "w32time"
call>nul Svc Start  "w32time"  || if /I "%DEBUG%"=="YES" call Svc Start  "w32time"
call>nul EnableNTPServer       || if /I "%DEBUG%"=="YES" call EnableNTPServer
call>nul SetTimeSpecialPollInterval 21600 || if /I "%DEBUG%"=="YES" call SetTimeSpecialPollInterval 21600
call>nul CheckMasterDC && (
  call>nul SetTimeMaxPhaseCorrection ForDC || if /I "%DEBUG%"=="YES" call SetTimeMaxPhaseCorrection ForDC
  call>nul CheckChildDomain && (
    call SetTimeSyncFromDC
    exit /B
  )
  call SetTimeSyncFromSrc
  exit /B
)
call>nul CheckSlaveDC && (
  call>nul SetTimeMaxPhaseCorrection ForDC || if /I "%DEBUG%"=="YES" call SetTimeMaxPhaseCorrection ForDC
  call SetTimeSyncFromDC
  exit /B
)
call>nul SetTimeMaxPhaseCorrection Always  || if /I "%DEBUG%"=="YES" call SetTimeMaxPhaseCorrection Always
call>nul CheckMemberOfDomain && (
  call SetTimeSyncFromDC
  exit /B
)
call SetTimeSyncFromSrc
exit /B

:Finish
