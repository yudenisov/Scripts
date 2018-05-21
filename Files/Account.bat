@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Activate/delete/make account
set USAGE=activate/delete/make account [pass]

if /I "%~1"=="DELETE" (
  call :Delete_Account "%~2"
  goto Finish
)
if /I "%~1"=="MAKE" (
  call :Make_Account "%~2" "%~3"
  goto Finish
)
if /I "%~1"=="ACTIVATE" (
  call :Activate_Account "%~2"
  goto Finish
)
exit /B 255


:Activate_Account
if "%~1"=="" exit /B 255
set ACCOUNT=%~1
set ACCOUNT=%ACCOUNT:*\=%
if /I "%ACCOUNT%"=="Administrator" (
  net.exe>nul 2>nul user "Администратор" /EXPIRES:NEVER
  net.exe     2>&1  user "Администратор" /ACTIVE:YES|%SystemRoot%\System32\find.exe>nul 2>nul /I "выполнена успешно" && (
    call EchoSucc Activate account "Администратор"
    exit /B 0
  )
)
net.exe>nul 2>nul user "%ACCOUNT%" /EXPIRES:NEVER
net.exe     2>&1  user "%ACCOUNT%" /ACTIVE:YES|%SystemRoot%\System32\find.exe>nul 2>nul /I "выполнена успешно" && (
  call EchoSucc Activate account "%ACCOUNT%"
  exit /B 0
)
call EchoFail Activate account "%ACCOUNT%"
if /I "%DEBUG%"=="YES" (
  if /I "%ACCOUNT%"=="Administrator" net.exe user "Администратор" /ACTIVE:YES
                                     net.exe user "%~1"           /ACTIVE:YES
)
exit /B 1

:Delete_Account
if "%~1"=="" exit /B 255
set ACCOUNT=%~1
set ACCOUNT=%ACCOUNT:*\=%
net.exe 2>&1 user "%ACCOUNT%" /DELETE|findstr.exe>nul 2>nul /I "успешно не" && (
  call EchoSucc Delete account "%ACCOUNT%"
  exit /B 0
)
call EchoFail Delete account "%ACCOUNT%"
if /I "%DEBUG%"=="YES" net.exe user "%ACCOUNT%" /DELETE
exit /B 1

:Make_Account
if "%~1"=="" exit /B 255
if "%~2"=="" exit /B 255
set ACCOUNT=%~1
set ACCOUNT=%ACCOUNT:*\=%
net.exe 2>&1 user "%ACCOUNT%" "%~2" /Y /ADD|findstr.exe>nul 2>nul /I "успешно уже" && (
  net.exe>nul 2>nul user "%ACCOUNT%" "%~2"
  net.exe>nul 2>nul user "%ACCOUNT%" /EXPIRES:NEVER
  call EchoSucc Make account "%ACCOUNT%"
  exit /B 0
)
call EchoFail Make account "%ACCOUNT%"
if /I "%DEBUG%"=="YES" net.exe user "%ACCOUNT%" "%~2" /Y /ADD
exit /B 1

:Finish

::    В Windows 8, как и в предыдущих версиях клиентской  операционной  системы
:: Microsoft существует специальная встроенная учетная  запись  администратора,
:: которая по умолчанию скрыта. Эта учетная запись ("Administrator")  создается
:: при  установке  системы  и  переводится   в   состояние   <Отключена>.   Для
:: пользователя  создается   отдельная   учетная   запись,   также   обладающая
:: администраторскими   привилегиями   и   входящая    в    группу    локальных
:: администраторов, но в случае выполнения из-под этой учетной записи операций,
:: требующих административных полномочий, появляется запрос UAC  (User  Account
:: Control). Кроме того ряд системных каталогов и файлов просто нельзя  править
:: и удалять  из-под  этой  учетки,  даже  с  повышенными  правами.  Для  этого
:: приходится вручную модифицировать NTFS разрешения на данные объекты файловой
:: системы.
::
::    Встроенная учетная запись администратора обладает неограниченными правами
:: в системе и позволяет выполнять любые операции в системе без  ограничения  и
:: запросов UAC. Учетную запись  администратора  можно  (а  зачастую  и  нужно)
:: переименовать,  но  удалить  ее  нельзя.  Включить  скрытую  учетную  запись
:: администратора  в  Windows  8,  как  и  в  других  системах  Windows,  может
:: потребоваться для устранения каких-либо сложных неисправностей,  диагностики
:: работы системы или удаления вредоносного ПО.
::
::    Учетная запись администратора  в  Windows  8  отключена  по  соображениям
:: безопасности. В первую  очередь - чтобы  защитить  систему  от  некорректных
:: действий  пользователя  с  неограниченными  правами,   а   также   усложнить
:: вредоносным программам задачу заражения и внедрения в операционную систему.
::
::    По умолчанию у  встроенной  записи  администратора  нет  пароля,  поэтому
:: немедленно  смените  его  с  учетом требования сложности пароля. Активируйте
:: встроенного администратора только тогда, когда это действительно необходимо,
:: и сразу  после  выполнения  требуемых  операций  отключите  его.  Постоянно
:: работать под этой учеткой категорически не рекомендуется!
