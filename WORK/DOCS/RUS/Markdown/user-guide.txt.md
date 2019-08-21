# Admin Scripts Set 01

## NAME

Admin Scripts - универсальный админ-пак для Windows

## SYNOPSIS

See modules definitions

## DESCRIPTION

Данный админ пак предназначен для первоначальной настройки или восстановления работы компьютеров, серверов и сети в небольшой организации или на хостинге.

Программа представляет собой InnoSetup EXE Инсталлятор, устанавливающий все файлы админ пака в каталог %SystemRoot% и его подкаталоги. Программы админ пака представляют собой скрипты, которые запускаются из командной строки или командных файлов. Некоторые скрипты перед запуском требуют дополнительной настройки, и это отражено в документации к скриптам. Также вместе со скриптами устанавливаются необходимые зависимости в виде двоичных файлов.

## AUTHOR

Admin Scripts Set 01 была заново переработан Юрием Денисовым 
на основе оригинальной разработки неизвестного автора.

## RESOURCES

GitHub: <http://github.com/yudenisov/Scripts>

Main web site: <http://yudenisov.ru>

Ссылки на оригинальную разработку, к сожалению, утеряны

## COPYING

Copyright © 2015-2019 Yuri Denisov (yudenisov). Свободное
распространение данной программы гарантируется
модифицированной BSD лицензией.Админ пак также содержит 
несвободные модули, которые поставляются «как есть» 
безо всяких изменений.

## SUMMARY

**

**Год,дата выпуска:** 2019

**Copyright:** (C) New Internet Technology Inc., 2015-2019

**Лицензия:** BSD (Open Source)

**Разрядность:** 32 bit

**Поддерживаемые платформы:** Microsoft Windows XP SP3, Microsoft
Windows 7, Microsoft Windows 8.1, Microsoft Windows 10, Windows 2003
Server SP1, Windows 2008 Server R2, Windows 2012 Server R2, Windows 2016
Server, Windows 2019 Server,

Данный админ пак является адаптацией уже существующего админ-пака под свои нужды. Данный админ пак является универсальным, хотя его основное назначение — это первоначальная настройка компьютеров и серверов в организации. С его помощью легко написать скрипт, который развернёт сеть из нескольких компьютеров вместе с контроллером домена Windows, DHCP-, DNS-серверами, выходом в Интернет. Конечно, решение не является абсолютно безопасным, но для малых рабочих групп вполне подойдёт.

Программа устанавливает файлы в системный каталог %SystemRoot% и его подкаталоги. После установки админ пак сразу готов к работе.

***Категория:*** Admin pack | ***Добавил:*** yudenis |
**Теги:** <span style="font-size: 10pt">admin set, set 01, admin-pack, new internet technologies, Windows XP
SP3, Windows 7, Windows 10</span>

## CONTENTS OF

#### Account.bat

Создание/удаление/активация аккаунта Windows.

**USAGE:** Account.bat make|delete|activate account [password]



#### Activate.bat

Активация Windows и/или Office KMS активатором. Активатор устанавливается отдельно

**USAGE:** Activate.bat win|off|all [KMS Server]



#### AddDHCPScope.bat

Добавляет диапазон (scope) для DHCP серверов в локальной сети

**USAGE:** AddDHCPScope.bat scope_ip scope_mask scope_name



#### AddDHCPScopeIP.bat

Добавляет на DHCP сервер зарезервированные адреса в диапазон IP адресов

**USAGE:** AddDHCPScopeIP.bat scope_ip host_ip host_mac host_name

где scope_ip диапазон адресов (адрес сети)

host_ip ip адрес хоста зарезервированный

host_mac  MAC адрес сетевой карты хоста с зарезервированным ip

host_name имя хоста



#### AddGroupToDomainAdmin.bat

Добавляет группу локальных администраторов компьютера в группу администраторов домена Windows

**USAGE:** AddGroupToDomainAdmin.bat DOMAIN

где DOMAIN - NetBIOS домен сети



#### AddUserToAdmins.bat

Добавляет пользователя в группу Администраторы

**USAGE:** AddUserToAdmins.bat [host\]User



#### AddUserToDCOMUsers.bat

Добавляет пользователя в группу пользователей Distributed COM

**USAGE:** AddUserToDCOMUsers.bat [host\]User



#### AddUserToDNSAdmins.bat

Добавляет пользователя в группу администраторов DNS

**USAGE:** AddUserToDNSAdmins.bat [host\]User



#### AddUserToRemoteUsers.bat

Добавляет пользователя в группу пользователей удалённого доступа

**USAGE:** AddUserToRemoteUsers.bat [host\]User



#### AdminShares.bat

Разрешает/запрещает административную шару на компьютере (в том числе анонимный доступ и нулевую сессию)

**USAGE:** AdminShares.bat enable|disable



#### ApplySettingsProfile.bat

Применяет профиль компьютера для дома и офиса (остановка служб и сервисов)

**USAGE:** ApplySettingsProfile.bat [home|work]

!!! Данный скрипт для своего нормального применения требует доработки !!!



#### AuthorizeDHCP.bat

Активизировать данный DHCP сервер в дереве Active Directory

**USAGE:** AuthorizeDHCP.bat fqdn ip



#### AutoLogon.bat

Выключает и включает автоматический вход в Windows

**USAGE:** AutoLogon.bat disable|enable [[[domain] user] pass]



#### BackupSystemDrive.bat

Архивирование диска C на текущий диск [D:]

**USAGE:** BackupSystemDrive.bat [backup_target]



#### CachingWDigest.bat

Включение и выключение протокола WDigest

**USAGE:** CachingWDigest.bat enable|disable



#### CAD.bat

Включение и выключение вызова Ctrl+Alt+Del при входе в систему

**USAGE:** CAD.bat disable|enable



#### CCM.bat

Удаляет или проверяет состояние Клиента менеджера конфигураций

**USAGE:** CCM.bat remove|check



#### CheckAdminRights.bat

Проверяет права администратора в системе

**USAGE:** CheckAdminRights.bat

Использует файлы EchoSecc.bat и EchoFail.bat



#### CheckBootTime.bat

Проверяет время загрузки

**USAGE:** CheckBootTime.bat

Использует файлы EchoSecc.bat и EchoFail.bat



#### CheckChildDomain.bat

Проверяет принадлежность домена мастер-домену

**USAGE:** CheckChildDomain.bat

Использует файл EchoWarn.bat



#### CheckDC.bat

Проверяет, является ли компьютер контроллером домена

**USAGE:** CheckDC.bat

Использует файл EchoWarn.bat



#### CheckDocsDir.bat

Проверяет присутствие в системе файлов документации

**USAGE:** CheckDocsDir.bat

Использует файлы EchoWarn.bat и EchoSucc.bat



#### CheckGateway.bat

Проверяет наличие шлюза в сети

**USAGE:** CheckGateway.bat

Использует файлы EchoWarn.bat и EchoSucc.bat



#### CheckIEVersion.bat

Проверяет версию установленного Internet Explorer (из реестра Windows)

**USAGE:** CheckIEVersion.bat

Использует файлы EchoSecc.bat и EchoFail.bat



#### CheckInet.bat

Проверяет Интернет-соединение (ping до DNS сервера Google)

**USAGE:** CheckInet.bat

Использует файлы EchoWarn.bat и EchoSucc.bat



#### CheckKMSinDNS.bat

Проверяет запись KMS сервера в DNS

**USAGE:** CheckKMSinDNS.bat



#### CheckLANInterfaces.bat

Проверяет наличие LAN интерфейса в системе (вывод ipconfig)

**USAGE:** CheckLANInterfaces.bat



#### CheckMasterDC.bat

Проверяет принадлежность системы Основному контроллеру домена

**USAGE:** CheckMasterDC.bat



#### CheckMemberOfDomain.bat

Проверяет, является ли компьютер членом домена (через реестр)

**USAGE:** CheckMemberOfDomain.bat



#### CheckOSType.bat

проверяет тип операционной системы компьютера из списка (данные реестра)

**USAGE:** CheckOSType.bat [LIST]



#### CheckPicsDir.bat

Проверяет присутствие в системе папки "Мои рисунки"

**USAGE:** CheckPicsDir.bat



#### CheckRealPrinters.bat

Проверяет действующие принтеры в системе

**USAGE:** CheckRealPrinters.bat



#### CheckSlaveDC.bat

Проверяет, является ли компьютер ведомым контроллером домена

**USAGE:** CheckSlaveDC.bat



#### CheckWirelessInterfaces.bat

Проверяет, присутствуют ли в системе беспроводные адаптеры (по выводу ipconfig)

**USAGE:** CheckWirelessInterfaces.bat



#### CleanFiles.bat

Удаляет из системы некоторые нежелательные файлы. Обращаться с осторожностью!

**USAGE:** CleanFiles.bat

!!! Данный скрипт для своего нормального применения требует доработки !!!



#### CleanHosts.bat

Очищает etc/hosts файл и добавляет в него некоторые полезные правила

**USAGE:** CleanHosts.bat

!!! Данный скрипт для своего нормального применения требует доработки !!!



#### CleanIFEO.bat

Удаляет ключи реестра Image File Execution Options

**USAGE:** CleanIFEO.bat



#### CleanLogEvents.bat

Очищает системный журнал Windows

**USAGE:** CleanLogEvents.bat



#### CleanPrintQueue.bat

Очищает очередь печати

**USAGE:** CleanPrintQueue.bat



#### CleanProcesses.bat

Очищает (убивает) некоторые процессы Windows

**USAGE:** CleanProcesses.bat



#### CleanRegistry.bat

Очищает некоторые нежелательные ключи реестра Windows

**USAGE:** CleanRegistry.bat



#### CleanSoft.bat

Удаляет из системы некоторое нежелательное программное обеспечение

**USAGE:** CleanSoft.bat



#### CleanTasks.bat

Очищает нежелательные задачи

**USAGE:** CleanTasks.bat



#### CleanTemp.bat

Удаляет пользовательские и системные временные файлы Windows

**USAGE:** CleanTemp.bat



#### CleanWindows.bat

Очистка временных файлов Windows, кеша, корзины и т.п.

**USAGE:** CleanWindows.bat



#### CloseAllSharedFiles.bat

Закрывает все общие файлы

**USAGE:** CloseAllSharedFiles.bat



#### ConfigureCore.bat

Пример конфигурации core Server

**USAGE:** отредактируйте и запустите этот файл



#### ConfigureDHCP.bat

Пример конфигурации DHCP сервера

**USAGE:** Отредактируйте и запустите этот файл



#### D.bat

Включение режима отладки

**USAGE:** D.bat command [parameters]



#### WoL.bat

Включение/выключение/проверка сервиса Wake on Lan на сетевом интерфейсе

**USAGE:** WoL.bat disable|enable|check interface_id



#### WinXPx32SecurityUpdates.bat

Включение/выключение обновлений безопасности для Windows XP

**USAGE:** WinXPx32SecurityUpdates.bat disable|enable



#### Wait.bat

Ожидание нажатия любой клавиши (в течение определённого времени)

**USAGE:** Wait.bat [seconds]



#### H.bat

Справка по командам

**USAGE:** H.bat [command]



#### Halt.bat

Выключить компьютер

**USAGE:** Halt.bat 



#### Hibernate.bat

Hibernate computer (перевод компьютера в глубокий сон)

**USAGE:** Hibernate.bat



#### Hibernation.bat

Включение/выключение/проверка Hibernation

**USAGE:** Hibernation.bat disable|enable|check



#### Elevate.bat

Запуск программы с административными полномочиями

**USAGE:** Elevate.bat [command [parameters]]

Функция использует внешнюю утилиту nircmd.exe



#### GPO.bat

Архивация и восстановление всех GPO

**USAGE:** GPO.bat backup|restore [backup_dir]



#### DefragObject.bat

Дефрагментация одного файла или каталога

**USAGE:** DefragObject.bat file_or_directory

Скрипт использует внешнюю утилиту contig.exe



#### DeleteDHCPAllScopes.bat

Удаляет все диапазоны на DHCP сервере

**USAGE:** DeleteDHCPAllScopes.bat



#### DeleteDHCPScope.bat

Удаляет диапазон (scope) ip адресов с DHCP сервера

**USAGE:** DeleteDHCPScope.bat scope_ip



#### DeleteDisallowedCerts.bat

Удаляет неразрешённые (просроченные) сертификаты из системы

**USAGE:** DeleteDisallowedCerts.bat



#### DeleteNTLdrRecordsFromBCD.bat

Удаляет NTLDR-based записи из BCD (главного загрузочного меню)

**USAGE:** DeleteNTLdrRecordsFromBCD.bat



#### DeleteObject.bat

Удаляет файл или каталог с диска (стандартным способом)

**USAGE:** DeleteObject.bat file_or_directory



#### DeleteObjectsOld.bat

Удаляет все файлы и каталоги, начиная с указанного

**USAGE:** DeleteObjectsOld.bat base_dir

Скрипт использует другой скрипт DeleteObject.bat



#### DeleteRegBHO.bat

Удаляет ключи реестра для выбранного объекта Browser Helper (BHO)

**USAGE:** DeleteRegBHO.bat {bho_duid}



#### DeleteRegEntry.bat

Удаляет запись в реестре или её значение

**USAGE:** DeleteRegEntry.bat reg_key [reg_val]



#### DeleteRegHKCU.bat

Удаляет ключ реестра в кусте HKCU или его значение. Использует функцию DeleteReg.bat

**USAGE:** DeleteRegHKCU.bat hkcu_reg_key [reg_val]



#### DeleteRegHKLMSoftware.bat

Удаляет HKLM\SOFTWARE[\Wow6432Node] ключи реестра или их значения

**USAGE:** DeleteRegHKLMSoftware.bat hklm_software_reg_key [reg_val]



#### DiagDC.bat

Диагностика контроллера домена Windows

**USAGE:** DiagDC.bat



#### Directory.bat

Создаёт/удаляет/очищает/проверяет каталог на диске

**USAGE:** Directory.bat delete|empty|make|check directory_name



#### DiRsync.bat

Синхронизирует два каталога на диске/в сети. Нужно указывать полные пути к каталогам.

**USAGE:** DiRsync.bat copy|mirror src_absolute_path dst_absolute_path



#### DisableAutorunDrives.bat

Отменяет автозапуск со сменных носителей (CD и флешек)

**USAGE:** DisableAutorunDrives.bat



#### DisableGWX.bat

Удаляет предложение перейти на Windows 10

**USAGE:** DisableGWX.bat



#### Drivers.bat

Архивирует/восстанавливает из резервной копии драйвера в системе.

**USAGE:** Drivers.bat backup|restore [backup_dir]

Использует каталог по умолчанию [C:\BACKUP\DRIVER\DoubleDriver], если не указан другой

Скрипт использует внешнюю утилиту ddriverc.exe (DoubleDriver)



#### EchoFail.bat

Выводит произвольное сообщение об ошибке

**USAGE:** EchoFail.bat [message]

При выводе функция использует программу hs_color.exe



#### EchoSucc.bat

Выводит произвольное сообщение об успешном завершении

**USAGE:** EchoSucc.bat [message]

При выводе функция использует программу hs_color.exe



#### EchoTitl.bat

Выводит произвольное титульное сообщение

**USAGE:** EchoTitl.bat [message]

При выводе функция использует программу hs_color.exe



#### EchoWarn.bat

Выводит произвольное сообщение предупреждения

**USAGE:** EchoWarn.bat [message]

При выводе функция использует программу hs_color.exe



#### EnableConnectToServer.bat

Возможность подключиться к Core Server с консоли 

**USAGE:** EnableConnectToServer.bat server_name [host_or_domain\user [password]]

Функция использует внешний модуль cmdkey.exe



Если вы хотите управлять Server Core без использования доменной аутентификации, для использования альтернативных учётных данных при подключении к управляемому компьютеру выполните следующую команду на управляющем компьютере:

  cmdkey /add:server.argon.com.ru /user:server\admin /pass:argonforever



Это здорово облегчит подключение по WinRM и сделает возможным в принципе управление по MMC.



#### EnableNTPServer.bat

Включает NTP сервер на компьютере

**USAGE:** EnableNTPServer.bat



#### EnableRegEdit.bat

Делает возможным запуск regedit.exe

**USAGE:** EnableRegEdit.bat



#### ExportADUsers.bat

Экспортирует всех пользователей Active Directory в файл [ADUsers.csv]

**USAGE:** ExportADUsers.bat [file_name]



#### ExportCerts.bat

Экспортирует доверенные и просроченные сертификаты в файлы

**USAGE:** ExportCerts.bat



#### ExportDHCP.bat

Экспортирует параметры DHCP сервера в файл [DHCP.dat]

**USAGE:** ExportDHCP.bat [file_name]



#### Feature.bat

Устанавливает/удаляет/проверяет компоненты Windows командой dism. По умолчанию выдаёт список компонентов.

**USAGE:** Feature.bat [disable|enable|check feature_name]



#### File.bat

Создаёт/удаляет/проверяет/очищает текстовый файл Windows

**USAGE:** File.bat delete|empty|make|check file_name



#### Firewall.bat

Включает/выключает брандмауэр Windows

**USAGE:** Firewall.bat disable|enable



#### Fix0xC0000005.bat

Исправляет ошибку 0xC0000005 (удаляет обновления, её вызывающие)

**USAGE:** Fix0xC0000005.bat



#### FlushDNS.bat

Очищает кеш DNS

**USAGE:** FlushDNS.bat



#### IEProtectedMode.bat

Включает/выключает защищённый режим работы Internet Explorer

**USAGE:** IEProtectedMode.bat disable|enable



#### ImportDHCP.bat

Импорт параметров DHCP сервера из файла  [DHCP.dat]

**USAGE:** ImportDHCP.bat [file_name]



#### ImportProxySettingsFromIE.bat

Импорт настроек прокси из Internet Explorer

**USAGE:** ImportProxySettingsFromIE.bat



Импортирование настроек прокси из IE в API WinHttp.

Это API используется, например, при обновлениях MSE.

http://pcportal.org.ru/forum/47-304-7



#### InstallDriver.bat

Установщик драйвера в системе из Inf файла

**USAGE:** InstallDriver.bat inf-file



#### IP6.bat

Включение/выключение IPV6 на всех сетевых интерфейсах

**USAGE:** IP6.bat disable|enable



#### JoinLinesSplitWithBackslash.bat

Объединить в одну строку файлы, разделённые обратным слэшем (фильтр)

**USAGE:** JoinLinesSplitWithBackslash.bat [search [change]]

Использует внешнюю программу sed



#### JoinToDomain.bat

Включение компьютера в домен Windows

**USAGE:** JoinToDomain.bat domain [account]

где account - логин администратора домена

Скрипт использует встроенную функцию netdom.exe для подключения к домену





#### Logout.bat

Завершает текущую сессию Windows

**USAGE:** Logout.bat



#### LSASSProtection.bat

Включает/выключает LSASS защиту для сторонних модулей

**USAGE:** LSASSProtection.bat disable|enable



#### MakeActivePart.bat

Делает активным определённый раздел (partition) диска

**USAGE:** MakeActivePart.bat [disk_number [part_number]]

Программа использует модуль операционной системы diskpart.exe



#### MC.bat

Консоль управления Windows

**USAGE:** MC.bat [ad|cer|cmp|dev|dhcp|dsk|dns|env|evt|gp|hv|mob|net|rst|shr|snd|srv|svc|tsk|usr|usr2|wb]



#### MobilityCenter.bat

Включение/выключение центра мобильности Windows

**USAGE:** MobilityCenter.bat disable|enable



#### MSE.bat

Управление Microsoft Security Client (встроенным антивирусом)

**USAGE:** MSE.bat sigremove|sigupdate|quickscan|fullscan [Show quarantined list]



#### MsgBox.bat

Вызывает окно сообщений

**USAGE:** MsgBox.bat [message]



#### NetConf.bat

Архивация/восстановление конфигурации сети из каталога [C:\BACKUP\

ET]

**USAGE:** NetConf.bat backup|restore [backup_dir]



#### NetPowerManagement.bat

Включение/выключение управления питанием на всех сетевых интерфейсах

**USAGE:** NetPowerManagement.bat disable|enable



#### NetVisibility.bat

Включение,выключение видимости компьютера в сетевом окружении

**USAGE:** NetVisibility.bat disable|enable



#### OEMDriversDel.bat

Удавление всех OEM драйверов

**USAGE:** OEMDriversDel.bat

Скрипт использует внешнюю программу pnputil.exe



#### UserProfileSettings.bat

Установки профиля пользователя

**USAGE:** UserProfileSettings.bat [delete username]



#### USBStorage.bat

Сохранение/восстановление содержимого USB носителя в файл [C:\image.imz]

**USAGE:** USBStorage.bat [backup|restore drive [image]]

Скрипт использует утилиту usbitcmd.exe



#### USBDevOnSoftRemove.bat

Включение/выключение USB устройства для мягкого удаления (использует реестр)

**USAGE:** USBDevOnSoftRemove.bat disable|enable



#### UnwrapMikroTikExport.bat

Убирает переносы в файлах экспорта Microtik  [*.export *.rsc]

**USAGE:** UnwrapMikroTikExport.bat [file_names]



#### Thumbs.bat

Включает/выключает миниатюры (файлов просмотра рисунков и видео)

**USAGE:** Thumbs.bat disable|enable



#### ThumbCache.bat

Включает/выключает кеш миниатюр

**USAGE:** ThumbCache.bat disable|enable



#### SysInfo.bat

Выводит информацию о системе

**USAGE:** SysInfo.bat



#### P.bat

Пинг хоста [8.8.8.8]

**USAGE:** P.bat [host]



#### PathManagement.bat

Управление системными и пользовательскими путями

**USAGE:** PathManagement.bat show|set|delete|add|normalize system|user [path]



#### PPTP.bat

Управление PPTP соединениями (с графическим интерфейсом)

**USAGE:** PPTP.bat [delete|add connection_name [server user password [dns-suffix]]]



#### Process.bat

Удаляет/проверяет процесс [Выдаёт список процессов]

**USAGE:** Process.bat [delete|check process_name]

Скрипт использует функции taskkill.exe и tasklist.exe



#### Task.bat

Добавляет/удаляет/проверяет запланированные задачи Windows [Выдаёт список задач]

**USAGE:** Task.bat [delete|add|check task_name [hourly|daily|weekly|onstart task]]



#### TaskBackupDHCP.bat

Удаление/добавление задачи архивирования параметров DHCP сервера

**USAGE:** TaskBackupDHCP.bat delete/add [backup_path]



#### TaskBackupSystemDrive.bat

Добавление/удаление/Проверка задачи архивации системного диска (на D:)

**USAGE:** TaskBackupSystemDrive.bat delete|add|check [backup_target]



#### TaskMountExchangeDatabases.bat

Добавление/удаление задачи монтирования баз данных Microsoft Exchange

**USAGE:** TaskMountExchangeDatabases.bat delete/add



#### TestAD.bat

Тест ActiveDirectory

**USAGE:** TestAD.bat [domain]



#### RDP.bat

Разрешает/запрещает RDP соединения к данному хосту

**USAGE:** RDP.bat disable|enable



#### Reboot.bat

Перезагружает компьютер

**USAGE:** Reboot.bat



#### RegisterDNS.bat

Обновить все DHCP leases и перерегистрировать DNS имена

**USAGE:** RegisterDNS.bat



#### RemoteAccessToPnP.bat

Включает/выключает удалённый доступ к PnP (RPC) интерфейсу

**USAGE:** RemoteAccessToPnP.bat disable|enable



#### RemoveFromDomain.bat

Удаляет компьютер из домена

**USAGE:** RemoveFromDomain.bat [account]

где account - аккаунт администратора домена

Скрипт использует встроенную функцию netdom.exe



#### Release.bat

Отменить DHCP конфигурацию на всех адаптерах

**USAGE:** Release.bat



#### Renew.bat

Обновить DHCP и статическую конфигурацию на всех адаптерах

**USAGE:** Renew.bat 

Скрипт использует вызов стандартной программы ipconfig.exe



#### RepairDC.bat

Восстанавливает контроллер домена

**USAGE:** RepairDC.bat

Скрипт использует вызовы стандартных программ dcdiag.exe и netdiag.exe



#### RepairDisk.bat

Восстановление диска

**USAGE:** RepairDisk.bat disk

Программа использует встроенную команду chkdsk.exe



#### RepairIcons.bat

Восстанавливает иконки

**USAGE:** RepairIcons.bat

Скрипт использует вызов встроенной программы reg.exe и внешней утилиты hidec.exe



#### RepairMSI.bat

Восстанавливает Microsoft Windows Installer

**USAGE:** RepairMSI.bat

Скрипт использует вызов внешней утилиты hidec.exe и стандартных программ net.exe, regsvr32.exe и msiexec.exe



#### RepairNet.bat

Восстановление сетевых настроек

**USAGE:** RepairNet.bat

В своей работе скрипт использует другие скрипты из данного пакета



#### RepairVBS.bat

Восстанавливает движок Visual Basic Script

**USAGE:** RepairVBS.bat

Скрипт использует вызов стандартной программы regsvr32.exe



#### RepairVSS.bat

Восстановление сервиса теневого копирования томов

**USAGE:** RepairVSS.bat 

Скрипт использует вызовы стандартных функций net.exe, regsvr32.exe и vssvc.exe



#### ResetIP4.bat

Общий сброс стека протоколов TCP/IP IPv4

**USAGE:** ResetIP4.bat

Скрипт использует вызов стандартной функции netsh.exe



#### ResetIP6.bat

Общий сброс стека протоколов TCP/IP версии IPv6

**USAGE:** ResetIP6.bat

Скрипт использует вызов стандартной утилиты netsh.exe



#### ResetWinsock.bat

Общий сброс установок WinSock

**USAGE:** ResetWinsock.bat

Скрипт использует вызов стандартной утилиты netsh.exe



#### RestartSvcHyperV.bat

Запуск службы Hyper-V

**USAGE:** RestartSvcHyperV.bat

Скрипт использует вызов стандартной утилиты net.exe и зависимых служб Hyper-V



#### RoleDHCPServer.bat

Добавляет/удаляет роль DHCP сервера

**USAGE:** RoleDHCPServer.bat add|delete

Скрипт использует вызов определённого ранее скрипта Feature.bat



#### RoleDNSServer.bat

Добавляет/удаляет роль DNS сервера

**USAGE:** RoleDNSServer.bat add|delete

Скрипт использует вызов ранее определённого скрипта Feature.bat



#### RunAsSystem.bat

Запуск команды с административными (SYSTEM) полномочиями

**USAGE:** RunAsSystem.bat [command [parameters]]

Скрипт использует вызов внешней программы psx.exe (PsExec.exe из sysinternals)



#### SetAccessMode.bat

Устанавливает права доступа для файлов и каталогов. Права устанавливаются от имени групп «Администраторы», «Пользователи», «Все»

**USAGE:** SetAccessMode.bat file_or_dir [read/write/full]

Скрипт использует вызов стандартной утилиты cacls.exe



#### SetAttachManagerPolicy.bat

Установить политику диспетчера вложений

**USAGE:** SetAttachManagerPolicy.bat

Скрипт использует вызов стандартной утилиты reg.exe



!!! Перед запуском файл должен быть проверен и настроен !!!



Настройки диспетчера вложений.

http://support.microsoft.com/kb/883260/ru

  Диспетчер вложений в операционной системе Windows  защищает  компьютер  от
небезопасных вложений, получаемых по  электронной  почте  или загружаемых из
Интернета.

  В случае если диспетчер вложений обнаруживает вложение, которое может быть
небезопасным,  он   предотвращает   открытие   такого   файла   или   выдаёт
предупреждение при его открытии. Следующие параметры  определяют,  будет  ли
открытие файла предотвращено или выдано предупреждение при его открытии:

  - Тип используемой программы;

  - Тип открываемого или загружаемого файла;

  - Установка уровня безопасности зоны Интернета,  из  которой  производится
загрузка файла.



  Настроить зоны Интернета можно в браузере Microsoft Internet  Explorer  на
вкладке "Безопасность". Для просмотра  зон  Интернета  выберите  пункт  меню
"Сервис", далее "Свойства обозревателя", а затем щёлкните закладку
"Безопасность". Разделяют четыре зоны Интернета:

  - Интернет;

  - Местная интрасеть;

  - Надёжные узлы;

  - Ограниченные узлы.

  Диспетчер вложений классифицирует  получаемые  или  загружаемые  файлы  по
типу и расширению файла. Типы  файлов  классифицируются  по  группам  риска,
диспетчер вложений выделяет группу высокого, среднего и низкого  риска.  При
сохранении на жёсткий  диск  компьютера  файла  из  программы,  использующей
диспетчер вложений, одновременно сохраняются сведения о зоне  Интернета  для
данного файла.

  Например, при сохранении на жёсткий диск компьютера сжатого файла  (.zip),
присоединённого  к  электронному  сообщению,  сведения  о   зоне   Интернета
сохраняются одновременно с сохранением сжатого файла. При попытке извлечения
содержимого сжатого файла или выполнения файла действие не выполняется.

  Сведения о зоне Интернета сохраняются  одновременно  с  сохранением  файла
только в случае, если файловой системой жёсткого диска является NTFS.

  При попытке загрузить или открыть файл с  веб-узла,  находящегося  в  зоне
ограниченного  Интернета,  может  появиться  сообщение  о  том,   что   файл
заблокирован.

  При попытке открыть файл высокого уровня риска с узла, находящегося в зоне
Интернета с безопасностью уровня "Интернет", может появиться предупреждающее
сообщение, однако файлы данного типа доступны для открытия.

  Типы файлов, которые диспетчер вложений не относит к группе  высокого  или
низкого риска, включаются в группу среднего риска.

  При попытке  открыть  файл  среднего  уровня  риска,  находящийся  в  зоне
Интернета с уровнем безопасности "Интернет" или ограниченной зоны Интернета,
может  появиться  предупреждающее  сообщение,  однако  файлы  данного   типа
доступны для открытия.



#### SetBootParams.bat

Задаёт параметры первоначальной загрузки Windows

**USAGE:** SetBootParams.bat

Скрипт использует вызов стандартных функций reg.exe и bcedit.exe



Скрипт добавляет в систему следующие возможности:

Задаём количество резервных копий, которые будет хранить система.

Включаем пункт "Загрузка последней удачной конфигурации" в диспетчере загрузки.

Возвращаем старый диспетчер загрузки в Windows 8, вызываемый по F8 (дополнительные варианты загрузки).

Выключаем загрузочное меню в Windows (выбор ОС при загрузке).



#### SetDesktopParams.bat

Установить параметры рабочего стола

**USAGE:** SetDesktopParams.bat

Скрипт использует вызов стандартной утилиты reg.exe

Скрипт устанавливает следующие параметры:

Отображать значок "Компьютер" на рабочем столе (для Windows XP)

Отобразить значок "Корзина" на рабочем столе (для Windows XP)

Отображать значок "Компьютер" на рабочем столе (для Windows 7)

Отобразить значок "Корзина" на рабочем столе (для Windows 7)

Отобразить значок "Корзина" на рабочем столе



#### SetDHCPDNSCredentials.bat

Устанавливает учётные записи для DHCP и DNS серверов

**USAGE:** SetDHCPDNSCredentials.bat [domain\user [pass]]

Скрипт использует вызов стандартных утилит netsh.exe и netdom.exe



#### SetDHCPDNSServers.bat

Устанавливает для DHCP сервера записи DNS серверов

**USAGE:** SetDHCPDNSServers.bat dns_server1 [dns_server2 [..]]

Скрипт использует вызов стандарт ной утилиты netsh.exe



#### SetDHCPDNSSuffix.bat

Устанавливает для DHCP сервера DNS суффикс

**USAGE:** SetDHCPDNSSuffix.bat dns_suffix

Скрипт использует вызов стандартной утилиты netsh.exe



#### SetDHCPNTPServers.bat

Задаёт для заданного DHCP сервера записи NTP серверов

**USAGE:** SetDHCPNTPServers.bat ntp_server1 [ntp_server2 [..]]

Скрипт использует вызов стандартной утилиты netsh.exe



#### SetDHCPScopeGateway.bat

Задаёт на DHCP сервере в диапазоне IP шлюз

**USAGE:** SetDHCPScopeGateway.bat scope_ip gateway

Скрипт использует вызов стандартной утилиты netsh.exe



#### SetDHCPScopeRange.bat

Задаёт на DHCP сервере диапазон IP адресов (верхний и нижний пределы)

**USAGE:** SetDHCPScopeRange.bat scope_ip ip_min ip_max

Скрипт использует вызов стандартной функции netsh.exe



#### SetDHCPTFTPServer.bat

Назначает данному DHCP серверу TFTP сервер

**USAGE:** SetDHCPTFTPServer.bat tftp_server

Скрипт использует вызов стандартной функции netsh.exe



#### SetDNS.bat

Задаёт DNS сервера на сетевом интерфейсе

**USAGE:** SetDHCPTFTPServer.bat interface_id [dns_server1 [dns_server2 [dns_server3]]]

Скрипт использует вызов стандартной утилиты netsh.exe



#### SetDNSServerParams.bat

Устанавливает параметры DNS сервера Windows по умолчанию

**USAGE:** SetDNSServerParams.bat

Скрипт использует вызов стандартной утилиты dnscmd.exe



#### SetExplorerParams.bat

Устанавливает параметры проводника Windows по умолчанию (скрывает/показывает папку «Библиотеки»)

**USAGE:** SetExplorerParams.bat

Скрипт использует вызов стандартной утилиты reg.exe



#### SetHostName.bat

Переименовывает имя компьютера в домене Windows

**USAGE:** SetHostName.bat host_name

Скрипт использует вызов стандартной функции netdom.exe



#### SetIEParams.bat

Устанавливает параметры Microsoft Internet Explorer

**USAGE:** SetIEParams.bat

Скрипт использует вызов стандартной функции reg.exe



При своей работе скрипт устанавливает следующие параметры:

Отключить сообщение "Остановить выполнение этого сценария?"

Отключить сообщение об автозаполнении

Отключить автоматическое скрытие верхней панели

Отключить отладку сценариев (другие)

Отключить отладку сценариев (IE)

Не выполнять настройку при первом запуске

Не показывать уведомление о каждой ошибке сценария

Не показывать страницу знакомства с браузером

Не отправлять отчёты об ошибках

Домашняя страница http://www.google.ru/

Включить автозаполнение форм

Не открывать браузер в полноэкранном режиме

Уведомлять об окончании загрузки

Использовать плавную прокрутку

Не сообщать, если IE не используется по умолчанию

Включить фильтр SmartScreen

Разрешить вкладки

Удалить поисковик NightWarez.ru

Удалить поисковик Live Search

Удалить поисковик Microsoft

Удалить поисковик Yandex

Добавить поисковик Google

Назначить Google поисковиком по умолчанию (обязательно использование предыдущего твика)

Включить варианты для Google (обязательно использование предыдущих двух твиков)

Отключить предупреждение о начале просмотра веб-страницы через безопасное соединение (HTTPS)

Кэш для временных файлов = 250 Мб

Домашняя страница

Устранение последствий вирусов. Симптомы: на любой адрес открывается один и тот же зловредный сайт



#### SetIP.bat

Установить IP, маску и шлюз на сетевом интерфейсе

**USAGE:** SetIP.bat interface_id [ip mask [gateway [metric]]]

Скрипт использует вызов стандартной утилиты netsh.exe



#### SetKMS.bat

Устанавливает KMS сервер для Windows и/или  Office

**USAGE:** SetKMS.bat win|off|all [kms_server]

Скрипт использует вызов нестандартных скриптов ospp.vbs, slmgr.vbs



#### SetLayoutEn.bat

Устанавливает английскую раскладку клавиатуры по умолчанию

**USAGE:** SetLayoutEn.bat

Скрипт использует вызов стандартной утилиты reg.exe



#### SetLDAPBindParams.bat

Задание установок для команды LDAP BIND

**USAGE:** SetLDAPBindParams.bat default|sasl

Скрипт использует встроенную утилиту netsh.exe



#### ShowKMS.bat

Показывает статус лицензии KMS для Windows и/или Office

**USAGE:** ShowKMS.bat win|off|all

Скрипт использует вызов нестандартного скрипта slmgr.vbs



#### _find.exe

Утилита «find» из пакета unxutils



#### PPTP.hta

HTML GUI приложение для подключения к PPTP серверу



#### Suspend.bat

Перевести компьютер в режим сна

**USAGE:** Suspend.bat

Скрипт использует вызов стандартной програмы rundll.exe



#### SetMenuParams.bat

Установить параметры меню Windows Explorer

**USAGE:** SetMenuParams.bat

Скрипт использует вызов стандартной утилиты reg.exe



Скрипт использует следующие установки (твики):

Раскрывать "Сетевые подключения" при использовании классического меню (для Windows XP)

Не использовать сокращённое меню (для Windows XP)

Не показывать пункт "Помощь" в меню (не для классического меню)

Включить классическое меню

Разрешить запуск "Панели управления" и показывать соответствующий пункт в меню

Не показывать пункт "Справка и поддержка" в меню (для классического меню)

Разрешить запуск "Панели управления" и показывать соответствующий пункт в меню

Не показывать пункт "Справка и поддержка" в меню (для классического меню)



#### SetNetDevCharacters.bat

Устанавливает характеристики сетевого устройства

**USAGE:** SetNetDevCharacters.bat device_id characters_dword

Скрипт использует вызов стандартной утилиты reg.exe

*Hide the TAP-Adapter in Network Connections:*

  `call :SetNetDevCharacters "tap0901" "0x81"`

*Show the TAP-Adapter in Network Connections:*

  `call :SetNetDevCharacters "tap0901" "0x89"`



#### SetNumLock.bat

Устанавливает режим работы клавиши NumLock

**USAGE:** SetNumLock.bat on|off

Скрипт использует вызов стандартной утилиты reg.exe



#### SetOwner.bat

Задаёт пользователя (собственника) файла или каталога

**USAGE:** SetOwner.bat file_or_dir [user]

Скрипт использует вызов стандартной утилиты subinacl.exe и внешней утилиты hidec.exe



#### SetPasswordPolicy.bat

Устанавливает значение политики паролей пользователей по умолчанию

**USAGE:** SetPasswordPolicy.bat

Скрипт использует вызов стандартной утилиты reg.exe



Значения по умолчанию:

   Установка  минимальной  длины  пароля.  Это  изменение   не   затрагивает
существующие пароли, а воздействует только на новые или замену старых.  Тип:
REG_BINARY; Значение: любое допустимое (по умолчанию параметра нет)

   Этот параметр определяет, будет ли Windows  требовать  алфавитно-цифровой
пароль, то есть пароль, созданный из комбинаций букв (А, В,  С...)  и  чисел
(1,2,3...) Тип: REGD_WORD;  Значение:  1 - требовать (по умолчанию параметра
нет)

   Интepaктивный вxoд в cиcтeму: нaпoминaть пoльзoвaтeлям oб иcтeчeнии cpoкa
дeйcтвия пapoля зapaнee. Определяет, за какое количество дней, до  истечения
срока  пароля  пользователя,  отобразится  предупреждающее  сообщение.  Тип:
REG_DWORD; Значение: любое допустимое (по умолчанию 14). Локальная  политика
безопасности > Лoкaльныe пoлитики > Пapaмeтpы бeзoпacнocти

  Компьютер  не  будет  менять  пароль  своей  системной  учетной   записи.
Соответственно, он не "вылетит" из домена, даже  если  вы  его  не  включали
несколько лет, или применили старый снимок состояния системы.

   Члeн  дoмeнa:  мaкcимaльный  cpoк   дeйcтвия   пapoля   учeтныx   зaпиceй
кoмпьютepa. Локальная политика безопасности > Лoкaльныe пoлитики > Пapaмeтpы
бeзoпacнocти. Тип: REG_DWORD; Значение: 1 - 1000000 (по умолчанию 30 дней)



#### SetSFCParams.bat

Включение и выключение SFC (контроля целостности системных файлов)

**USAGE:** SetSFCParams.bat disable|enable

Скрипт использует вызов системной утилиты reg.exe

SFC - служба проверки системных файлов. Все системные файлы находятся в
папках %SYSTEMROOT% и %SYSTEMROOT%\System32. SFC автоматически
восстанавливает их из папки %SYSTEMROOT%\System32\dllcache, если они были
случайно удалены или повреждены.

*KEY Name:* `HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon`

*Entry Name:* SFCDisable

*Data Type:* REG_DWORD

*Value:* 0,1,2,3,4

  *0* - SFC включена (по умолчанию).

  *1* - SFC отключена, но спрашивает пользователя о включении при загрузке ОС.

  *2* - SFC отключена полностью и пользователи не могут снова включить её.

  *4* - SFC включена, но всплывающие окна блокируются.

Параметр SFCScan может быть полезен для выполнения сканирования файлов,
защищенных системой.

*Entry Name:* SFCScan

*Data Type:* REG_DWORD

*Value:& 0,1,2

  *0* - не проверять защищенные файлы при загрузке системы (по умолчанию).

  *1* - сканировать защищённые файлы при каждой загрузке.

  *2* - разово сканировать файлы, защищённые системой.

Параметр SFCQuota задаёт размер папки `%SYSTEMROOT%\System32\dllcache`. По
умолчанию её размер - 400 Мб (0xFFFFFFFF). Размер папки можно сократить до
нуля с помощью команды: `sfc /cachesize=0`.

*Entry Name:* SFCQuota

*Data Type:* REG_DWORD

*Value:* 0x00000000..0xFFFFFFFF

http://winitpro.ru/index.php/2010/07/28/windows-sfc-i-klyuchi-reestra/

http://citforum.ru/operating_systems/windows/optimXP/



#### SetSRPPolicy.bat

Задание политики разрешения программного обеспечения 

**USAGE:** SetSRPPolicy.bat unrestricted|basicuser|disallowed|disable|log|nolog

Скрипт использует вызов системной утилиты reg.exe

*Основной алгоритм действий:*

Включаем уровень политики в param (для Windows Vista/Windows Server 2008)

Выводим администраторов из-под действия политики (для Windows Vista/Windows Server 2008)

Включаем уровень политики в param (для Windows XP /Windows Server 2003)



#### SetTaskbarParams.bat

Устанавливает параметры панели задач (твик)

**USAGE:** SetTaskbarParams.bat 

Скрипт используетвызов стандартной утилиты reg.exe

*Основные действия:*

Восстанавливаем панель задач (для Windows XP)

Всегда отображать все значки и уведомления на панели задач

Отключить значок "Центр поддержи" из области уведомлений

Отключить предварительный просмотр рабочего стола (для Windows 7)

Отключить предварительный просмотр окон над панелью задач (для Windows 7)

Отключить все всплывающие уведомления в трее

Не группировать кнопки на панели задач (для Windows XP)

Не группировать кнопки на панели задач (для Windows 7)

Отключить предупреждения системы антивирусной защиты

Отключить предупреждения системы антивирусной защиты

Отключить предупреждения брандмауэра

Отключить предупреждения брандмауэра

Отключить сообщения центра безопасности

Отключить предупреждения службы автоматического обновления



#### SetTCPIPParams.bat

Установить TCP/IP параметры по умолчанию

**USAGE:** SetTCPIPParams.bat

Скрипт использует вызов системной утилиты reg.exe



#### SetTime.bat

Вызывает GUI панель для установки даты, времени и часового пояса

**USAGE:** SetTime.bat

Скрипт использует вызов стандартной утилиты control.exe и оснастки timedate.cpl



#### SetTimeMaxPhaseCorrection.bat

Скрипт устанавливает максимальное время фазовой коррекции

**USAGE:** SetTimeMaxPhaseCorrection.bat fordc|always

Скрипт использует вызов стандартной утилиты reg.exe

Задаем максимальную величину отрицательной/положительной коррекции времени
(в секундах), которую может выполнить служба времени. Если окажется, что
величина изменения превышает допустимое значение, то изменение выполняться
не будет, и будет зарегистрировано соответствующее событие. Если данный
параметр равен 0xFFFFFFFF, то изменение времени будет выполняться всегда.
По умолчанию для компьютеров-членов домена используется значение 0xFFFFFFFF.
Для изолированных компьютеров и серверов по умолчанию используется значение
0x0000D2F0 (15 часов). Для контроллеров домена - 0x0002A300 (48 часов).



#### SetTimeoutForLAN.bat

Задание времени соединения по локальной сети (LAN)

**USAGE:** SetTimeoutForLAN.bat minuts

Скрипт использует вызов системной утилиты net.exe

Задание времени до автоматического отключения соединения серверной службы:

`net config server /autodisconnect:N`

Где N - количество минут (макс. 65535), соответствующее интервалу ожидания,
по истечении которого будет прервано соединение с подключённым сетевым
диском. При N=0 серверная служба прерывает соединение с подключенными
сетевыми дисками после нескольких секунд бездействия. При N=-1
автоматическое отключение отменяется. По умолчанию N=15.



#### SetTimeSpecialPollInterval.bat

Установки времени специальной коррекции временного интервала с NTP серверов

**USAGE:** SetTimeSpecialPollInterval.bat seconds

Скрипт использует вызов системной утилиты reg.exe

Список источников W32Time настраивается через параметр реестра

`HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters\NtpServer`

Он содержит список серверов времени, разделяемых пробелами. Каждый сервер
может иметь установленные шестнадцатеричные значения флагов, указываемые
через запятую после сервера. Существует 4 возможных значений флагов:

  0x01 SpecialInterval

  0x02 UseAsFallbackOnly

  0x04 SymmatricActive

  0x08 Client

При использовании флага SpecialInterval, используется параметр реестра

`HKLM\SYSTEM\CurrentControlSet\Services\W32Time\TimeProviders\NtpClient\`

*SpecialPollInterval* - интервал синхронизации времени в секундах.

По умолчанию он равен 7 дням (604800 сек). При такой настройке часы могут
иметь погрешность до нескольких минут. Рекомендую уменьшить интервал
синхронизации до 6 часов (21600 сек). Это изменение не увеличит ни трафика,
ни нагрузки на NTP-сервера, и при этом позволит поддерживать более высокую
точность хода часов вашего компьютера.

При значении флага UseAsFallbackOnly службе времени сообщается, что данный
сервер будет использоваться как резервный и перед синхронизацией с ним
будут выполнятся обращения к другим серверам списка.

После внесения необходимых настроек в можно перечитать конфигурацию
сохранённую в реестре командой: w32tm /config /update. И при необходимости
выполнить немедленную синхронизацию: w32tm /resync.



#### SetTimeSyncFromDC.bat

Устанавливает время синхронизации с контроллером домена (DC) по умолчанию

**USAGE:** SetTimeSyncFromDC.bat

Скрипт использует вызов стандартной утилиты w32tm.exe

Существует несколько вариантов работы службы SNTP, входящей в Windows:

 - Иерархическая (NT5DS). Используется по умолчанию для всех компьютеров,
объединённых в домен. Синхронизация времени на рабочих станциях и серверах
домена производится по иерархии. Таким образом, рабочие станции и рядовые
серверы синхронизируются с контроллером домена, аутентифицировавшим вход,
контроллеры домена - с хозяином операции <эмулятор PDC>, который в свою
очередь синхронизируется с контроллером домена, стоящим на более высоком
уровне иерархии. Следует заметить, что данный порядок синхронизации
используется <по умолчанию> и может быть переопределён вручную или с
использованием групповых политик.

 - Принудительная синхронизация с выбранным NTP-сервером (NTP). В данном
случае источник эталонного времени для службы Windows Time устанавливается
либо вручную, либо с помощью групповых политик.

 - Отключение синхронизации (NoSync). Этот режим необходим для смешанной
схемы поддержания времени, в которой для синхронизации с внешним источником
используется продукт третьей фирмы, а для поддержания времени в рамках
домена используется Windows Time.

Настройки службы Windows Time хранятся в реестре Windows в разделе

`HKLM\SYSTEM\CurrentControlSet\Services\W32Time"`

В корне раздела определяются параметры работы самой службы, в подключе
*Config* - настройки, связанные с работой самого протокола SNTP.

Режим синхронизации определяется в подключе *Parameters*. Настройки
SNTP-клиента и сервера находятся в подключах TimeProviders\NtpClient и
TimeProviders\NtpServer соответственно. Рассмотрим основные значения,
определяющие настройку NTP клиента и сервера:

 - Type - определяет режим работы NTP-клиента:

   - NTDS5   - иерархическая;

   - NTP     - вручную;

   - NoSync  - не синхронизировать;

   - AllSync - доступны все типы синхронизации.

 - Enabled - определяет, включён ли данный компонент (клиент или сервер);

 - CrossSiteSyncFlags - определяет, можно ли синхронизировать время с
источником, находящимся за пределами домена, в случае если используется
иерархическая синхронизация:

   - 0 - нельзя;

   - 1 - только с эмулятором PDC;

   - 2 - со всеми.

 - EventLogFlags - определяет, будут ли сообщения от Windows Time заносится

в журнал или нет.



#### SetTimeSyncFromSrc.bat

Установка синхронизации времени из источников

**USAGE:** SetTimeSyncFromSrc.bat [ntp_server1 [ntp_server2] ..]

Скрипт использует вызов системной утилиты w32tm.exe

Существует несколько вариантов работы службы SNTP, входящей в Windows:

 - Иерархическая (NT5DS). Используется по умолчанию для всех компьютеров,
объединённых в домен. Синхронизация времени на рабочих станциях и серверах
домена производится по иерархии. Таким образом, рабочие станции и рядовые
серверы синхронизируются с контроллером домена, аутентифицировавшим вход,
контроллеры домена - с хозяином операции <эмулятор PDC>, который в свою
очередь синхронизируется с контроллером домена, стоящим на более высоком
уровне иерархии. Следует заметить, что данный порядок синхронизации
используется <по умолчанию> и может быть переопределён вручную или с
использованием групповых политик.

 - Принудительная синхронизация с выбранным NTP-сервером (NTP). В данном
случае источник эталонного времени для службы Windows Time устанавливается
либо вручную, либо с помощью групповых политик.

 - Отключение синхронизации (NoSync). Этот режим необходим для смешанной
схемы поддержания времени, в которой для синхронизации с внешним источником
используется продукт третьей фирмы, а для поддержания времени в рамках
домена используется Windows Time.

Настройки службы Windows Time хранятся в реестре Windows в разделе
`HKLM\SYSTEM\CurrentControlSet\Services\W32Time`.

В корне раздела определяются параметры работы самой службы, в подключе
*Config* - настройки, связанные с работой самого протокола SNTP.

Режим синхронизации определяется в подключе *Parameters*. Настройки
SNTP-клиента и сервера находятся в подключах TimeProviders\NtpClient и
TimeProviders\NtpServer соответственно. Рассмотрим основные значения,
определяющие настройку NTP клиента и сервера:

 - Type - определяет режим работы NTP-клиента:

   - NTDS5   - иерархическая;

   - NTP     - вручную;

   - NoSync  - не синхронизировать;

   - AllSync - доступны все типы синхронизации.

 - Enabled - определяет, включён ли данный компонент (клиент или сервер);

 - CrossSiteSyncFlags - определяет, можно ли синхронизировать время с
источником, находящимся за пределами домена, в случае если используется
иерархическая синхронизация:

   - 0 - нельзя;

   - 1 - только с эмулятором PDC;

   - 2 - со всеми.

 - EventLogFlags - определяет, будут ли сообщения от Windows Time заносится
в журнал или нет.



#### SetTimeSyncParams.bat

Установить параметры синхронизации времени по умолчанию

**USAGE:** SetTimeSyncParams.bat

Скрипт использует вызовы ранее определённых скриптов.



#### SetToggleCS.bat

Устанавливает переключатель раскладки клавиатуры в Ctrl+Shift

**USAGE:** SetToggleCS.bat 

Скрипт использует вызов системной утилиты reg.exe



#### SetUACPolicy.bat

Управляет политикой контроля доступа пользователя

**USAGE:** SetUACPolicy.bat disable|enable|default

Скрипт использует вызов системной утилиты reg.exe

Настройки групповых политик контроля учётных записей

----------------------------------------------------

http://dimanb.wordpress.com/2010/02/16/настройки-групповых-политик-контрол/



RegKey *RegValue:Disable/Enable/Default* PolicyName

------ ------------------------------- -----------------------------------------------------------------------------------------------

EnableLUA                     *0/1/1*    Все администраторы работают в режиме одобрения администратором (UAC for users)

EnableInstallerDetection      *0/1/1*    Обнаружение установки приложений и запрос на повышение прав

PromptOnSecureDesktop         *0/0/1*    Переключение к безопасному рабочему столу при выполнении запроса на повышение прав

ConsentPromptBehaviorAdmin    *0/0/5*    Поведение запроса на повышение прав для администраторов в режиме одобрения администратором

ConsentPromptBehaviorUser     *3/3/3*    Поведение запроса на повышение прав для обычных пользователей

EnableSecureUIAPaths          *0/1/1*    Повышать права для UIAccess-приложений только при установке в безопасных местах

ValidateAdminCodeSignatures   *0/0/0*    Повышение прав только для подписанных и проверенных исполняемых файлов

EnableVirtualization          *1/1/1*    При сбоях записи в файл или реестр виртуализация в место размещения пользователя

EnableUIADesktopToggle        *1/1/0*    Разрешить UIAccess-приложениям запрашивать повышение прав, не используя безопасный рабочий стол

FilterAdministratorToken      *0/0/0*    Режим одобрения администратором для встроенной учётной записи администратора (UAC for admin)

LocalAccountTokenFilterPolicy *1/1/0*    Разрешить членам группы лок. администраторов административные подключения к удалённым компьютерам с полными правами

В этой статье рассказывается обо всех возможных настройках контроля учётных
записей пользователей. Рассмотрены все десять параметров политики
безопасности, которые отвечают за все возможные действия, связанные с UAC.
Кроме настройки контроля учётных записей при помощи групповой политики,
также рассмотрены эквивалентные им твики реестра.



#### ShortFileNames.bat

Включение,выключение создания коротких имён файлов на всех NTFS томах

**USAGE:** ShortFileNames.bat disable|enable

Скрипт использует вызов системной утилиты reg.exe



#### ShowInactiveUsers.bat

Показывает неактивных пользователей системы за период [rdn [24weeks]]

**USAGE:** ShowInactiveUsers.bat [dn|rdn|upn|samid [weeks]]

Скрипт использует вызов стандартной программы dsquery.exe



#### ShowInterfaces.bat

Показывает сетевые интерфейсы в виде таблицы

**USAGE:** ShowInterfaces.bat 

Функция использует вызов системной утилиты netsh.exe



#### ShowLoggedUsers.bat

Показывает залогиненых пользователей в системе

**USAGE:** ShowLoggedUsers.bat

Скрипт использует вызов стандартной функции tasklist.exe



#### ShowPrinters.bat

Показывает принтеры, подключённые к сети (только реальные, не виртуальные принтеры)

**USAGE:** ShowPrinters.bat [real]

Скрипт использует вызовы стандартных утилит reg.exe, find.exe и сторонней утилиты sed.exe



#### ShowRunRegKeys.bat

Показывает записи ключа «Run» системного реестра, управляющего автозапуском

**USAGE:** ShowRunRegKeys.bat

Скрипт использует вызов стандартных утилит reg.exe и find.exe



#### ShowTrustedSites.bat

Показывает доверенные сайты для Internet Explorer

**USAGE:** ShowTrustedSites.bat 

Скрипт использует вызов системных утилит reg.exe и find.exe



#### ShowUsersProfiles.bat

Показывает профили пользователей системы

**USAGE:** ShowUsersProfiles.bat

Скрипт использует вызов встроенной команды cd



#### SIADebugTracing.bat

Включение и выключение отладочной трассировки Помощника подключения к онлайн сервисам Microsoft

**USAGE:** SIADebugTracing.bat disable|enable

Скрипт использует вызов системной утилиты reg.exe



#### Software.bat

Удаление программного обеспечения из системы [показывает список установленного ПО]

**USAGE:** Software.bat [uninstall name]

Скрипт использует вызовы различных системных программ и плотно работает с реестром



#### StopReplicationOnAutoRecovery.bat

Остановка автоматической репликации DFS после автоматического восстановления после сбоя

**USAGE:** StopReplicationOnAutoRecovery.bat disable|enable

Скрипт использует вызов системной утилиты reg.exe и скриптов EchoSucc.bat и EchoFail.bat



#### Svc.bat

Управление службами Windows [показывает список запущенных служб]

**USAGE:** Svc.bat [delete|disable|auto|demand|stop|start|check service_name]

Скрипт использует вызовы системных функций sc.exe, findstr.exe и find.exe



#### Svc_w32time.bat

Регистрация и удаление службы w32time

**USAGE:** Svc_w32time.bat unregister|register

Скрипт использует вызов системных утилит w32tm.exe и find.exe



#### SyncTime.bat

Синхронизирует время компьютера

**USAGE:** SyncTime.bat 

Скрипт использует вызов системной функции w32.tm.exe, find.exe, командных файлов EchoSucc и EchoFail





#### SysFiles.bat

Защищает и снимает защиту с системных файлов Misrosoft Windows

**USAGE:** SysFiles.bat protect|unprotect

Скрипт использует вызовы системной утилиты attrib.exe и скрипта SetAccessMode.bat



#### contig.exe

Утилита дефрагментации определённого файла или файлов



#### ddriverc.exe

Программа Double Driver для резервного копирования драйверов



#### hidec.exe

Программа скрывает консоль Windows запускаемой программы и ждёт (опционально) её завершения

**USAGE:** hidec [/w] filename

где опция `/w` заставляет ожидать завершение программы

`filename` файл запускаемой программы



#### hs_color.exe

Программа для изменения цвета выводимых символов на консоли



#### hs_echo.exe

Вывод строки текста на экран без перевода строки



#### regjump.exe

Программа перевода файла regedit на заданную ветвь (из пакета sysinternals)



#### rsync.exe

rsync это программа пересылки файла с возможностью эффективного удалённого обновления по различным быстрым алгоритмам. Может также работать как служба.



#### usbitcmd.exe

Программа для резервного копирования и восстановления из архива со съёмного USB устройства на жёсткий диск, а также показа всех съёмных носителей, подключённых к системе.

