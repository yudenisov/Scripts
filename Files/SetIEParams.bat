@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set IE parameters
set USAGE=

call :Set_IE_Params
goto Finish

:Set_IE_Params
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
  :: Отключить сообщение "Остановить выполнение этого сценария?"
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Styles"         /V "MaxScriptStatements"                /T REG_DWORD /D "0xFFFFFFFF"            /F || goto Set_IE_Params_Fail
  :: Отключить сообщение об автозаполнении
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\IntelliForms"   /V "AskUser"                            /T REG_DWORD /D "0"                     /F || goto Set_IE_Params_Fail
  :: Отключить автоматическое скрытие верхней панели
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "AutoHide"                           /T REG_SZ    /D "no"                    /F || goto Set_IE_Params_Fail
  :: Отключить отладку сценариев (другие)
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Disable Script Debugger"            /T REG_SZ    /D "yes"                   /F || goto Set_IE_Params_Fail
  :: Отключить отладку сценариев (IE)
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "DisableScriptDebuggerIE"            /T REG_SZ    /D "yes"                   /F || goto Set_IE_Params_Fail
  :: Не выполнять настройку при первом запуске
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "DisableFirstRunCustomize"           /T REG_DWORD /D "1"                     /F || goto Set_IE_Params_Fail
  :: Не показывать уведомление о каждой ошибке сценария
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Error Dlg Displayed On Every Error" /T REG_SZ    /D "no"                    /F || goto Set_IE_Params_Fail
  :: Не показывать страницу знакомства с браузером
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "IE9TourNoShow"                      /T REG_DWORD /D "1"                     /F || goto Set_IE_Params_Fail
  :: Не отправлять отчеты об ошибках
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "IEWatsonDisabled"                   /T REG_DWORD /D "1"                     /F || goto Set_IE_Params_Fail
  :: Домашняя страница
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Default_Page_URL"                   /T REG_SZ    /D "http://www.google.ru/" /F || goto Set_IE_Params_Fail
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Default_Search_URL"                 /T REG_SZ    /D "http://www.google.ru"  /F || goto Set_IE_Params_Fail
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Search Bar"                         /T REG_SZ    /D "http://www.google.ru/" /F || goto Set_IE_Params_Fail
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Search Page"                        /T REG_SZ    /D "http://www.google.ru/" /F || goto Set_IE_Params_Fail
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Start Page"                         /T REG_SZ    /D "http://www.google.ru/" /F || goto Set_IE_Params_Fail
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Search"         /V "SearchAssistant"                    /T REG_SZ    /D "http://www.google.ru/" /F || goto Set_IE_Params_Fail
  reg.exe>nul 2>nul delete "%%~i\Software\Microsoft\Internet Explorer\Search"         /V "CustomizeSearch"                                                            /F
  :: Включить автозаполнение форм
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Use FormSuggest"                    /T REG_SZ    /D "yes"                   /F || goto Set_IE_Params_Fail
  :: Не открывать браузер в полноэкранном режиме
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "FullScreen"                         /T REG_SZ    /D "no"                    /F || goto Set_IE_Params_Fail
  :: Уведомлять об окончании загрузки
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "NotifyDownloadComplete"             /T REG_SZ    /D "yes"                   /F || goto Set_IE_Params_Fail
  :: Использовать плавную прокрутку
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "SmoothScroll"                       /T REG_DWORD /D "1"                     /F || goto Set_IE_Params_Fail
  :: Не сообщать, если IE не используется по умолчанию
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Check_Associations"                 /T REG_SZ    /D "no"                    /F || goto Set_IE_Params_Fail
  :: Включить фильтр SmartScreen
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\PhishingFilter" /V "EnabledV9"                          /T REG_DWORD /D "1"                     /F || goto Set_IE_Params_Fail
  :: Разрешить вкладки
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\TabbedBrowsing" /V "Enabled"                            /T REG_DWORD /D "1"                     /F || goto Set_IE_Params_Fail
  :: Удалить поисковик NightWarez.ru
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{6DC2596C-844E-40F3-BDD2-B69867CF9788}" /V "Deleted"             /T REG_DWORD /D "1"                                                 /F || goto Set_IE_Params_Fail
  :: Удалить поисковик Live Search
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{0633EE93-D776-472f-A0FF-E1416B8B2E3A}" /V "Deleted"             /T REG_DWORD /D "1"                                                 /F || goto Set_IE_Params_Fail
  :: Удалить поисковик Microsoft
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{FA6CC280-3AEA-4DC3-9C5B-9B729779EC31}" /V "Deleted"             /T REG_DWORD /D "1"                                                 /F || goto Set_IE_Params_Fail
  :: Удалить поисковик Yandex
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{95F663C0-C370-4955-8B39-63069DB1F6C0}" /V "Deleted"             /T REG_DWORD /D "1"                                                 /F || goto Set_IE_Params_Fail
  :: Добавить поисковик Google
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{B2A025AA-2242-4E2F-8FC6-6DC64A736A80}" /V "DisplayName"         /T REG_SZ    /D "Google"                                            /F || goto Set_IE_Params_Fail
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{B2A025AA-2242-4E2F-8FC6-6DC64A736A80}" /V "URL"                 /T REG_SZ    /D "http://www.google.ru/search?hl=ru&q={searchTerms}" /F || goto Set_IE_Params_Fail
  reg.exe>nul 2>nul delete "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{B2A025AA-2242-4E2F-8FC6-6DC64A736A80}" /V "SuggestionsURL_JSON"                                                                     /F
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{B2A025AA-2242-4E2F-8FC6-6DC64A736A80}" /V "FaviconURL"          /T REG_SZ    /D "http://www.google.com/favicon.ico"                 /F || goto Set_IE_Params_Fail
  :: Назначить Google поисковиком по умолчанию (обязательно использование предыдущего твика)
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes" /V "DefaultScope"                                               /T REG_SZ    /D "{B2A025AA-2242-4E2F-8FC6-6DC64A736A80}"            /F || goto Set_IE_Params_Fail
  :: Включить варианты для Google (обязательно использование предыдущих двух твиков)
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes" /V "ShowSearchSuggestionsGlobal"                                /T REG_DWORD /D "1"                                                 /F || goto Set_IE_Params_Fail
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes" /V "ShowSearchSuggestionsInAddressGlobal"                       /T REG_DWORD /D "1"                                                 /F || goto Set_IE_Params_Fail
  :: Отключить предупреждение о начале просмотра веб-страницы через безопасное соединение (HTTPS)
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Windows\CurrentVersion\Internet Settings"                      /V "WarnOnZoneCrossing" /T REG_DWORD /D "0"      /F || goto Set_IE_Params_Fail
  :: Кэш для временных файлов = 250 Мб
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Windows\CurrentVersion\Internet Settings\5.0\Cache\Content"    /V "CacheLimit"         /T REG_DWORD /D "256000" /F || goto Set_IE_Params_Fail
  reg.exe>nul 2>nul add    "%%~i\Software\Microsoft\Windows\CurrentVersion\Internet Settings\5.0\LowCache\Content" /V "CacheLimit"         /T REG_DWORD /D "256000" /F || goto Set_IE_Params_Fail
)
:: Домашняя страница
reg.exe>nul 2>nul add      "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main"   /V "AutoHide"           /T REG_SZ /D "no"                    /F || goto Set_IE_Params_Fail
reg.exe>nul 2>nul add      "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main"   /V "Default_Page_URL"   /T REG_SZ /D "http://www.google.ru/" /F || goto Set_IE_Params_Fail
reg.exe>nul 2>nul add      "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main"   /V "Default_Search_URL" /T REG_SZ /D "http://www.google.ru"  /F || goto Set_IE_Params_Fail
reg.exe>nul 2>nul add      "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main"   /V "Search Bar"         /T REG_SZ /D "http://www.google.ru/" /F || goto Set_IE_Params_Fail
reg.exe>nul 2>nul add      "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main"   /V "Search Page"        /T REG_SZ /D "http://www.google.ru/" /F || goto Set_IE_Params_Fail
reg.exe>nul 2>nul add      "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main"   /V "Start Page"         /T REG_SZ /D "http://www.google.ru/" /F || goto Set_IE_Params_Fail
reg.exe>nul 2>nul add      "HKLM\SOFTWARE\Microsoft\Internet Explorer\Search" /V "SearchAssistant"    /T REG_SZ /D "http://www.google.ru/" /F || goto Set_IE_Params_Fail
reg.exe>nul 2>nul delete   "HKLM\SOFTWARE\Microsoft\Internet Explorer\Search" /V "CustomizeSearch"                                         /F
:: Устранение последствий вирусов. Симптомы: на любой адрес открывается один и тот же зловредный сайт
reg.exe>nul 2>nul add      "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\URL\DefaultPrefix" /VE          /T REG_SZ /D "http://"   /F || goto Set_IE_Params_Fail
reg.exe>nul 2>nul add      "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\URL\Prefixes"      /V  "ftp"    /T REG_SZ /D "ftp://"    /F || goto Set_IE_Params_Fail
reg.exe>nul 2>nul add      "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\URL\Prefixes"      /V  "gopher" /T REG_SZ /D "gopher://" /F || goto Set_IE_Params_Fail
reg.exe>nul 2>nul add      "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\URL\Prefixes"      /V  "home"   /T REG_SZ /D "http://"   /F || goto Set_IE_Params_Fail
reg.exe>nul 2>nul add      "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\URL\Prefixes"      /V  "mosaic" /T REG_SZ /D "http://"   /F || goto Set_IE_Params_Fail
reg.exe>nul 2>nul add      "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\URL\Prefixes"      /V  "www"    /T REG_SZ /D "http://"   /F || goto Set_IE_Params_Fail
call EchoSucc Set IE parameters
exit /B 0
:Set_IE_Params_Fail
call EchoFail Set IE parameters
if /I "%DEBUG%"=="YES" (
  for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Styles"         /V "MaxScriptStatements"                /T REG_DWORD /D "0xFFFFFFFF"            /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\IntelliForms"   /V "AskUser"                            /T REG_DWORD /D "0"                     /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "AutoHide"                           /T REG_SZ    /D "no "                   /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Disable Script Debugger"            /T REG_SZ    /D "yes"                   /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "DisableScriptDebuggerIE"            /T REG_SZ    /D "yes"                   /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "DisableFirstRunCustomize"           /T REG_DWORD /D "1"                     /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Error Dlg Displayed On Every Error" /T REG_SZ    /D "no"                    /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "IE9TourNoShow"                      /T REG_DWORD /D "1"                     /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "IEWatsonDisabled"                   /T REG_DWORD /D "1"                     /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Default_Page_URL"                   /T REG_SZ    /D "http://www.google.ru/" /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Default_Search_URL"                 /T REG_SZ    /D "http://www.google.ru"  /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Search Bar"                         /T REG_SZ    /D "http://www.google.ru/" /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Search Page"                        /T REG_SZ    /D "http://www.google.ru/" /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Start Page"                         /T REG_SZ    /D "http://www.google.ru/" /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Search"         /V "SearchAssistant"                    /T REG_SZ    /D "http://www.google.ru/" /F
    reg.exe delete "%%~i\Software\Microsoft\Internet Explorer\Search"         /V "CustomizeSearch"                                                            /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Use FormSuggest"                    /T REG_SZ    /D "yes"                   /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "FullScreen"                         /T REG_SZ    /D "no"                    /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "NotifyDownloadComplete"             /T REG_SZ    /D "yes"                   /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "SmoothScroll"                       /T REG_DWORD /D "1"                     /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\Main"           /V "Check_Associations"                 /T REG_SZ    /D "no"                    /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\PhishingFilter" /V "EnabledV9"                          /T REG_DWORD /D "1"                     /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\TabbedBrowsing" /V "Enabled"                            /T REG_DWORD /D "1"                     /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{6DC2596C-844E-40F3-BDD2-B69867CF9788}" /V "Deleted"                              /T REG_DWORD /D "1"                                                 /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{0633EE93-D776-472f-A0FF-E1416B8B2E3A}" /V "Deleted"                              /T REG_DWORD /D "1"                                                 /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{FA6CC280-3AEA-4DC3-9C5B-9B729779EC31}" /V "Deleted"                              /T REG_DWORD /D "1"                                                 /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{95F663C0-C370-4955-8B39-63069DB1F6C0}" /V "Deleted"                              /T REG_DWORD /D "1"                                                 /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{B2A025AA-2242-4E2F-8FC6-6DC64A736A80}" /V "DisplayName"                          /T REG_SZ    /D "Google"                                            /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{B2A025AA-2242-4E2F-8FC6-6DC64A736A80}" /V "URL"                                  /T REG_SZ    /D "http://www.google.ru/search?hl=ru&q={searchTerms}" /F
    reg.exe delete "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{B2A025AA-2242-4E2F-8FC6-6DC64A736A80}" /V "SuggestionsURL_JSON"                                                                                      /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes\{B2A025AA-2242-4E2F-8FC6-6DC64A736A80}" /V "FaviconURL"                           /T REG_SZ    /D "http://www.google.com/favicon.ico"                 /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes"                                        /V "DefaultScope"                         /T REG_SZ    /D "{B2A025AA-2242-4E2F-8FC6-6DC64A736A80}"            /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes"                                        /V "ShowSearchSuggestionsGlobal"          /T REG_DWORD /D "1"                                                 /F
    reg.exe add    "%%~i\Software\Microsoft\Internet Explorer\SearchScopes"                                        /V "ShowSearchSuggestionsInAddressGlobal" /T REG_DWORD /D "1"                                                 /F
    reg.exe add    "%%~i\Software\Microsoft\Windows\CurrentVersion\Internet Settings"                      /V "WarnOnZoneCrossing" /T REG_DWORD /D "0"      /F
    reg.exe add    "%%~i\Software\Microsoft\Windows\CurrentVersion\Internet Settings\5.0\Cache\Content"    /V "CacheLimit"         /T REG_DWORD /D "256000" /F
    reg.exe add    "%%~i\Software\Microsoft\Windows\CurrentVersion\Internet Settings\5.0\LowCache\Content" /V "CacheLimit"         /T REG_DWORD /D "256000" /F
  )
  reg.exe add      "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main"   /V "AutoHide"          /T REG_SZ /D "no"                    /F
  reg.exe add      "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main"   /V "Default_Page_URL"  /T REG_SZ /D "http://www.google.ru/" /F
  reg.exe add      "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main"   /V "Default_Search_URL"/T REG_SZ /D "http://www.google.ru"  /F
  reg.exe add      "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main"   /V "Search Bar"        /T REG_SZ /D "http://www.google.ru/" /F
  reg.exe add      "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main"   /V "Search Page"       /T REG_SZ /D "http://www.google.ru/" /F
  reg.exe add      "HKLM\SOFTWARE\Microsoft\Internet Explorer\Main"   /V "Start Page"        /T REG_SZ /D "http://www.google.ru/" /F
  reg.exe add      "HKLM\SOFTWARE\Microsoft\Internet Explorer\Search" /V "SearchAssistant"   /T REG_SZ /D "http://www.google.ru/" /F
  reg.exe delete   "HKLM\SOFTWARE\Microsoft\Internet Explorer\Search" /V "CustomizeSearch"                                        /F
  reg.exe add      "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\URL\DefaultPrefix" /VE          /T REG_SZ /D "http://"   /F
  reg.exe add      "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\URL\Prefixes"      /V  "ftp"    /T REG_SZ /D "ftp://"    /F
  reg.exe add      "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\URL\Prefixes"      /V  "gopher" /T REG_SZ /D "gopher://" /F
  reg.exe add      "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\URL\Prefixes"      /V  "home"   /T REG_SZ /D "http://"   /F
  reg.exe add      "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\URL\Prefixes"      /V  "mosaic" /T REG_SZ /D "http://"   /F
  reg.exe add      "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\URL\Prefixes"      /V  "www"    /T REG_SZ /D "http://"   /F
)
exit /B 1

:Finish
