@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable autorun on removable drives
set USAGE=

call :Disable_Autorun_Drives
goto Finish


:Disable_Autorun_Drives
reg.exe>nul 2>nul add    "HKLM\SYSTEM\CurrentControlSet\Services\Cdrom"                                                  /V "AutoRun"            /T REG_DWORD /D "0"    /F || goto Disable_Autorun_Drives_Fail
reg.exe>nul 2>nul add    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"                              /V "NoDriveTypeAutoRun" /T REG_DWORD /D "0xDD" /F || goto Disable_Autorun_Drives_Fail
reg.exe>nul 2>nul add    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\CancelAutoplay\Files" /V "*.*"                /T REG_SZ    /D ""     /F || goto Disable_Autorun_Drives_Fail
reg.exe>nul 2>nul delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\IniFileMapping\Autorun.inf"                                                                 /F

call EchoSucc Disable autorun on removable drives
exit /B 0
:Disable_Autorun_Drives_Fail
call EchoFail Disable autorun on removable drives
if /I "%DEBUG%"=="YES" (
  reg.exe add    "HKLM\SYSTEM\CurrentControlSet\Services\Cdrom"                                                  /V "AutoRun"            /T REG_DWORD /D "0"    /F
  reg.exe add    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"                              /V "NoDriveTypeAutoRun" /T REG_DWORD /D "0xDD" /F
  reg.exe add    "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\CancelAutoplay\Files" /V "*.*"                /T REG_SZ    /D ""     /F
  reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\IniFileMapping\Autorun.inf"                                                                 /F
)
exit /B 1

:: Services\Cdrom - полное отключение всякой поддержки автозапуска
:: компакт-дисков (даже ручного).

:: С помощью NoDriveAutoRun запрещается загрузка с определенных приводов по их
:: буквенному обозначению, а NoDriveTypeAutoRun запрещает загрузку с
:: определенных приводов по их типу. Поскольку нам авторан вообще не нужен,
:: используем второе.
:: Значения параметра "NoDriveTypeAutoRun":
::   0xFF - отключить для всех дисков.
::   0xDD - отключить для всех дисков, кроме CD/DVD.

:: В CancelAutoplay\Files находятся текстовые параметры, содержащие имена
:: файлов, отыскав которые на носителе встроенный AutoRun запускаться не станет
:: и позволит запустить носитель через autorun.inf. Добавляем строковый
:: параметр следующего содержания: *.* (все файлы).

:: !!! ВНИМАНИЕ !!! Способ, рекомендуемый Интернетом для отключения автозапуска
:: (указан ниже), приводит к проблемам с установкой дополнительного ПО к
:: сканеру HP ScanJet 300.
::
:: http://ru.wikipedia.org/wiki/Autorun.inf
:: Альтернативный, более радикальный, способ запрета обработки autorun.inf:
::
:: reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\IniFileMapping\Autorun.inf" /VE /T REG_SZ /D "@SYS:DoesNotExist" /F
::
:: По сути он подменяет содержимое файла autorun.inf значением из реестра,
:: которое нарочно задаётся пустым/неверным. Это приводит к тому, что если на
:: диске и есть файл autorun.inf, то он воспринимается как пустой.
:: Указанный способ следует считать самым надёжным.
::
:: @SYS:DoesNotExist говорит Explorer'у, чтобы он не читал параметры запуска из
:: файла Autorun.inf, а читал их из ветки реестра HKLM\SOFTWARE\DoesNotExist,
:: которая не существует. В итоге если внешний носитель содержит файл
:: Autorun.inf - то при подключении носителя к компьютеру, Autorun.inf не
:: запускается. Более того - не запускается он и при двойном клике по букве
:: диска этого носителя в проводнике.

:Finish
