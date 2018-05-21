@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set LDAP BIND command request settings
set USAGE=default/sasl

if /I "%~1"=="DEFAULT" (
  call :Set_LDAP_Bind_Default
  goto Finish
)
if /I "%~1"=="SASL" (
  call :Set_LDAP_Bind_SASL
  goto Finish
)
exit /B 255


:Set_LDAP_Bind_Default
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" /V "LdapServerIntegrity" /T REG_DWORD /D "1" /F && (
  call EchoSucc Set LDAP BIND command request settings: "Default"
  exit /B 0
)
call EchoFail Set LDAP BIND command request settings: "Default"
if /I "%DEBUG%"=="YES" reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" /V "LdapServerIntegrity" /T REG_DWORD /D "1" /F
exit /B 1

:Set_LDAP_Bind_SASL
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" /V "LdapServerIntegrity" /T REG_DWORD /D "2" /F && (
  call EchoSucc Set LDAP BIND command request settings: "SASL"
  exit /B 0
)
call EchoFail Set LDAP BIND command request settings: "SASL"
if /I "%DEBUG%"=="YES" reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\NTDS\Parameters" /V "LdapServerIntegrity" /T REG_DWORD /D "2" /F
exit /B 1

:: LDAP BIND command request settings
::
::    Безопасность  сервера  каталогов   можно   существенно   повысить,   если
:: настроить его на отклонение привязок SASL (согласование, Kerberos, NTLM  или
:: выборка), которые не запрашивают подписи (проверки  целостности)  и  простых
:: привязок LDAP, которые выполняются  для  подключения  LDAP  с  открытым  (не
:: зашифрованным SSL/TLS) текстом. Даже если никто из клиентов  такие  привязки
:: не использует, настройка сервера  на  их  отклонение  улучшает  безопасность
:: сервера.
::    Сразу после установки доменных служб Active Directory  некоторые  клиенты
:: могут рассчитывать на неподписанные привязки SASL или простые привязки  LDAP
:: для подключения без SSL/TLS и могут перестать работать, если  будет  сделано
:: следующее изменение конфигурации. Чтобы помочь  найти  клиентов,  у  которых
:: появляются  такие  привязки,  сервер  каталогов  один  раз  каждые  24  часа
:: регистрирует итоговое событие, указывающее на  то,  сколько  таких  привязок
:: произошло.  Рекомендуется  настроить  такие  клиенты  так,  чтобы   они   не
:: использовали эти привязки. Как только соответствующие события с  кодом  2887
:: перестанут регистрироваться в течение достаточно  продолжительного  периода,
:: рекомендуется настроить сервер на отклонение таких привязок. По умолчанию  в
:: журнале    событий    можно    найти    ворнинги     с     событием     2886
:: "ActiveDirectory_DomainService".  Для  решения  данной  проблемы  необходимо
:: включить требования цифровой подписи для  LDAP-сервера.  Это  можно  сделать
:: двумя методами: при помощи системного реестра, а также с  помощью  групповых
:: политик.
::
:: 1. Системный реестр:
::
:: [HKEY_LOCAL_MACHINESYSTEMCurrentControlSetServicesNTDSParameters]
:: "LDAPServerIntegrity"=dword:00000001 (Default)
:: "LDAPServerIntegrity"=dword:00000002 (SASL)
::
:: 2. Групповые политики:
::
:: Параметр:
::   Конфигурация компьютера
::     Политики
::       Конфигурация Windows
::         Параметры безопасности
::           Локальные политики/Параметры безопасности
::             Контроллер домена: требование цифровой подписи для LDAP-сервера.
:: Значение параметра:
::   Нет                        - "LDAPServerIntegrity"=dword:00000001
::   Требуется цифровая подпись - "LDAPServerIntegrity"=dword:00000002

:Finish
