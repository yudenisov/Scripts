@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set time max phase correction
set USAGE=fordc/always

if /I "%~1"=="FORDC"  call :Set_Time_Max_Phase_Correction 0x0002A300
if /I "%~1"=="ALWAYS" call :Set_Time_Max_Phase_Correction 0xFFFFFFFF
exit /B 255


:Set_Time_Max_Phase_Correction
if "%~1"=="" exit /B 255
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config" /V "MaxNegPhaseCorrection" /T REG_DWORD /D "%~1" /F || goto Set_Time_Max_Phase_Correction_Fail
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config" /V "MaxPosPhaseCorrection" /T REG_DWORD /D "%~1" /F || goto Set_Time_Max_Phase_Correction_Fail
call EchoSucc Set time max phase correction: "%~1"
exit /B 0
:Set_Time_Max_Phase_Correction_Fail
call EchoFail Set time max phase correction: "%~1"
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config" /V "MaxNegPhaseCorrection" /T REG_DWORD /D "%~1" /F
  reg.exe add "HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config" /V "MaxPosPhaseCorrection" /T REG_DWORD /D "%~1" /F
)
exit /B 1

:: «адаем максимальную величину отрицательной/положительной коррекции времени
:: (в секундах), которую может выполнить служба времени. ≈сли окажетс€, что
:: величина изменени€ превышает допустимое значение, то изменение выполн€тьс€
:: не будет, и будет зарегистрировано соответствующее событие. ≈сли данный
:: параметр равен 0xFFFFFFFF, то изменение времени будет выполн€тьс€ всегда.
:: ѕо умолчанию дл€ компьютеров-членов домена используетс€ значение 0xFFFFFFFF.
:: ƒл€ изолированных компьютеров и серверов по умолчанию используетс€ значение
:: 0x0000D2F0 (15 часов). ƒл€ контроллеров домена - 0x0002A300 (48 часов).

:Finish
