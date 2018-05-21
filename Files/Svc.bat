@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Service control [Show list of started]
set USAGE=[delete/disable/auto/demand/stop/start/check service_name]

if "%~1"=="" (
  call :Show_Svc_List
  goto Finish
)
if /I "%~1"=="DELETE" (
  call :Delete_Svc "%~2"
  goto Finish
)
if /I "%~1"=="DISABLE" (
  call :Disable_Svc "%~2"
  goto Finish
)
if /I "%~1"=="AUTO" (
  call :Enable_Svc_Auto "%~2"
  goto Finish
)
if /I "%~1"=="DEMAND" (
  call :Enable_Svc_DEMAND "%~2"
  goto Finish
)
if /I "%~1"=="STOP" (
  call :Stop_Svc "%~2"
  goto Finish
)
if /I "%~1"=="START" (
  call :Start_Svc "%~2"
  goto Finish
)
if /I "%~1"=="CHECK" (
  call :Check_Svc "%~2"
  goto Finish
)
exit /B 255


:Show_Svc_List
for /F "tokens=1,*" %%i in ('sc.exe 2^>nul QUERY^|findstr.exe /R "^......._....: ^..._......:"^|%SystemRoot%\System32\find.exe /V "DISPLAY_NAME"') do (
  findstr.exe>nul 2>nul /I /L "%%j" "%SYSTEMROOT%\SYSTEM32\svc_known.txt"
  if errorlevel 1 (
    echo.%%j
  ) else (
    call EchoSucc %%j
  )
)
exit /B

:Delete_Svc
sc.exe 2>&1 query "%~1"|findstr.exe>nul 2>nul /I "STOPPED RUNNING" || (
  if /I "%DEBUG%"=="YES" call EchoFail Delete service "%~1" - not exist
  exit /B 2
)
call>nul 2>nul :Disable_Svc "%~1" && (
  call>nul 2>nul DeleteRegEntry "HKLM\SYSTEM\CurrentControlSet\Services\%~1"
  call EchoSucc Delete service "%~1"
  exit /B 0
)
call EchoFail Delete service "%~1"
if /I "%DEBUG%"=="YES" (
  call :Disable_Svc "%~1"
  call DeleteRegEntry "HKLM\SYSTEM\CurrentControlSet\Services\%~1"
)
exit /B 1

:Disable_Svc
sc.exe 2>&1 query "%~1"|findstr.exe>nul 2>nul /I "STOPPED RUNNING" || (
  if /I "%DEBUG%"=="YES" call EchoFail Disable service "%~1" - not exist
  exit /B 2
)
call>nul 2>nul :Stop_Svc "%~1"
                                sc.exe 2>&1 config "%~1" start= disabled|findstr.exe>nul 2>nul /I "успех SUCCESS 1060:" && goto Disable_Svc_Succ
psx.exe 2>nul /ACCEPTEULA /E /S sc.exe 2>&1 config "%~1" start= disabled|findstr.exe>nul 2>nul /I "успех SUCCESS 1060:" && goto Disable_Svc_Succ
call EchoFail Disable service "%~1"
if /I "%DEBUG%"=="YES" psx.exe /ACCEPTEULA /E /S sc.exe config "%~1" start= disabled
exit /B 1
:Disable_Svc_Succ
call EchoSucc Disable service "%~1"
exit /B 0

:Enable_Svc_Auto
sc.exe 2>&1 query "%~1"|findstr.exe>nul 2>nul /I "STOPPED RUNNING" || (
  if /I "%DEBUG%"=="YES" call EchoFail Enable  service "%~1" - not exist
  exit /B 2
)
                                sc.exe 2>&1 config "%~1" start= auto|findstr.exe>nul 2>nul /I "успех SUCCESS" && goto Enable_Svc_Auto_Succ
psx.exe 2>nul /ACCEPTEULA /E /S sc.exe 2>&1 config "%~1" start= auto|findstr.exe>nul 2>nul /I "успех SUCCESS" && goto Enable_Svc_Auto_Succ
call EchoFail Enable  service "%~1", mode "Auto"
if /I "%DEBUG%"=="YES" psx.exe /ACCEPTEULA /E /S sc.exe config "%~1" start= auto
exit /B 1
:Enable_Svc_Auto_Succ
call EchoSucc Enable  service "%~1", mode "Auto"
exit /B 0


:Enable_Svc_Demand
sc.exe 2>&1 query "%~1"|findstr.exe>nul 2>nul /I "STOPPED RUNNING" || (
  if /I "%DEBUG%"=="YES" call EchoFail Enable  service "%~1" - not exist
  exit /B 2
)
                                sc.exe 2>&1 config "%~1" start= demand|findstr.exe>nul 2>nul /I "успех SUCCESS" && goto Enable_Svc_Demand_Succ
psx.exe 2>nul /ACCEPTEULA /E /S sc.exe 2>&1 config "%~1" start= demand|findstr.exe>nul 2>nul /I "успех SUCCESS" && goto Enable_Svc_Demand_Succ
call EchoFail Enable  service "%~1", mode "Demand"
if /I "%DEBUG%"=="YES" psx.exe /ACCEPTEULA /E /S sc.exe config "%~1" start= demand
exit /B 1
:Enable_Svc_Demand_Succ
call EchoSucc Enable  service "%~1", mode "Demand"
exit /B 0

:Stop_Svc
sc.exe 2>&1 query "%~1"|findstr.exe>nul 2>nul /I "STOPPED RUNNING" || (
  if /I "%DEBUG%"=="YES" call EchoFail Stop    service "%~1" - not exist
  exit /B 2
)
                                net.exe 2>&1 stop "%~1" /Y|findstr.exe>nul 2>nul /I "успешно не" && goto Stop_Svc_Succ
psx.exe 2>nul /ACCEPTEULA /E /S net.exe 2>&1 stop "%~1" /Y|findstr.exe>nul 2>nul /I "успешно не" && goto Stop_Svc_Succ
call EchoFail Stop    service "%~1"
if /I "%DEBUG%"=="YES" psx.exe /ACCEPTEULA /E /S net.exe stop "%~1" /Y
exit /B 1
:Stop_Svc_Succ
call EchoSucc Stop    service "%~1"
exit /B 0

:Start_Svc
sc.exe 2>&1 query "%~1"|findstr.exe>nul 2>nul /I "STOPPED RUNNING" || (
  if /I "%DEBUG%"=="YES" call EchoFail Start   service "%~1" - not exist
  exit /B 2
)
                                net.exe 2>&1 start "%~1"|findstr.exe>nul 2>nul /I "успешно уже" && goto Start_Svc_Succ
psx.exe 2>nul /ACCEPTEULA /E /S net.exe 2>&1 start "%~1"|findstr.exe>nul 2>nul /I "успешно уже" && goto Start_Svc_Succ
call EchoFail Start   service "%~1"
if /I "%DEBUG%"=="YES" psx.exe /ACCEPTEULA /E /S net.exe start "%~1"
exit /B 1
:Start_Svc_Succ
call EchoSucc Start   service "%~1"
exit /B 0

:Check_Svc
sc.exe 2>&1 query "%~1"|%SystemRoot%\System32\find.exe>nul 2>nul /I "STOPPED" && (
  call EchoWarn Service "%~1" is stopped
  if /I "%DEBUG%"=="YES" sc.exe query "%~1"
  exit /B 1
)
sc.exe 2>&1 query "%~1"|%SystemRoot%\System32\find.exe>nul 2>nul /I "RUNNING" && (
  call EchoWarn Service "%~1" is started
  if /I "%DEBUG%"=="YES" sc.exe query "%~1"
  exit /B 0
)
call EchoFail Service "%~1" is not exist
if /I "%DEBUG%"=="YES" sc.exe query "%~1"
exit /B 2

:Finish
