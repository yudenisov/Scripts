@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Check on member of domain
set USAGE=

call :Check_Member_Of_Domain
goto Finish


:Check_Member_Of_Domain
if /I "%CHECK_MEMBER_OF_DOMAIN%"=="YES" goto Check_Member_Of_Domain_Succ
if /I "%CHECK_MEMBER_OF_DOMAIN%"=="NO"  goto Check_Member_Of_Domain_Fail
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /V "Domain"') do if /I "%%i"=="Domain" if not "%%k"=="" goto Check_Member_Of_Domain_Succ
:Check_Member_Of_Domain_Fail
set CHECK_MEMBER_OF_DOMAIN=NO
call EchoWarn It is not member of domain
if /I "%DEBUG%"=="YES" reg.exe query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /V "Domain"
exit /B 1
:Check_Member_Of_Domain_Succ
set CHECK_MEMBER_OF_DOMAIN=YES
call EchoWarn It is member of domain
if /I "%DEBUG%"=="YES" reg.exe query "HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" /V "Domain"
exit /B 0

:: http://technet.microsoft.com/ru-ru/library/aa998420%28v=exchg.80%29.aspx
::
::    Параметр "NV Domain" реестра содержит  основной  DNS-суффикс  компьютера.
:: Параметр  "Domain"  реестра  содержит  основной  DNS-домен  компьютера.   По
:: умолчанию  основная  часть  DNS-суффикса  полного  доменного  имени   (FQDN)
:: компьютера  должна  совпадать  с  именем  домена  службы  каталогов   Active
:: Directory,  в  котором  находится  компьютер.  Несовпадающие   имена   могут
:: воспрепятствовать  правильному  выполнению  DNS-регистрации.  Если   DNS-имя
:: компьютера не совпадает  с  именем  домена  Active  Directory,  можно  будет
:: наблюдать сообщения об ошибках в системном журнале ошибок компьютера  каждые
:: 22 минуты. Такая ситуация известна как раздельное пространство имен.

:Finish
