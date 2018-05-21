@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set user access control policy
set USAGE=disable/enable/default

if /I "%~1"=="DISABLE" (
  call :Disable_UAC
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_UAC
  goto Finish
)
if /I "%~1"=="DEFAULT" (
  call :Default_UAC
  goto Finish
)
exit /B 255


:Disable_UAC
:: Все администраторы работают в режиме одобрения администратором: Отключено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableLUA"                     /T REG_DWORD /D "0" /F || goto Disable_UAC_Fail
:: Обнаружение установки приложений и запрос на повышение прав: Отключено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableInstallerDetection"      /T REG_DWORD /D "0" /F || goto Disable_UAC_Fail
:: Переключение к безопасному рабочему столу при выполнении запроса на повышение прав: Отключено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "PromptOnSecureDesktop"         /T REG_DWORD /D "0" /F || goto Disable_UAC_Fail
:: Поведение запроса на повышение прав для администраторов в режиме одобрения администратором: Повышение без запроса
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorAdmin"    /T REG_DWORD /D "0" /F || goto Disable_UAC_Fail
:: Поведение запроса на повышение прав для обычных пользователей: Запрос учётных данных
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorUser"     /T REG_DWORD /D "3" /F || goto Disable_UAC_Fail
:: Повышать права для UIAccess-приложений только при установке в безопасных местах: Отключено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableSecureUIAPaths"          /T REG_DWORD /D "0" /F || goto Disable_UAC_Fail
:: Повышение прав только для подписанных и проверенных исполняемых файлов: Отключено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ValidateAdminCodeSignatures"   /T REG_DWORD /D "0" /F || goto Disable_UAC_Fail
:: При сбоях записи в файл или реестр виртуализация в место размещения пользователя: Включено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableVirtualization"          /T REG_DWORD /D "1" /F || goto Disable_UAC_Fail
:: Разрешить UIAccess-приложениям запрашивать повышение прав, не используя безопасный рабочий стол: Включено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableUIADesktopToggle"        /T REG_DWORD /D "1" /F || goto Disable_UAC_Fail
:: Режим одобрения администратором для встроенной учётной записи администратора: Отключено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "FilterAdministratorToken"      /T REG_DWORD /D "0" /F || goto Disable_UAC_Fail
:: Разрешить членам группы лок. администраторов административные подключения к удалённым компьютерам с полными правами: Включено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "LocalAccountTokenFilterPolicy" /T REG_DWORD /D "1" /F || goto Disable_UAC_Fail
call EchoSucc Set user access control policy to "Disable"
exit /B 0
:Disable_UAC_Fail
call EchoFail Set user access control policy to "Disable"
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableLUA"                     /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableInstallerDetection"      /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "PromptOnSecureDesktop"         /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorAdmin"    /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorUser"     /T REG_DWORD /D "3" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableSecureUIAPaths"          /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ValidateAdminCodeSignatures"   /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableVirtualization"          /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableUIADesktopToggle"        /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "FilterAdministratorToken"      /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "LocalAccountTokenFilterPolicy" /T REG_DWORD /D "1" /F
)
exit /B 1

:Enable_UAC
:: Все администраторы работают в режиме одобрения администратором: Включено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableLUA"                     /T REG_DWORD /D "1" /F || goto Enable_UAC_Fail
:: Обнаружение установки приложений и запрос на повышение прав: Включено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableInstallerDetection"      /T REG_DWORD /D "1" /F || goto Enable_UAC_Fail
:: Переключение к безопасному рабочему столу при выполнении запроса на повышение прав: Отключено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "PromptOnSecureDesktop"         /T REG_DWORD /D "0" /F || goto Enable_UAC_Fail
:: Поведение запроса на повышение прав для администраторов в режиме одобрения администратором: Повышение без запроса
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorAdmin"    /T REG_DWORD /D "0" /F || goto Enable_UAC_Fail
:: Поведение запроса на повышение прав для обычных пользователей: Запрос учётных данных
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorUser"     /T REG_DWORD /D "3" /F || goto Enable_UAC_Fail
:: Повышать права для UIAccess-приложений только при установке в безопасных местах: Включено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableSecureUIAPaths"          /T REG_DWORD /D "1" /F || goto Enable_UAC_Fail
:: Повышение прав только для подписанных и проверенных исполняемых файлов: Отключено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ValidateAdminCodeSignatures"   /T REG_DWORD /D "0" /F || goto Enable_UAC_Fail
:: При сбоях записи в файл или реестр виртуализация в место размещения пользователя: Включено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableVirtualization"          /T REG_DWORD /D "1" /F || goto Enable_UAC_Fail
:: Разрешить UIAccess-приложениям запрашивать повышение прав, не используя безопасный рабочий стол: Включено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableUIADesktopToggle"        /T REG_DWORD /D "1" /F || goto Enable_UAC_Fail
:: Режим одобрения администратором для встроенной учётной записи администратора: Отключено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "FilterAdministratorToken"      /T REG_DWORD /D "0" /F || goto Enable_UAC_Fail
:: Разрешить членам группы лок. администраторов административные подключения к удалённым компьютерам с полными правами: Включено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "LocalAccountTokenFilterPolicy" /T REG_DWORD /D "1" /F || goto Enable_UAC_Fail
call EchoSucc Set user access control policy to "Enable"
exit /B 0
:Enable_UAC_Fail
call EchoFail Setuser access control policy to "Enable"
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableLUA"                     /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableInstallerDetection"      /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "PromptOnSecureDesktop"         /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorAdmin"    /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorUser"     /T REG_DWORD /D "3" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableSecureUIAPaths"          /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ValidateAdminCodeSignatures"   /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableVirtualization"          /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableUIADesktopToggle"        /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "FilterAdministratorToken"      /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "LocalAccountTokenFilterPolicy" /T REG_DWORD /D "1" /F
)
exit /B 1

:Default_UAC
:: Все администраторы работают в режиме одобрения администратором: Включено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableLUA"                     /T REG_DWORD /D "1" /F || goto Default_UAC_Fail
:: Обнаружение установки приложений и запрос на повышение прав: Включено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableInstallerDetection"      /T REG_DWORD /D "1" /F || goto Default_UAC_Fail
:: Переключение к безопасному рабочему столу при выполнении запроса на повышение прав: Отключено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "PromptOnSecureDesktop"         /T REG_DWORD /D "1" /F || goto Default_UAC_Fail
:: Поведение запроса на повышение прав для администраторов в режиме одобрения администратором: Запрос согласия для двоичных файлов не из Windows
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorAdmin"    /T REG_DWORD /D "5" /F || goto Default_UAC_Fail
:: Поведение запроса на повышение прав для обычных пользователей: Запрос учётных данных
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorUser"     /T REG_DWORD /D "3" /F || goto Default_UAC_Fail
:: Повышать права для UIAccess-приложений только при установке в безопасных местах: Включено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableSecureUIAPaths"          /T REG_DWORD /D "1" /F || goto Default_UAC_Fail
:: Повышение прав только для подписанных и проверенных исполняемых файлов: Отключено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ValidateAdminCodeSignatures"   /T REG_DWORD /D "0" /F || goto Default_UAC_Fail
:: При сбоях записи в файл или реестр виртуализация в место размещения пользователя: Включено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableVirtualization"          /T REG_DWORD /D "1" /F || goto Default_UAC_Fail
:: Разрешить UIAccess-приложениям запрашивать повышение прав, не используя безопасный рабочий стол: Отключено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableUIADesktopToggle"        /T REG_DWORD /D "0" /F || goto Default_UAC_Fail
:: Режим одобрения администратором для встроенной учётной записи администратора: Отключено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "FilterAdministratorToken"      /T REG_DWORD /D "0" /F || goto Default_UAC_Fail
:: Разрешить членам группы лок. администраторов административные подключения к удалённым компьютерам с полными правами: Отключено
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "LocalAccountTokenFilterPolicy" /T REG_DWORD /D "0" /F || goto Default_UAC_Fail
call EchoSucc Set user access control policy to "Default"
exit /B 0
:Default_UAC_Fail
call EchoFail Set user access control policy to "Default"
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableLUA"                     /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableInstallerDetection"      /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "PromptOnSecureDesktop"         /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorAdmin"    /T REG_DWORD /D "5" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ConsentPromptBehaviorUser"     /T REG_DWORD /D "3" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableSecureUIAPaths"          /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "ValidateAdminCodeSignatures"   /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableVirtualization"          /T REG_DWORD /D "1" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "EnableUIADesktopToggle"        /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "FilterAdministratorToken"      /T REG_DWORD /D "0" /F
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /V "LocalAccountTokenFilterPolicy" /T REG_DWORD /D "0" /F
)
exit /B 1

:: Настройки групповых политик контроля учётных записей
:: ----------------------------------------------------
:: http://dimanb.wordpress.com/2010/02/16/настройки-групповых-политик-контрол/
::
:: RegKey RegValue:Disable/Enable/Default PolicyName
:: ------ ------------------------------- -----------------------------------------------------------------------------------------------
:: EnableLUA                     0/1/1    Все администраторы работают в режиме одобрения администратором (UAC for users)
:: EnableInstallerDetection      0/1/1    Обнаружение установки приложений и запрос на повышение прав
:: PromptOnSecureDesktop         0/0/1    Переключение к безопасному рабочему столу при выполнении запроса на повышение прав
:: ConsentPromptBehaviorAdmin    0/0/5    Поведение запроса на повышение прав для администраторов в режиме одобрения администратором
:: ConsentPromptBehaviorUser     3/3/3    Поведение запроса на повышение прав для обычных пользователей
:: EnableSecureUIAPaths          0/1/1    Повышать права для UIAccess-приложений только при установке в безопасных местах
:: ValidateAdminCodeSignatures   0/0/0    Повышение прав только для подписанных и проверенных исполняемых файлов
:: EnableVirtualization          1/1/1    При сбоях записи в файл или реестр виртуализация в место размещения пользователя
:: EnableUIADesktopToggle        1/1/0    Разрешить UIAccess-приложениям запрашивать повышение прав, не используя безопасный рабочий стол
:: FilterAdministratorToken      0/0/0    Режим одобрения администратором для встроенной учётной записи администратора (UAC for admin)
:: LocalAccountTokenFilterPolicy 1/1/0    Разрешить членам группы лок. администраторов административные подключения к удалённым компьютерам с полными правами
::
:: В этой статье рассказывается обо всех возможных настройках контроля учётных
:: записей пользователей. Рассмотрены все десять параметров политики
:: безопасности, которые отвечают за все возможные действия, связанные с UAC.
:: Кроме настройки контроля учётных записей при помощи групповой политики,
:: также рассмотрены эквивалентные им твики реестра.
::
:: ----------------------------------------------------------------------------
:: Все администраторы работают в режиме одобрения администратором
:: ----------------------------------------------------------------------------
:: Этот параметр политики определяет характеристики всех политик контроля
:: учётных записей для компьютера. От данного параметра зависит, будут ли
:: учётные записи администраторов запускаться в "режиме одобрения
:: администратором", то есть будут ли отображаться диалоги с запросом на
:: повышение полномочий. Отключение этой настройки, грубо говоря, полностью
:: отключает функционал контроля учётными записями пользователей. При изменении
:: этого параметра политики необходимо перезагрузить компьютер. Значение по
:: умолчанию – включено.
::
:: Возможные значения параметра:
::
:: - Отключено. Режим одобрения администратором и все соответствующие параметры
:: политики контроля учётных записей будут отключены.
:: "EnableLUA"="0"
::
:: - Включено. Режим одобрения администратором включен для того, чтобы
:: разрешить встроенной учётной записи администратора и всем остальным
:: пользователям, являющимся членами группы "Администраторы", работать в режиме
:: одобрения администратором.
:: "EnableLUA"="1"
::
:: ----------------------------------------------------------------------------
:: Обнаружение установки приложений и запрос на повышение прав
:: ----------------------------------------------------------------------------
:: Эта настройка определяет характеристики обнаружения установки приложений
:: для компьютера, проверяя подписаны ли программы, применяемые для
:: развёртывания приложений или нет. По умолчанию, если пользователь входит в
:: рабочую группу, она включена.
::
:: Возможные значения параметра:
::
:: - Отключено (по умолчанию для организации). При выборе этой настройки,
:: обнаружение программы установки приложений не выдает запрос на повышение
:: полномочий. Обычно эта настройка применяется в организациях, компьютеры и
:: пользователи которой входят в состав домена и для развертывания приложений
:: используются технологии делегированной установки (Group Policy Software
:: Install – GPSI). Соответственно, необходимость в обнаружении установщика
:: отпадает.
:: "EnableInstallerDetection"="0"
::
:: - Включено (по умолчанию для дома). В том случае, если программа установки
:: приложений обнаруживает необходимость повышения полномочий, пользователю
:: предлагается ввести имя пользователя и пароль учётной записи администратора.
:: Если пользователь вводит правильные учётные данные, операция продолжается с
:: соответствующими правами. Вид запроса зависит от того, к какой группе
:: принадлежит пользователь.
:: "EnableInstallerDetection"="1"
::
:: ----------------------------------------------------------------------------
:: Переключение к безопасному рабочему столу при выполнении запроса на
:: повышение прав
:: ----------------------------------------------------------------------------
:: Данный параметр политики определяет, будут ли запросы на повышение
:: полномочий выводится на интерактивный рабочий стол пользователя или на
:: безопасный рабочий стол при инициировании UAC-запроса. Значение по умолчанию
:: – включено. При изменении этого параметра политики необходимо перезагрузить
:: компьютер.
::
:: Возможные значения параметры:
::
:: - Отключено. Все запросы на повышение прав выводятся на интерактивный
:: рабочий стол пользователя.
:: "PromptOnSecureDesktop"="0"
::
:: - Включено. Все запросы на повышение прав выводятся на безопасный рабочий
:: стол независимо от параметров политики поведения приглашения для
:: администраторов и обычных пользователей.
:: "PromptOnSecureDesktop"="1"
::
:: ----------------------------------------------------------------------------
:: Поведение запроса на повышение прав для администраторов в режиме одобрения
:: администратором
:: ----------------------------------------------------------------------------
:: Текущая настройка позволяет определить действия пользователя, который входит
:: в группу "Администраторы" при выполнении операции, требующей повышения прав.
:: Значение по умолчанию установлено "Запрос согласия для сторонних двоичных
:: файлов (не Windows)".
::
:: Возможные значения параметра:
::
:: - Повышение без запроса. Позволяет привилегированным учётным записям
:: выполнить операцию, требующую повышения прав, без подтверждения согласия или
:: ввода учётных данных. Желательно использовать данную опцию только в средах с
:: максимальными ограничениями пользователей. При выборе этой настройки,
:: пользовательские полномочия станут идентичными встроенной учётной записи
:: администратора.
:: "ConsentPromptBehaviorAdmin"="0"
::
:: - Запрос учётных данных на безопасном рабочем столе. Для любой операции,
:: требующей повышения прав, на безопасном рабочем столе будет выводиться
:: предложение ввести имя и пароль привилегированного пользователя. Если
:: вводятся правильные учётные данные, операция будет продолжена с
:: максимальными доступными правами пользователя.
:: "ConsentPromptBehaviorAdmin"="1"
::
:: - Запрос согласия на безопасном рабочем столе. Для любой операции, требующей
:: повышения прав, на безопасном рабочем столе будет выводиться предложение
:: выбрать: "Разрешить" или "Запретить". При выборе опции "Разрешить", операция
:: будет продолжена с максимальными доступными правами пользователя.
:: "ConsentPromptBehaviorAdmin"="2"
::
:: - Запрос учётных данных. Для любой операции, которая требует повышения
:: полномочий, будет выводиться предложение ввести имя пользователя и пароль
:: учётной записи администратора. При вводе правильных учётных данных, операция
:: будет продолжена с повышенными полномочиями.
:: "ConsentPromptBehaviorAdmin"="3"
::
:: - Запрос согласия. При выборе этой опции, для любой операции, требующей
:: повышения прав, пользователю будет предлагаться выбрать нажать на кнопку:
:: "Разрешить" или "Запретить". При нажатии на кнопку "Разрешить", операция
:: будет продолжена с максимальными доступными привилегиями пользователя.
:: "ConsentPromptBehaviorAdmin"="4"
::
:: - Запрос согласия для двоичных файлов не из Windows. При выборе этой опции,
:: на безопасном рабочем столе будет выводиться предложение выбора: "Разрешить"
:: или "Запретить", в том случае, когда операция для приложения стороннего (не
:: Майкрософт) производителя требует повышения прав. По нажатию на кнопку
:: "Разрешить", операция будет продолжена с максимальными доступными
:: привилегиями пользователя.
:: "ConsentPromptBehaviorAdmin"="5"
::
:: ----------------------------------------------------------------------------
:: Поведение запроса на повышение прав для обычных пользователей
:: ----------------------------------------------------------------------------
:: Данный параметр политики определяет выполняемые действия при взаимодействии
:: обычного пользователя с приложениями, требующими повышения прав. Значение по
:: умолчанию – "Запрос учётных данных на безопасном рабочем столе".
::
:: Возможные значения параметра:
::
:: - Автоматически запретить запросы на повышение прав. При выборе этого
:: параметра, для обычного пользователя будет показано сообщение об ошибке в
:: связи с запретом на доступ в случае выполнения операции, требующей повышения
:: полномочий. Организации, настольные компьютеры которых используются обычными
:: пользователями, могут выбрать этот параметр политики для уменьшения числа
:: обращений в службу поддержки.
:: "ConsentPromptBehaviorUser"="0"
::
:: - Запрос учётных данных на безопасном рабочем столе. Выбрав данный параметр,
:: обычному пользователю предлагается выбрать учётную запись администратора и
:: ввести пароль для выполнения последующих действий только на безопасном
:: рабочем столе. Операция будет продолжена только в том случае, если учётные
:: данные введены правильно.
:: "ConsentPromptBehaviorUser"="1"
::
:: - Запрос учётных данных. Используя этот параметр, обычному пользователю
:: предлагается выбрать учётную запись администратора и ввести пароль для
:: выполнения последующих действий. Операция будет продолжена только в том
:: случае, если учётные данные введены правильно.
:: "ConsentPromptBehaviorUser"="3"
::
:: ----------------------------------------------------------------------------
:: Повышать права для UIAccess-приложений только при установке в безопасных
:: местах
:: ----------------------------------------------------------------------------
:: Текущий параметр политики позволяет управлять разрешением на местонахождение
:: приложений, которые запрашивают выполнение на уровне целостности,
:: определяющейся атрибутом пользовательского интерфейса доступа (User
:: Interface of Access – UIAccess) в безопасном месте файловой системы. По
:: умолчанию, эта настройка включена и у приложений со специальными
:: возможностями, для атрибута UIAccess в манифесте устанавливается значение
:: True для управления окна запроса повышения привилегий. Если у приложений
:: значение false, то есть если атрибут опущен или отсутствует манифест для
:: сборки, приложение не сможет получить доступ к защищённому пользовательскому
:: интерфейсу. Безопасными считаются только следующие папки:
:: - Program Files (включая вложенные папки)
:: - Program Files (x86) (включая вложенные папки)
:: - Windows\System32
::
:: Возможные значения параметра:
::
:: - Отключено. Приложение будет запускаться с уровнем целостности UIAccess,
:: даже если оно не находится в безопасной папке файловой системы.
:: "EnableSecureUIAPaths"="0"
::
:: - Включено. Приложение будет запускаться с уровнем целостности UIAccess
:: только в том случае, если оно находится в безопасной папке файловой системы.
:: "EnableSecureUIAPaths"="1"
::
:: ----------------------------------------------------------------------------
:: Повышение прав только для подписанных и проверенных исполняемых файлов
:: ----------------------------------------------------------------------------
:: Данная настройка групповой политики контроля учётных записей позволяет
:: определять, нужно ли выполнять проверку подлинности подписей интерактивных
:: приложений с инфраструктурой открытого ключа (Public key infrastructure
:: PKI), которые требуют повышения полномочий. Задачей PKI является определение
:: политики выпуска цифровых сертификатов, выдача их и аннулирование, хранение
:: информации, необходимой для последующей проверки правильности сертификатов.
:: В число приложений, поддерживающих PKI, входят: защищённая электронная
:: почта, протоколы платежей, электронные чеки, электронный обмен информацией,
:: защита данных в сетях с протоколом IP, электронные формы и документы с
:: электронной цифровой подписью. Если включена эта проверка, то программы
:: инициируют проверку пути сертификата. Значение этой настройки по умолчанию –
:: Отключено.
::
:: Возможные значения параметра:
::
:: - Отключено. При установке этого параметра, контроль учётных записей не
:: инициирует проверку цепочки верификации PKI-сертификатов, прежде чем
:: разрешить выполнение данного исполняемого файла.
:: "ValidateAdminCodeSignatures"="0"
::
:: - Включено. Принудительно инициируется проверка пути PKI-сертификатов,
:: прежде чем запускается на исполнение данный файл. В основном данная
:: настройка используется в организациях с доменом, в том случае если
:: администратор поместил PKI-сертификаты в хранилище надёжных издателей.
:: "ValidateAdminCodeSignatures"="1"
::
:: ----------------------------------------------------------------------------
:: При сбоях записи в файл или реестр виртуализация в место размещения
:: пользователя
:: ----------------------------------------------------------------------------
:: Этот параметр управляет перенаправлением сбоев записи приложений в
:: определённые расположения в реестре и файловой системе. В случае, если эта
:: настройка включена, для устаревших приложений, которые пытаются считывать
:: или записывать информацию, используя защищенные области системы, контроль
:: учётных записей виртуализирует реестр и файловую систему. Благодаря этой
:: настройке, UAC позволяет уменьшить опасность устаревших приложений, которые
:: выполняются от имени администратора и во время выполнения записывают данные
:: в папки %ProgramFiles%, %SystemRoot%, %SystemRoot%\System32 или в раздел
:: системного реестра HKLM\Software. Значение по умолчанию – включено.
::
:: Возможные значения параметра:
::
:: - Отключено. Выполнение приложений, записывающих данные в безопасные
:: расположения, заканчивается ошибкой, и не будет исполняться.
:: "EnableVirtualization"="0"
::
:: - Включено. Сбои записи приложений перенаправляются во время выполнения в
:: определённые пользователем расположения в файловой системе и реестре.
:: "EnableVirtualization"="1"
::
:: ----------------------------------------------------------------------------
:: Разрешить UIAccess-приложениям запрашивать повышение прав, не используя
:: безопасный рабочий стол
:: ----------------------------------------------------------------------------
:: Этот новый параметр политики, появившийся в операционных системах Windows 7
:: и Windows Server 2008 R2, определяет, могут ли UIAccess-приложения
:: автоматически отключать безопасный рабочий стол для запросов на повышение
:: полномочий, используемых обычным пользователем. Значение по умолчанию –
:: отключено.
::
:: Возможные значения параметра:
::
:: - Отключено. При выборе этого параметра, безопасный рабочий стол может быть
:: отключен только пользователем интерактивного рабочего стола или путём
:: отключения параметра политики "Контроль учётных записей: переключение к
:: безопасному рабочему столу при выполнении запроса на повышение прав".
:: "EnableUIADesktopToggle"="0"
::
:: - Включено. При выборе этой настройки, UIAccess-программы, в том числе
:: удалённый помощник Windows, автоматически отключают безопасный рабочий стол
:: для запросов на повышение полномочий. Если параметр политики "Контроль
:: учётных записей: переключение к безопасному рабочему столу при выполнении
:: запроса на повышение прав" включен, то предложение появится на интерактивном
:: рабочем столе пользователя, а не на безопасном рабочем столе.
:: "EnableUIADesktopToggle"="1"
::
:: ----------------------------------------------------------------------------
:: Режим одобрения администратором для встроенной учётной записи администратора
:: ----------------------------------------------------------------------------
:: Данная настройка определяет, применяется ли в контроле учётных записей
:: пользователей режим одобрения администратором к встроенной учётной записи
:: "Администратор". Эта встроенная учётная запись по умолчанию позволяет
:: пользователю входить в систему в режиме совместимости с Windows XP, что
:: разрешает запускать любые приложения с полными правами администратора. По
:: умолчанию этот параметр политики отключен.
::
:: Возможные значения параметра:
::
:: - Отключено. Встроенная учётная запись администратора выполняет все
:: приложения с полными правами администратора.
:: "FilterAdministratorToken"="0"
::
:: - Включено. При выборе этого значения параметра, для встроенной учётной
:: записи администратора будет использоваться режим одобрения администратором.
:: При этом любая операция, требующая повышения прав, будет сопровождаться
:: запросом на подтверждение операции.
:: "FilterAdministratorToken"="1"
::
:: ----------------------------------------------------------------------------
:: Разрешить членам группы лок. администраторов административные подключения к
:: удалённым компьютерам с полными правами
:: ----------------------------------------------------------------------------
:: Например, при подключения: \\remotehost\Admin$
::
:: Возможные значения параметра:
::
:: - Отключено. Не повышать права членам группы лок. администраторов при
:: административных подключениях к удалённым компьютерам.
:: "LocalAccountTokenFilterPolicy"="0"
::
:: - Включено. Повышать права членам группы лок. администраторов при
:: административных подключениях к удалённым компьютерам.
:: "LocalAccountTokenFilterPolicy"="1"

:Finish
