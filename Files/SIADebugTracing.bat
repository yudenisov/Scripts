@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable Debug Tracing for MS Online Services Sign-In Assistant
set USAGE=disable/enable

if /I "%~1"=="DISABLE" (
  call :Disable_SIADebugTracing
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_SIADebugTracing
  goto Finish
)
exit /B 255


:Disable_SIADebugTracing
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\MSOIdentityCRL\Trace"             /V "Flags" /T REG_DWORD /D "0" /F || goto Disable_SIADebugTracing_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\MSOIdentityCRL\Trace"             /V "level" /T REG_DWORD /D "0" /F || goto Disable_SIADebugTracing_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Wow6432Node\Microsoft\MSOIdentityCRL\Trace" /V "Flags" /T REG_DWORD /D "0" /F || goto Disable_SIADebugTracing_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Wow6432Node\Microsoft\MSOIdentityCRL\Trace" /V "level" /T REG_DWORD /D "0" /F || goto Disable_SIADebugTracing_Fail
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\MSOIdentityCRL\Trace"           /V "Flags" /T REG_DWORD /D "0" /F || goto Disable_SIADebugTracing_Fail
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\MSOIdentityCRL\Trace"           /V "level" /T REG_DWORD /D "0" /F || goto Disable_SIADebugTracing_Fail
)
call EchoSucc Disable Debug Tracing for MS Online Services Sign-In Assistant
exit /B 0
:Disable_SIADebugTracing_Fail
call EchoFail Disable Debug Tracing for MS Online Services Sign-In Assistant
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SOFTWARE\Microsoft\MSOIdentityCRL\Trace"             /V "Flags" /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\MSOIdentityCRL\Trace"             /V "level" /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\MSOIdentityCRL\Trace" /V "Flags" /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\MSOIdentityCRL\Trace" /V "level" /T REG_DWORD /D "0" /F
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
    reg.exe add "%%~i\Software\Microsoft\MSOIdentityCRL\Trace"           /V "Flags" /T REG_DWORD /D "0" /F
    reg.exe add "%%~i\Software\Microsoft\MSOIdentityCRL\Trace"           /V "level" /T REG_DWORD /D "0" /F
  )
)
exit /B 1

:Enable_SIADebugTracing
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\MSOIdentityCRL\Trace"             /V "Flags" /T REG_DWORD /D "1" /F || goto Enable_SIADebugTracing_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\MSOIdentityCRL\Trace"             /V "level" /T REG_DWORD /D "2" /F || goto Enable_SIADebugTracing_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Wow6432Node\Microsoft\MSOIdentityCRL\Trace" /V "Flags" /T REG_DWORD /D "1" /F || goto Enable_SIADebugTracing_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Wow6432Node\Microsoft\MSOIdentityCRL\Trace" /V "level" /T REG_DWORD /D "2" /F || goto Enable_SIADebugTracing_Fail
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\MSOIdentityCRL\Trace"           /V "Flags" /T REG_DWORD /D "1" /F || goto Enable_SIADebugTracing_Fail
  reg.exe>nul 2>nul add "%%~i\Software\Microsoft\MSOIdentityCRL\Trace"           /V "level" /T REG_DWORD /D "2" /F || goto Enable_SIADebugTracing_Fail
)
call EchoSucc Enable  Debug Tracing for MS Online Services Sign-In Assistant
exit /B 0
:Enable_SIADebugTracing_Fail
call EchoFail Enable  Debug Tracing for MS Online Services Sign-In Assistant
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SOFTWARE\Microsoft\MSOIdentityCRL\Trace"             /V "Flags" /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\MSOIdentityCRL\Trace"             /V "level" /T REG_DWORD /D "2" /F
  reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\MSOIdentityCRL\Trace" /V "Flags" /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\MSOIdentityCRL\Trace" /V "level" /T REG_DWORD /D "2" /F
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
    reg.exe add "%%~i\Software\Microsoft\MSOIdentityCRL\Trace"           /V "Flags" /T REG_DWORD /D "1" /F
    reg.exe add "%%~i\Software\Microsoft\MSOIdentityCRL\Trace"           /V "level" /T REG_DWORD /D "2" /F
  )
)
exit /B 1

:Finish

:: http://social.technet.microsoft.com/wiki/contents/articles/18103.microsoft-online-services-sign-in-assistant-how-to-enable-debug-tracing.aspx
::
:: The Microsoft Online Services Sign-In Assistant service is utilized for
:: several of Microsoft's Online Services products, such as:
::  - Windows Azure Active Directory PowerShell Module
::  - Windows Azure Active Directory Synchronization
::  - Lync clients connecting to Lync Online in Office 365
:: In order to troubleshoot possible authentication issues experienced with any
:: of the Microsoft Online Services that utilize the Microsoft Online Services
:: Sign-In Assistant, you may be required to enable debug tracing for Microsoft
:: Online Services Sign-In Assistant.
::
:: После отключения можно удалить файлы:
::   C:\Users\*\AppData\Local\Microsoft\MSOIdentityCRL\Tracing\*.txt
