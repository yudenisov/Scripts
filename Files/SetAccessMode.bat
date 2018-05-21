@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set access mode for file or directory
set USAGE=file_or_dir [read/write/full]

call :Set_Access_Mode "%~1" "%~2"
goto Finish


:Set_Access_Mode
if "%~1"=="" exit /B 255
if not exist "%~1" exit /B 2
if "%~2"=="" (
  cacls.exe "%~1"
  exit /B 0
)
if /I "%~2"=="READ" (
  set MODE=R
  set MODE_NAME=Read
  goto Set_Access_Mode_Begin
)
if /I "%~2"=="WRITE" (
  set MODE=W
  set MODE_NAME=Write
  goto Set_Access_Mode_Begin
)
if /I "%~2"=="FULL" (
  set MODE=F
  set MODE_NAME=Full
  goto Set_Access_Mode_Begin
)
exit /B 255
:Set_Access_Mode_Begin
call>nul SetOwner "%~1"
set CACLS_KEYS=/C /E /P
call>nul Directory Check "%~1" && set CACLS_KEYS=/T /C /E /P
cacls.exe>nul 2>nul "%~1" %CACLS_KEYS% "SYSTEM":%MODE%
cacls.exe>nul 2>nul "%~1" %CACLS_KEYS% "Администраторы":%MODE%
cacls.exe>nul 2>nul "%~1" %CACLS_KEYS% "Administrators":%MODE%
cacls.exe>nul 2>nul "%~1" %CACLS_KEYS% "Администратор":%MODE%
cacls.exe>nul 2>nul "%~1" %CACLS_KEYS% "Administrator":%MODE%
cacls.exe>nul 2>nul "%~1" %CACLS_KEYS% "Admin":%MODE%
cacls.exe>nul 2>nul "%~1" %CACLS_KEYS% "Опытные пользователи":%MODE%
cacls.exe>nul 2>nul "%~1" %CACLS_KEYS% "Power users":%MODE%
cacls.exe>nul 2>nul "%~1" %CACLS_KEYS% "Пользователи":%MODE%
cacls.exe>nul 2>nul "%~1" %CACLS_KEYS% "Users":%MODE%
cacls.exe>nul 2>nul "%~1" %CACLS_KEYS% "Все":%MODE%
cacls.exe>nul 2>nul "%~1" %CACLS_KEYS% "All":%MODE%
cacls.exe>nul 2>nul "%~1" %CACLS_KEYS% "%USERNAME%":%MODE% && (
  call EchoSucc Set access mode "%MODE_NAME%" to "%~1"
  exit /B 0
)
call EchoFail Set access mode "%MODE_NAME%" to "%~1"
if /I "%DEBUG%"=="YES" (
  cacls.exe "%~1" %CACLS_KEYS% "%USERNAME%":%MODE%
)
exit /B 1

:: CACLS имяФайла [/T] [/E] [/C] [/G имя:доступ] [/R имя [...]]
::
::                [/P имя:доступ [...]] [/D имя [...]]
::
::    имяФайла       Вывод таблиц управления доступом.
::
::    /T             Замена таблиц управления доступом для указанных файлов
::                   в текущем каталоге и всех подкаталогах.
::
::    /E             Изменение таблицы управления доступом вместо ее замены.
::
::    /C             Продолжение при ошибках отказа в доступе.
::
::    /G имя:доступ  Определение разрешений для указанных пользователей.
::                   "доступ": R  Чтение
::                             W  Запись
::                             C  Изменение (запись)
::                             F  Полный доступ
::
::    /R имя         Отзыв разрешений для пользователя (только вместе с /E).
::
::    /P имя:доступ  Замена разрешений для указанного пользователя.
::                   "доступ": N  Отсутствует
::                             R  Чтение
::                             W  Запись
::                             C  Изменение (запись)
::                             F  Полный доступ
::    /D имя         Запрет на доступ для указанного пользователя.
::
:: В результате выполнения команды указанному пользователю будет предоставлен
:: полный доступ к папке System Volume Information.
:: cacls "C:\System Volume Information" /E /G имя_пользователя:F
::
:: В результате выполнения команды полномочия указанного пользователя будут
:: аннулированы.
:: cacls "C:\System Volume Information" /E /R имя_пользователя

:Finish
