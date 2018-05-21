@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set time synchronization from DC
set USAGE=

call :Set_Time_Sync_From_DC
goto Finish


:Set_Time_Sync_From_DC
w32tm.exe 2>&1 /config /update /syncfromflags:DOMHIER|%SystemRoot%\System32\find.exe>nul 2>nul /I "выполнена успешно" && (
  call EchoSucc Set time sync from DC
  exit /B 0
)
call EchoFail Set time sync from DC
if /I "%DEBUG%"=="YES" w32tm.exe /config /update /syncfromflags:DOMHIER
exit /B 1

:: :Set_Time_Sync_From_DC
:: if "%~1"=="" exit /B 255
:: net.exe stop  "w32time" /Y
:: reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config"                  /V "AnnounceFlags" /T REG_DWORD /D "10"    /F
:: reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters"              /V "Type"          /T REG_SZ    /D "NT5DS" /F
:: reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters"              /V "NtpServer"     /T REG_SZ    /D "%~1"   /F
:: reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpServer" /V "Enabled"       /T REG_DWORD /D "1"     /F
:: net.exe start "w32time"
:: exit /B

:: Существует несколько вариантов работы службы SNTP, входящей в Windows:
::  - Иерархическая (NT5DS). Используется по умолчанию для всех компьютеров,
:: объединенных в домен. Синхронизация времени на рабочих станциях и серверах
:: домена производится по иерархии. Таким образом, рабочие станции и рядовые
:: серверы синхронизируются с контроллером домена, аутентифицировавшим вход,
:: контроллеры домена - с хозяином операции <эмулятор PDC>, который в свою
:: очередь синхронизируется с контроллером домена, стоящим на более высоком
:: уровне иерархии. Следует заметить, что данный порядок синхронизации
:: используется <по умолчанию> и может быть переопределен вручную или с
:: использованием групповых политик.
::  - Принудительная синхронизация с выбранным NTP-сервером (NTP). В данном
:: случае источник эталонного времени для службы Windows Time устанавливается
:: либо вручную, либо с помощью групповых политик.
::  - Отключение синхронизации (NoSync). Этот режим необходим для смешанной
:: схемы поддержания времени, в которой для синхронизации с внешним источником
:: используется продукт третьей фирмы, а для поддержания времени в рамках
:: домена используется Windows Time.
::
:: Настройки службы Windows Time хранятся в реестре Windows в разделе
:: "HKLM\SYSTEM\CurrentControlSet\Services\W32Time".
:: В корне раздела определяются параметры работы самой службы, в подключе
:: Config - настройки, связанные с работой самого протокола SNTP.
:: Режим синхронизации определяется в подключе Parameters. Настройки
:: SNTP-клиента и сервера находятся в подключах TimeProviders\NtpClient и
:: TimeProviders\NtpServer соответственно. Рассмотрим основные значения,
:: определяющие настройку NTP клиента и сервера:
::  - Type - определяет режим работы NTP-клиента:
::    - NTDS5   - иерархическая;
::    - NTP     - вручную;
::    - NoSync  - не синхронизировать;
::    - AllSync - доступны все типы синхронизации.
::  - Enabled - определяет, включен ли данный компонент (клиент или сервер);
::  - CrossSiteSyncFlags - определяет, можно ли синхронизировать время с
:: источником, находящимся за пределами домена, в случае если используется
:: иерархическая синхронизация:
::    - 0 - нельзя;
::    - 1 - только с эмулятором PDC;
::    - 2 - со всеми.
::  - EventLogFlags - определяет, будут ли сообщения от Windows Time заносится
:: в журнал или нет.

:Finish
