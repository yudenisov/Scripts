@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set time special poll interval
set USAGE=seconds

call :Set_Time_Special_Poll_Interval "%~1"
exit /B 255


:Set_Time_Special_Poll_Interval
if "%~1"=="" exit /B 255
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient" /V "SpecialPollInterval" /T REG_DWORD /D "%~1" /F || goto Set_Time_Special_Poll_Interval_Fail
call EchoSucc Set time special poll interval: "%~1"
exit /B 0
:Set_Time_Special_Poll_Interval_Fail
call EchoFail Set time special poll interval: "%~1"
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient" /V "SpecialPollInterval" /T REG_DWORD /D "%~1" /F
)
exit /B 1

:: —писок источников W32Time настраиваетс€ через параметр реестра
:: HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters\NtpServer
:: ќн содержит список серверов времени, раздел€емых пробелами.  аждый сервер
:: может иметь установленные шестнадцатеричные значени€ флагов, указываемые
:: через зап€тую после сервера. —уществует 4 возможных значений флагов:
::   0x01 SpecialInterval
::   0x02 UseAsFallbackOnly
::   0x04 SymmatricActive
::   0x08 Client
::
:: ѕри использовании флага SpecialInterval, используетс€ параметр реестра
:: HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient\
:: SpecialPollInterval - интервал синхронизации времени в секундах.
:: ѕо умолчанию он равен 7 дн€м (604800 сек). ѕри такой настройке часы могут
:: иметь погрешность до нескольких минут. –екомендую уменьшить интервал
:: синхронизации до 6 часов (21600 сек). Ёто изменение не увеличит ни трафика,
:: ни нагрузки на NTP-сервера, и при этом позволит поддерживать более высокую
:: точность хода часов вашего компьютера.
::
:: ѕри значении флага UseAsFallbackOnly службе времени сообщаетс€, что данный
:: сервер будет использоватьс€ как резервный и перед синхронизацией с ним
:: будут выполн€тс€ обращени€ к другим серверам списка.
::
:: ѕосле внесени€ необходимых настроек в можно перечитать конфигурацию
:: сохраненную в реестре командой: w32tm /config /update. » при необходимости
:: выполнить немедленную синхронизацию: w32tm /resync.

:Finish
