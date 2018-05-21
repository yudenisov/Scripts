@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable administrative shares
set USAGE=disable/enable

if /I "%~1"=="DISABLE" (
  call :Disable_Admin_Shares
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_Admin_Shares
  goto Finish
)
if /I "%~1"=="Show" (
  call :Show_Admin_Shares
  goto Finish
)
exit /B 255


:Disable_Admin_Shares
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa"                      /V "RestrictAnonymous" /T REG_DWORD /D "1" /F || goto Disable_Admin_Shares_Fail
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess"            /V "Start"             /T REG_DWORD /D "2" /F || goto Disable_Admin_Shares_Fail
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer"            /V "Start"             /T REG_DWORD /D "4" /F || goto Disable_Admin_Shares_Fail
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /V "AutoShareWks"      /T REG_DWORD /D "0" /F || goto Disable_Admin_Shares_Fail
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /V "AutoShareServer"   /T REG_DWORD /D "0" /F || goto Disable_Admin_Shares_Fail
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%~d:\System Volume Information" ^
net.exe>nul 2>nul share %%d$=%%~d:\ /Y /UNLIMITED
net.exe>nul 2>nul share ADMIN$      /Y /UNLIMITED
net.exe>nul 2>nul share IPC$        /Y /UNLIMITED
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%~d:\System Volume Information" ^
net.exe 2>&1 share %%d$   /Y /DELETE|findstr.exe>nul 2>nul /I "�ᯥ譮 success" || goto Disable_Admin_Shares_Fail
net.exe 2>&1 share ADMIN$ /Y /DELETE|findstr.exe>nul 2>nul /I "�ᯥ譮 success" || goto Disable_Admin_Shares_Fail
net.exe 2>&1 share IPC$   /Y /DELETE|findstr.exe>nul 2>nul /I "�ᯥ譮 success" || goto Disable_Admin_Shares_Fail
call EchoSucc Disable administrative shares
exit /B 0
:Disable_Admin_Shares_Fail
call EchoFail Disable administrative shares
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa"                      /V "RestrictAnonymous" /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess"            /V "Start"             /T REG_DWORD /D "2" /F
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer"            /V "Start"             /T REG_DWORD /D "4" /F
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /V "AutoShareWks"      /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /V "AutoShareServer"   /T REG_DWORD /D "0" /F
  for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%~d:\System Volume Information" net.exe share %%d$ /Y /DELETE
  net.exe share ADMIN$ /Y /DELETE
  net.exe share IPC$   /Y /DELETE
)
exit /B 1

:Enable_Admin_Shares
call   >nul 2>nul Svc Start "LanmanServer"                                                                                           || goto Enable_Admin_Shares_Fail
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa"                      /V "RestrictAnonymous" /T REG_DWORD /D "0" /F || goto Enable_Admin_Shares_Fail
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess"            /V "Start"             /T REG_DWORD /D "4" /F || goto Enable_Admin_Shares_Fail
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer"            /V "Start"             /T REG_DWORD /D "2" /F || goto Enable_Admin_Shares_Fail
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /V "AutoShareWks"      /T REG_DWORD /D "1" /F || goto Enable_Admin_Shares_Fail
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /V "AutoShareServer"   /T REG_DWORD /D "1" /F || goto Enable_Admin_Shares_Fail
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%~d:\System Volume Information" ^
net.exe>nul 2>nul share %%d$   /Y /DELETE
net.exe>nul 2>nul share ADMIN$ /Y /DELETE
net.exe>nul 2>nul share IPC$   /Y /DELETE
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%~d:\System Volume Information" ^
net.exe 2>&1 share %%d$=%%~d:\ /Y /UNLIMITED|findstr.exe>nul 2>nul /I "�ᯥ譮 success" || goto Enable_Admin_Shares_Fail
net.exe 2>&1 share ADMIN$      /Y /UNLIMITED|findstr.exe>nul 2>nul /I "�ᯥ譮 success" || goto Enable_Admin_Shares_Fail
net.exe 2>&1 share IPC$        /Y /UNLIMITED|findstr.exe>nul 2>nul /I "�ᯥ譮 success" || goto Enable_Admin_Shares_Fail
call EchoSucc Enable administrative shares
exit /B 0
:Enable_Admin_Shares_Fail
call EchoFail Enable administrative shares
if /I "%DEBUG%"=="YES" (
  call Svc Start "LanmanServer"
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa"                      /V "RestrictAnonymous" /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\SharedAccess"            /V "Start"             /T REG_DWORD /D "4" /F
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer"            /V "Start"             /T REG_DWORD /D "2" /F
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /V "AutoShareWks"      /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /V "AutoShareServer"   /T REG_DWORD /D "1" /F
  for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do if exist "%%~d:\System Volume Information" net.exe share %%d$=%%~d:\ /Y /UNLIMITED
  net.exe share ADMIN$ /Y /UNLIMITED
  net.exe share IPC$   /Y /UNLIMITED
)
exit /B 1

:Show_Admin_Shares
net.exe 2>nul share|%SystemRoot%\System32\find.exe "$"
exit /B

:Finish
