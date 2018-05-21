@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Management system or user paths
set USAGE=show/set/delete/add/normalize system/user [path]

setlocal
if /I "%~2"=="SYSTEM" (
  set PATH_TYPE=system
  goto Next
)
if /I "%~2"=="USER" (
  set PATH_TYPE=user
  goto Next
)
exit /B 255

:Next
set MYPATH=%~3
if /I "%~1"=="SHOW" (
  call :Show_Path "%PATH_TYPE%"
  exit /B
)
if /I "%~1"=="SET" (
  call :Set_Path "MYPATH" "%PATH_TYPE%"
  if errorlevel 1 (
    call EchoFail Set %PATH_TYPE% path "%MYPATH%"
    exit /B 1
  ) else (
    call EchoSucc Set %PATH_TYPE% path "%MYPATH%"
    exit /B 0
  )
)
if /I "%~1"=="DELETE" (
  call :Delete_From_Path "%PATH_TYPE%" "%MYPATH%"
  if errorlevel 1 (
    call EchoFail Delete from %PATH_TYPE% path "%MYPATH%"
    exit /B 1
  ) else (
    call EchoSucc Delete from %PATH_TYPE% path "%MYPATH%"
    exit /B 0
  )
)
if /I "%~1"=="ADD" (
  call :Add_To_Path "%PATH_TYPE%" "%MYPATH%"
  if errorlevel 1 (
    call EchoFail Add to %PATH_TYPE% path "%MYPATH%"
    exit /B 1
  ) else (
    call EchoSucc Add to %PATH_TYPE% path "%MYPATH%"
    exit /B 0
  )
)
if /I "%~1"=="NORMALIZE" (
  call :Normalize_Path "%PATH_TYPE%"
  if errorlevel 1 (
    call EchoFail Normalize %PATH_TYPE% path
    exit /B 1
  ) else (
    call EchoSucc Normalize %PATH_TYPE% path
    exit /B 0
  )
)
exit /B 255


:: Delete_From_Path "system"/"user" subpath
:Delete_From_Path
if "%~2"=="" exit /B 255
setlocal
set mysubpath=%~2
call :Get_Path           "mypath" "%~1"
call :Normalize_Path_Var "mypath"
set mypath=;%mypath%
set mypath=%mypath:;=;;%
call :Normalize_Path_Var "mysubpath"
if not "%mysubpath%"=="" (
  call :Delete_SubStr    "mypath" ";%mysubpath%"
)
call :Normalize_Path_Var "mypath"
call :Set_Path           "mypath" "%~1"
endlocal
exit /B

:: Add_To_Path "system"/"user" subpath
:Add_To_Path
if "%~2"=="" exit /B 255
setlocal
set mysubpath=%~2
call :Get_Path           "mypath" "%~1"
call :Normalize_Path_Var "mypath"
set mypath=;%mypath%
set mypath=%mypath:;=;;%
call :Normalize_Path_Var "mysubpath"
if not "%mysubpath%"=="" (
  call :Delete_SubStr    "mypath" ";%mysubpath%"
  call :Add_SubStr       "mypath" "%mysubpath%"
)
call :Normalize_Path_Var "mypath"
call :Set_Path           "mypath" "%~1"
endlocal
exit /B

:: Normalize_Path "system"/"user"
:Normalize_Path
if "%~1"=="" exit /B 255
setlocal
call :Get_Path           "mypath" "%~1"
call :Normalize_Path_Var "mypath"
if /I "%~1"=="SYSTEM" (
  if not defined mypath (
    set mypath=%%SYSTEMROOT%%\SYSTEM32;%%SYSTEMROOT%%;%%SYSTEMROOT%%\SYSTEM32\WBEM;
  )
)
call :Set_Path           "mypath" "%~1"
endlocal
exit /B

:: Show_Path "system"/"user"
:Show_Path
if "%~1"=="" exit /B 255
setlocal
call :Get_Path "mypath" "%~1"
echo.%mypath%
endlocal
exit /B

:: Get_Path var "system"/"user"
:Get_Path
if "%~1"=="" exit /B 255
if /I "%~2"=="SYSTEM" goto Get_Path_System
if /I "%~2"=="USER"   goto Get_Path_User
exit /B 255
:Get_Path_System
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"') do if /I "%%i"=="Path" set %~1=%%k
reg.exe>nul 2>nul query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" || (
  if /I "%DEBUG%"=="YES" reg.exe>nul query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
)
exit /B
:Get_Path_User
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKCU\Environment"') do if /I "%%i"=="Path" set %~1=%%k
reg.exe>nul 2>nul query "HKCU\Environment" || (
  if /I "%DEBUG%"=="YES" reg.exe>nul query "HKCU\Environment"
)
exit /B

:: Set_Path var "system"/"user"
:Set_Path
if /I "%~2"=="SYSTEM" (
  call :Set_Path_System "%%%~1%%"
  exit /B
)
if /I "%~2"=="USER" (
  call :Set_Path_User   "%%%~1%%"
  exit /B
)
exit /B 255
:Set_Path_System
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /V "Path" /T REG_EXPAND_SZ /D "%~1" /F || (
  if /I "%DEBUG%"=="YES" reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /V "Path" /T REG_EXPAND_SZ /D "%~1" /F
)
exit /B
:Set_Path_User
reg.exe>nul 2>nul add "HKCU\Environment" /V "Path" /T REG_EXPAND_SZ /D "%~1" /F || (
  if /I "%DEBUG%"=="YES" reg.exe add "HKCU\Environment" /V "Path" /T REG_EXPAND_SZ /D "%~1" /F
)
exit /B

:: Normalize_Path_Var var
:Normalize_Path_Var
if "%~1"=="" exit /B 255
call :Normalize_Path_Var2 "%~1" "%%%~1%%"
set %~1=%Normalize_Path_Var_Result%
exit /B 0
:Normalize_Path_Var2
set Normalize_Path_Var_Result=%~2;
:Normalize_Path_Var2_Loop1
:: Удаляем " " перед ";".
if not defined Normalize_Path_Var_Result exit /B
set Normalize_Path_Var_Result=%Normalize_Path_Var_Result: ;=;%
if not "%Normalize_Path_Var_Result%"=="%Normalize_Path_Var_Result: ;=;%"   goto Normalize_Path_Var2_Loop1
:: Удаляем " " после ";".
if not defined Normalize_Path_Var_Result exit /B
set Normalize_Path_Var_Result=%Normalize_Path_Var_Result:; =;%
if not "%Normalize_Path_Var_Result%"=="%Normalize_Path_Var_Result:; =;%"   goto Normalize_Path_Var2_Loop1
:: Удаляем "\" перед ";".
if not defined Normalize_Path_Var_Result exit /B
set Normalize_Path_Var_Result=%Normalize_Path_Var_Result:\;=;%
if not "%Normalize_Path_Var_Result%"=="%Normalize_Path_Var_Result:\;=;%"   goto Normalize_Path_Var2_Loop1
:: Удаляем лишние ";".
if not defined Normalize_Path_Var_Result exit /B
set Normalize_Path_Var_Result=%Normalize_Path_Var_Result:;;=;%
if not "%Normalize_Path_Var_Result%"=="%Normalize_Path_Var_Result:;;=;%"   goto Normalize_Path_Var2_Loop1
:: Удаляем " " из начала строки.
if not defined Normalize_Path_Var_Result exit /B
if "%Normalize_Path_Var_Result:~0,1%"==" " (
  set Normalize_Path_Var_Result=%Normalize_Path_Var_Result:~1%
  goto Normalize_Path_Var2_Loop1
)
:: Удаляем ";" из начала строки.
if not defined Normalize_Path_Var_Result exit /B
if "%Normalize_Path_Var_Result:~0,1%"==";" (
  set Normalize_Path_Var_Result=%Normalize_Path_Var_Result:~1%
  goto Normalize_Path_Var2_Loop1
)
:: Удаляем " " из конца строки.
if not defined Normalize_Path_Var_Result exit /B
if "%Normalize_Path_Var_Result:~-1%"==" " (
  set Normalize_Path_Var_Result=%Normalize_Path_Var_Result:~0,-1%
  goto Normalize_Path_Var2_Loop1
)
:Normalize_Path_Var2_Loop2
:: Добавляем "\" после ":" если их нет.
if not defined Normalize_Path_Var_Result exit /B
set Normalize_Path_Var_Result=%Normalize_Path_Var_Result::;=:\;%
if not "%Normalize_Path_Var_Result%"=="%Normalize_Path_Var_Result::;=:\;%" goto Normalize_Path_Var2_Loop2
exit /B

:: Add_SubStr var substr
:Add_SubStr
if "%~2"=="" exit /B 255
call :Add_SubStr2 "%~1" "%%%~1%%%~2"
exit /B 0
:Add_SubStr2
set %~1=%~2
exit /B 0

:: Delete_SubStr var substr
:Delete_SubStr
if "%~2"=="" exit /B 255
call :Delete_SubStr2 "%~1" "%%%~1:%~2=%%"
exit /B 0
:Delete_SubStr2
set %~1=%~2
exit /B 0

:Finish
