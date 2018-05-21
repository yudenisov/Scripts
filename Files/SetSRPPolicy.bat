@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set software restriction policy
set USAGE=unrestricted/basicuser/disallowed/disable/log/nolog

if /I "%~1"=="UNRESTRICTED" (
  call :SRP_Unrestricted
  goto Finish
)
if /I "%~1"=="BASICUSER" (
  call :SRP_BasicUser
  goto Finish
)
if /I "%~1"=="DISALLOWED" (
  call :SRP_Disallowed
  goto Finish
)
if /I "%~1"=="DISABLE" (
  call :SRP_Disable
  goto Finish
)
if /I "%~1"=="LOG" (
  call :SRP_Log
  goto Finish
)
if /I "%~1"=="NOLOG" (
  call :SRP_NoLog
  goto Finish
)
exit /B 255


:SRP_Unrestricted
:: Включаем уровень политики в Unrestricted (для Windows Vista/Windows Server 2008)
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "DefaultLevel"        /T REG_DWORD /D "0x00040000" /F || goto SRP_Unrestricted_Fail
:: Выводим администраторов из-под действия политики (для Windows Vista/Windows Server 2008)
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "PolicyScope"         /T REG_DWORD /D "0x00000001" /F || goto SRP_Unrestricted_Fail
:: Включаем уровень политики в Unrestricted (для Windows XP /Windows Server 2003)
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "AuthenticodeEnabled" /T REG_DWORD /D "0x00000001" /F || goto SRP_Unrestricted_Fail
call EchoSucc Set software restriction policy to "Unrestricted"
exit /B 0
:SRP_Unrestricted_Fail
call EchoFail Set software restriction policy to "Unrestricted"
if /I "%DEBUG%"=="YES" (
  :: Включаем уровень политики в Unrestricted (для Windows Vista/Windows Server 2008)
  reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "DefaultLevel"        /T REG_DWORD /D "0x00040000" /F
  :: Выводим администраторов из-под действия политики (для Windows Vista/Windows Server 2008)
  reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "PolicyScope"         /T REG_DWORD /D "0x00000001" /F
  :: Включаем уровень политики в Unrestricted (для Windows XP /Windows Server 2003)
  reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "AuthenticodeEnabled" /T REG_DWORD /D "0x00000001" /F
)
exit /B 1

:SRP_BasicUser
:: Включаем уровень политики в Basic User (для Windows Vista/Windows Server 2008)
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "DefaultLevel"        /T REG_DWORD /D "0x00020000" /F || goto SRP_BasicUser_Fail
:: Выводим администраторов из-под действия политики (для Windows Vista/Windows Server 2008)
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "PolicyScope"         /T REG_DWORD /D "0x00000001" /F || goto SRP_BasicUser_Fail
:: Включаем уровень политики в Basic User (для Windows XP /Windows Server 2003)
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "AuthenticodeEnabled" /T REG_DWORD /D "0x00000001" /F || goto SRP_BasicUser_Fail
call EchoSucc Set software restriction policy to "Basic User"
exit /B 0
:SRP_BasicUser_Fail
call EchoFail Set software restriction policy to "Basic User"
if /I "%DEBUG%"=="YES" (
  :: Включаем уровень политики в Basic User (для Windows Vista/Windows Server 2008)
  reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "DefaultLevel"        /T REG_DWORD /D "0x00020000" /F
  :: Выводим администраторов из-под действия политики (для Windows Vista/Windows Server 2008)
  reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "PolicyScope"         /T REG_DWORD /D "0x00000001" /F
  :: Включаем уровень политики в Basic User (для Windows XP /Windows Server 2003)
  reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "AuthenticodeEnabled" /T REG_DWORD /D "0x00000001" /F
)
exit /B 1

:SRP_Disallowed
:: Включаем уровень политики в Disallowed (для Windows Vista/Windows Server 2008)
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "DefaultLevel"        /T REG_DWORD /D "0x00000000" /F || goto SRP_Disallowed_Fail
:: Выводим администраторов из-под действия политики (для Windows Vista/Windows Server 2008)
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "PolicyScope"         /T REG_DWORD /D "0x00000001" /F || goto SRP_Disallowed_Fail
:: Включаем уровень политики в Disallowed (для Windows XP /Windows Server 2003)
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "AuthenticodeEnabled" /T REG_DWORD /D "0x00000001" /F || goto SRP_Disallowed_Fail
call EchoSucc Set software restriction policy to "Disallowed"
exit /B 0
:SRP_Disallowed_Fail
call EchoFail Set software restriction policy to "Disallowed"
if /I "%DEBUG%"=="YES" (
  :: Включаем уровень политики в Disallowed (для Windows Vista/Windows Server 2008)
  reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "DefaultLevel"        /T REG_DWORD /D "0x00000000" /F
  :: Выводим администраторов из-под действия политики (для Windows Vista/Windows Server 2008)
  reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "PolicyScope"         /T REG_DWORD /D "0x00000001" /F
  :: Включаем уровень политики в Disallowed (для Windows XP /Windows Server 2003)
  reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "AuthenticodeEnabled" /T REG_DWORD /D "0x00000001" /F
)
exit /B 1

:SRP_Disable
:: Выключаем SRP
reg.exe>nul 2>nul delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers"                                                       /F || goto SRP_Disable_Fail
reg.exe>nul 2>nul delete "HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\Disallowed\Certificates"                                          /F || goto SRP_Disable_Fail
reg.exe>nul 2>nul delete "HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\TrustedPublisher\Certificates"                                    /F || goto SRP_Disable_Fail
:: Включаем уровень политики в Unrestricted (для Windows Vista/Windows Server 2008)
reg.exe>nul 2>nul add    "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "DefaultLevel"        /T REG_DWORD /D "0x00040000" /F || goto SRP_Disable_Fail
:: Выводим администраторов из-под действия политики (для Windows Vista/Windows Server 2008)
reg.exe>nul 2>nul add    "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "PolicyScope"         /T REG_DWORD /D "0x00000001" /F || goto SRP_Disable_Fail
:: Включаем уровень политики в Unrestricted (для Windows XP /Windows Server 2003)
reg.exe>nul 2>nul add    "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "AuthenticodeEnabled" /T REG_DWORD /D "0x00000001" /F || goto SRP_Disable_Fail
call EchoSucc Set software restriction policy to "Disable"
exit /B 0
:SRP_Disable_Fail
call EchoFail Set software restriction policy to "Disable"
if /I "%DEBUG%"=="YES" (
  :: Выключаем SRP
  reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers"                    /F
  reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\Disallowed\Certificates"       /F
  reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\SystemCertificates\TrustedPublisher\Certificates" /F
  :: Включаем уровень политики в Unrestricted (для Windows Vista/Windows Server 2008)
  reg.exe add    "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "DefaultLevel"        /T REG_DWORD /D "0x00040000" /F
  :: Выводим администраторов из-под действия политики (для Windows Vista/Windows Server 2008)
  reg.exe add    "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "PolicyScope"         /T REG_DWORD /D "0x00000001" /F
  :: Включаем уровень политики в Unrestricted (для Windows XP /Windows Server 2003)
  reg.exe add    "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "AuthenticodeEnabled" /T REG_DWORD /D "0x00000001" /F
)
exit /B 1

:SRP_Log
:: Включаем запись в лог SRP-событий
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "LogFileName" /T REG_SZ /D "C:\\srp.log" /F || goto SRP_Log_Fail
call EchoSucc Enable software restriction policy log to "C:\srp.log"
exit /B 0
:SRP_Log_Fail
call EchoFail Enable software restriction policy log to "C:\srp.log"
if /I "%DEBUG%"=="YES" (
  :: Включаем запись в лог SRP-событий
  reg.exe add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "LogFileName" /T REG_SZ /D "C:\\srp.log" /F
)
exit /B 1

:SRP_NoLog
:: Отключаем запись в лог SRP-событий
reg.exe>nul 2>nul delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "LogFileName" /F || goto SRP_NoLog_Fail
call EchoSucc Disable software restriction policy log
exit /B 0
:SRP_NoLog_Fail
call EchoFail Disable software restriction policy log
if /I "%DEBUG%"=="YES" (
  :: Отключаем запись в лог SRP-событий
  reg.exe delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Safer\CodeIdentifiers" /V "LogFileName" /F
)
exit /B 1

:Finish

:: Существуют несколько режимов работы SRP:
:: - Disallowed: режим «белого списка». По умолчанию, запрещён запуск любых
:: программ, кроме описанных в правилах политики;
:: - Basic User: режим принудительного ограничения привилегий. Все программы
:: запускаются с привилегиями рядового пользователя, кроме исключений,
:: описанных политикой;
:: - Unrestricted: режим «чёрного списка». По умолчанию, разрешается запускать
:: любые программы, кроме отдельно заблокированных в правилах политики.
