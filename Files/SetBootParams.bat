@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set boot parameters
set USAGE=

call :Set_Boot_Params
goto Finish


:Set_Boot_Params
:: Задаём количество резервных копий, которые будет хранить система.
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager"               /V "BackupCount" /T REG_DWORD /D "2" /F
:: Включаем пункт "Загрузка последней удачной конфигурации" в диспетчере загрузки.
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager\LastKnownGood" /V "Enabled"     /T REG_DWORD /D "1" /F
:: Возвращаем старый диспетчер загрузки в Windows 8, вызываемый по F8 (дополнительные варианты загрузки).
bcdedit.exe>nul 2>nul /SET "{current}" BootMenuPolicy Legacy
:: Выключаем загрузочное меню в Windows (выбор ОС при загрузке).
bcdedit.exe>nul 2>nul /SET "{bootmgr}" DisplayBootMenu No || goto Set_Boot_Params_Fail
call EchoSucc Set boot parameters
exit /B 0
:Set_Boot_Params_Fail
call EchoFail Set boot parameters
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager"               /V "BackupCount" /T REG_DWORD /D "2" /F
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager\LastKnownGood" /V "Enabled"     /T REG_DWORD /D "1" /F
  bcdedit.exe /SET "{current}" BootMenuPolicy Legacy
  bcdedit.exe /SET "{bootmgr}" DisplayBootMenu No
)
exit /B 1

:Finish
