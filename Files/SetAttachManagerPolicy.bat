@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set attachment manager policy
set USAGE=

call :Set_Attachment_Manager_Policy
goto Finish


:Set_Attachment_Manager_Policy
:: Скрывать ли возможности для удаления сведений о зоне:
::   0 - Нет (по умолчанию).
::   1 - Да.
reg.exe>nul 2>nul add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /V "HideZoneInfoOnProperties" /T REG_DWORD /D "0" /F || goto Set_Attachment_Manager_Policy_Fail
reg.exe>nul 2>nul add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /V "HideZoneInfoOnProperties" /T REG_DWORD /D "0" /F || goto Set_Attachment_Manager_Policy_Fail

:: Сохранять ли сведения о зоне происхождения вложений:
::   1 - Нет.
::   2 - Да (по умолчанию).
reg.exe>nul 2>nul add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /V "SaveZoneInformation"      /T REG_DWORD /D "1" /F || goto Set_Attachment_Manager_Policy_Fail
reg.exe>nul 2>nul add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /V "SaveZoneInformation"      /T REG_DWORD /D "1" /F || goto Set_Attachment_Manager_Policy_Fail

:: Уведомлять ли антивирусные программы при открытии вложений:
::   1 - Нет.
::   2 - Необязательно.
::   3 - Да.
reg.exe>nul 2>nul add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /V "ScanWithAntiVirus"        /T REG_DWORD /D "3" /F || goto Set_Attachment_Manager_Policy_Fail
reg.exe>nul 2>nul add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /V "ScanWithAntiVirus"        /T REG_DWORD /D "3" /F || goto Set_Attachment_Manager_Policy_Fail

:: При открытии файла доверять:
::   1 - Типу файла.
::   2 - Обработчику файла (по умолчанию).
::   3 - Типу и обработчику файла.
reg.exe>nul 2>nul add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /V "UseTrustedHandlers"       /T REG_DWORD /D "2" /F || goto Set_Attachment_Manager_Policy_Fail
reg.exe>nul 2>nul add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" /V "UseTrustedHandlers"       /T REG_DWORD /D "2" /F || goto Set_Attachment_Manager_Policy_Fail

:: Уровень риска по умолчанию для вложенных файлов:
::   6150 - Высокий. Если вложение находится в списке типов  файлов  с  высоким
:: риском и получено из  зоны  ограниченных  узлов,  Windows  блокирует  доступ
:: пользователя к файлу. Если файл получен из зоны  Интернета,  Windows  выдает
:: предупреждение, прежде чем пользователь получит доступ к файлу.
::   6151 - Средний. Если вложение находится в списке типов файлов  со  средним
:: риском и получено из зоны ограниченных узлов  или  зоны  Интернета,  Windows
:: выдает предупреждение, прежде чем пользователь получит доступ  к  файлу  (по
:: умолчанию).
::   6152 - Низкий. Если вложение находится в  списке  типов  файлов  с  низким
:: риском, Windows не выдает предупреждение (независимо от  сведений  о  зоне),
:: прежде чем пользователь получит доступ к файлу.
reg.exe>nul 2>nul add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /V "DefaultFileTypeRisk" /T REG_DWORD /D "6152" /F || goto Set_Attachment_Manager_Policy_Fail
reg.exe>nul 2>nul add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /V "DefaultFileTypeRisk" /T REG_DWORD /D "6152" /F || goto Set_Attachment_Manager_Policy_Fail

:: Список типов файлов с низким риском.
reg.exe>nul 2>nul add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /V "LowRiskFileTypes"    /T REG_SZ /D ".7z;.bat;.cmd.;.com;.exe;.ini;.log;.msi;.rar;.reg;.txt;.zip;" /F || goto Set_Attachment_Manager_Policy_Fail
reg.exe>nul 2>nul add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /V "LowRiskFileTypes"    /T REG_SZ /D ".7z;.bat;.cmd.;.com;.exe;.ini;.log;.msi;.rar;.reg;.txt;.zip;" /F || goto Set_Attachment_Manager_Policy_Fail

call EchoSucc Set attachment manager policy
exit /B 0
:Set_Attachment_Manager_Policy_Fail
call EchoFail Set attachment manager policy
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments"  /V "HideZoneInfoOnProperties" /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments"  /V "HideZoneInfoOnProperties" /T REG_DWORD /D "0" /F
  reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments"  /V "SaveZoneInformation"      /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments"  /V "SaveZoneInformation"      /T REG_DWORD /D "1" /F
  reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments"  /V "ScanWithAntiVirus"        /T REG_DWORD /D "3" /F
  reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments"  /V "ScanWithAntiVirus"        /T REG_DWORD /D "3" /F
  reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments"  /V "UseTrustedHandlers"       /T REG_DWORD /D "2" /F
  reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments"  /V "UseTrustedHandlers"       /T REG_DWORD /D "2" /F
  reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /V "DefaultFileTypeRisk"      /T REG_DWORD /D "6152" /F
  reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /V "DefaultFileTypeRisk"      /T REG_DWORD /D "6152" /F
  reg.exe add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /V "LowRiskFileTypes"         /T REG_SZ /D ".7z;.bat;.cmd.;.com;.exe;.ini;.log;.msi;.rar;.reg;.txt;.zip;" /F
  reg.exe add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" /V "LowRiskFileTypes"         /T REG_SZ /D ".7z;.bat;.cmd.;.com;.exe;.ini;.log;.msi;.rar;.reg;.txt;.zip;" /F
)
exit /B 1

:Finish


:: Настройки диспетчера вложений.
:: http://support.microsoft.com/kb/883260/ru
::
::   Диспетчер вложений в операционной системе Windows  защищает  компьютер  от
:: небезопасных вложений, получаемых по  электронной  почте  или загружаемых из
:: Интернета.
::
::   В случае если диспетчер вложений обнаруживает вложение, которое может быть
:: небезопасным,  он   предотвращает   открытие   такого   файла   или   выдает
:: предупреждение при его открытии. Следующие параметры  определяют,  будет  ли
:: открытие файла предотвращено или выдано предупреждение при его открытии:
::   - Тип используемой программы;
::   - Тип открываемого или загружаемого файла;
::   - Установка уровня безопасности зоны Интернета,  из  которой  производится
:: загрузка файла.
::
::   Настроить зоны Интернета можно в браузере Microsoft Internet  Explorer  на
:: вкладке "Безопасность". Для просмотра  зон  Интернета  выберите  пункт  меню
:: "Сервис", далее "Свойства обозревателя", а затем щелкните закладку
:: "Безопасность". Разделяют четыре зоны Интернета:
::   - Интернет;
::   - Местная интрасеть;
::   - Надежные узлы;
::   - Ограниченные узлы.
::
::   Диспетчер вложений классифицирует  получаемые  или  загружаемые  файлы  по
:: типу и расширению файла. Типы  файлов  классифицируются  по  группам  риска,
:: диспетчер вложений выделяет группу высокого, среднего и низкого  риска.  При
:: сохранении на жесткий  диск  компьютера  файла  из  программы,  использующей
:: диспетчер вложений, одновременно сохраняются сведения о зоне  Интернета  для
:: данного файла.
::   Например, при сохранении на жесткий диск компьютера сжатого файла  (.zip),
:: присоединенного  к  электронному  сообщению,  сведения  о   зоне   Интернета
:: сохраняются одновременно с сохранением сжатого файла. При попытке извлечения
:: содержимого сжатого файла или выполнения файла действие не выполняется.
::   Сведения о зоне Интернета сохраняются  одновременно  с  сохранением  файла
:: только в случае, если файловой системой жесткого диска является NTFS.
::   При попытке загрузить или открыть файл с  веб-узла,  находящегося  в  зоне
:: ограниченного  Интернета,  может  появиться  сообщение  о  том,   что   файл
:: заблокирован.
::   При попытке открыть файл высокого уровня риска с узла, находящегося в зоне
:: Интернета с безопасностью уровня "Интернет", может появиться предупреждающее
:: сообщение, однако файлы данного типа доступны для открытия.
::   Типы файлов, которые диспетчер вложений не относит к группе  высокого  или
:: низкого риска, включаются в группу среднего риска.
::   При попытке  открыть  файл  среднего  уровня  риска,  находящийся  в  зоне
:: Интернета с уровнем безопасности "Интернет" или ограниченной зоны Интернета,
:: может  появиться  предупреждающее  сообщение,  однако  файлы  данного   типа
:: доступны для открытия.
