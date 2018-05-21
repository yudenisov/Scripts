@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable WDigest caching
set USAGE=disable/enable

if /I "%~1"=="DISABLE" (
  call :Disable_WDigest_Caching
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_WDigest_Caching
  goto Finish
)
exit /B 255


:Disable_WDigest_Caching
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" /V "UseLogonCredential" /T REG_DWORD /D "0" /F || goto Disable_WDigest_Caching_Fail
call EchoSucc Disable WDigest caching
exit /B 0
:Disable_WDigest_Caching_Fail
call EchoFail Disable WDigest caching
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" /V "UseLogonCredential" /T REG_DWORD /D "0" /F
)
exit /B 1

:Enable_WDigest_Caching
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" /V "UseLogonCredential" /T REG_DWORD /D "1" /F || goto Enable_WDigest_Caching_Fail
call EchoSucc Enable WDigest caching
exit /B 0
:Enable_WDigest_Caching_Fail
call EchoFail Enable WDigest caching
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest" /V "UseLogonCredential" /T REG_DWORD /D "1" /F
)
exit /B 1

:Finish

:: https://www.atraining.ru/mimikatz-lsa-protection/
::
::    ≈сли вы не используете  дайджест-аутентификацию,  то  можно  в  €вном  виде
:: сказать системе, чтобы она не занималась ерундой по части генерации и хранени€
:: оных.
::    ¬ современных системах Ц Windows 8.1+ и Windows Server 2012 R2+ Ц  это  уже
:: работает  само  по  себе,  а  вот  в  предыдущих  верси€х   надо   предприн€ть
:: определЄнные действи€ Ц добавить в ключ реестра HKLM\SYSTEM\CurrentControlSet\
:: Control\SecurityProviders\WDigest значение UseLogonCredential типа  DWORD32  и
:: выставить его в нуль.
::    ≈сли даже дайджест иногда и будет требоватьс€,  то  просто  у  пользовател€
:: будет чаще запрашиватьс€ информаци€ дл€ логина  Ц  то  есть  данна€  настройка
:: отключает именно кэширование в RAM, а не весь механизм  digest.  HTTP-ресурсы,
:: которым нужен именно такой метод, продолжат быть доступны.
::    ≈сли вы опасаетесь, что  есть  нека€  система,  провод€ща€  аутентификацию,
:: последовательно согласовыва€ методы, и эта система может так Удосогласоватьс€Ф
:: до WDigest Ц то в том же ключе реестра HKLM\SYSTEM\CurrentControlSet\Control\
:: SecurityProviders\WDigest есть значение Negotiate, тоже DWORD32, которое можно
:: €вно выставить в 0 и тогда никакие вариации Negotiate не  будут  при  переборе
:: методов  использовать WDigest.
