@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable visibility in a network neighborhood
set USAGE=disable/enable

if /I "%~1"=="DISABLE" (
  call :Disable_Net_Visibility
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_Net_Visibility
  goto Finish
)
exit /B 255


:Disable_Net_Visibility
net.exe 2>&1 config server /HIDDEN:YES|%SystemRoot%\System32\find.exe>nul 2>nul /I "выполнена успешно" && (
  call EchoSucc Disable visibility in a network neighborhood
  exit /B 0
)
call EchoFail Disable visibility in a network neighborhood
if /I "%DEBUG%"=="YES" net.exe config server /HIDDEN:YES
exit /B 1

:Enable_Net_Visibility
net.exe 2>&1 config server /HIDDEN:NO|%SystemRoot%\System32\find.exe>nul 2>nul /I "выполнена успешно" && (
  call EchoSucc Enable visibility in a network neighborhood
  exit /B 0
)
call EchoFail Enable visibility in a network neighborhood
if /I "%DEBUG%"=="YES" net.exe config server /HIDDEN:NO
exit /B 1

::    Вы можете скрыть машину, чтобы она не  попала  в  списки  ресурсов  сети,
:: набрав следующую команду в командной строке: net config server /hidden:yes
::    Эта команда устанавливает в реестре ключ HKEY_LOCAL_MACHINE\SYSTEM\
:: CurrentControlSet\Services\Lanman-Server\Parameters\Hidden в 1.
::    К машине будут  обращаться  как  к  сетевому  серверу,  но  пользователям
:: придется вручную ввести имена и пути к серверу и его совместно  используемым
:: ресурсам в формате Uniform Naming Convention (UNC) - машина  не  появится  в
:: списках ресурсов сети.
::    После того, как вы сделали эти изменения, вы должны перезапустить  сервис
:: Server или перезагрузить машину. Кроме того, может  потребоваться  более  50
:: минут на то, чтобы  машина  была  удалена  из  списка  ресурсов  сети  из-за
:: политики окончания срока действия сервисов просмотра сети в Windows.

:Finish
