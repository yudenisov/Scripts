@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set password policy
set USAGE=

call :Set_Password_Policy
goto Finish


:Set_Password_Policy
set DELETE_REG_ENTRY_ERROR=NO

::    Установка  минимальной  длины  пароля.  Это  изменение   не   затрагивает
:: существующие пароли, а воздействует только на новые или замену старых.  Тип:
:: REG_BINARY; Значение: любое допустимое (по умолчанию параметра нет)
call>nul DeleteRegEntry "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Network" "MinPwdLen"

::    Этот параметр определяет, будет ли Windows  требовать  алфавитно-цифровой
:: пароль, то есть пароль, созданный из комбинаций букв (А, В,  С...)  и  чисел
:: (1,2,3...) Тип: REGD_WORD;  Значение:  1 - требовать (по умолчанию параметра
:: нет)
call>nul DeleteRegEntry "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Network" "AlphanumPwds"

if /I "%DELETE_REG_ENTRY_ERROR%"=="YES" goto Set_Password_Policy_Fail

::    Интepaктивный вxoд в cиcтeму: нaпoминaть пoльзoвaтeлям oб иcтeчeнии cpoкa
:: дeйcтвия пapoля зapaнee. Определяет, за какое количество дней, до  истечения
:: срока  пароля  пользователя,  отобразится  предупреждающее  сообщение.  Тип:
:: REG_DWORD; Значение: любое допустимое (по умолчанию 14). Локальная  политика
:: безопасности > Лoкaльныe пoлитики > Пapaмeтpы бeзoпacнocти
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /V "PasswordExpiryWarning" /T REG_DWORD /D "14" /F || goto Set_Password_Policy_Fail

::   Компьютер  не  будет  менять  пароль  своей  системной  учетной   записи.
:: Соответственно, он не "вылетит" из домена, даже  если  вы  его  не  включали
:: несколько лет, или применили старый снимок состояния системы.
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" /V "DisablePasswordChange" /T REG_DWORD /D "1" /F || goto Set_Password_Policy_Fail

::    Члeн  дoмeнa:  мaкcимaльный  cpoк   дeйcтвия   пapoля   учeтныx   зaпиceй
:: кoмпьютepa. Локальная политика безопасности > Лoкaльныe пoлитики > Пapaмeтpы
:: бeзoпacнocти. Тип: REG_DWORD; Значение: 1 - 1000000 (по умолчанию 30 дней)
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" /V "MaximumPasswordAge" /T REG_DWORD /D "1000000" /F || goto Set_Password_Policy_Fail
net.exe>nul 2>nul accounts /MAXPWAGE:UNLIMITED                                                                                          || goto Set_Password_Policy_Fail
call EchoSucc Set password policy
exit /B 0
:Set_Password_Policy_Fail
call EchoFail Set password policy
if /I "%DEBUG%"=="YES" (
  reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Network" /V "MinPwdLen" /F
  reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Network" /V "AlphanumPwds" /F
  reg.exe add    "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"      /V "PasswordExpiryWarning" /T REG_DWORD /D "14"      /F
  reg.exe add    "HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters"      /V "DisablePasswordChange" /T REG_DWORD /D "1"       /F
  reg.exe add    "HKLM\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters"      /V "MaximumPasswordAge"    /T REG_DWORD /D "1000000" /F
  net.exe accounts /MAXPWAGE:UNLIMITED
)
exit /B 1

:Finish
