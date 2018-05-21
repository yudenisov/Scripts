@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable LSASS protection from third-party modules
set USAGE=disable/enable

if /I "%~1"=="DISABLE" (
  call :Disable_LSASS_Protection
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_LSASS_Protection
  goto Finish
)
exit /B 255


:Disable_LSASS_Protection
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /V "RunAsPPL" /T REG_DWORD /D "0" /F || goto Disable_LSASS_Protection_Fail
call EchoSucc Disable LSASS protection from third-party modules
exit /B 0
:Disable_LSASS_Protection_Fail
call EchoFail Disable LSASS protection from third-party modules
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /V "RunAsPPL" /T REG_DWORD /D "0" /F
)
exit /B 1

:Enable_LSASS_Protection
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /V "RunAsPPL" /T REG_DWORD /D "1" /F || goto Enable_LSASS_Protection_Fail
call EchoSucc Enable LSASS protection from third-party modules
exit /B 0
:Enable_LSASS_Protection_Fail
call EchoFail Enable LSASS protection from third-party modules
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /V "RunAsPPL" /T REG_DWORD /D "1" /F
)
exit /B 1

:Finish

:: https://www.atraining.ru/mimikatz-lsa-protection/
::
::   Начиная с Windows 8.1 и Windows Server 2012 R2,  появляется  дополнительная
:: возможность для защиты. Эта защита реализуется как  специальный  параметр  для
:: сервиса LSASS - если включаясь LSASS увидит этот параметр, то будет  разрешать
:: прямое взаимодействие с  собой  (например,  чтение  своей  памяти)  не  просто
:: процессам с нужным уровнем доступа (работающим от системной  учётной  записи),
:: но и обязательно подписанным со стороны Microsoft. Не  просто  подписанным,  а
:: как у криптографических модулей – специальной подписью вендора.
::
::    Включается     этот     режим     просто     –     в     ветке      реестра
:: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa   создаётся   значение
:: RunAsPPL типа DWORD32 и выставляется в 1.
::
::    При успешной обработке в журнале System от лица WinInit будет событие:
::    LSASS.exe was started as a protected process with level: 4
::
::    Работая  в  защищённом  режиме  LSASS  не  будет  подгружать  неподписанные
:: плагины. Если у  вас  они  и  не  используются,  то  это  эффективно  отключит
:: принципиальную  возможность  даже  получив  права  LocalSystem  добраться   до
:: оперативной  памяти  процесса  LSA.  Но  будьте  внимательны,   если   у   вас
:: используются:
::
::    - Самописные фильтры паролей  -  например,  для  задания  особых  критериев
:: сложности и проверки “чтобы в паролях не встречались логины и имена”;
::    - Криптомодули, нужные для обработки  какой-то  специфичной  авторизации  –
:: например, Kerberos на гос.криптографии;
::    - Сторонние   драйверы   смарт-карт,   добавляющие   какой-то   специфичный
:: функционал;
::
::    Всем им после включения этого режима надо быть или подписанными  Microsoft,
:: или они не будут загружаться, а в логах будут события 3033 и 3036.
::
::    Впрочем, чаще всего расширения LSA не используются,  так  что  данная  мера
:: является нужной и эффективной. Но действовать она, ещё  раз,  будет  только  у
:: 8.1+ и 2012 R2+.
