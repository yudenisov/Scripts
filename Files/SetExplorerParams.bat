@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Set explorer parameters
set USAGE=

call :Set_Explorer_Params
goto Finish


:Set_Explorer_Params
call>nul 2>nul :Hide_Explorer_Libraries || goto Set_Explorer_Params_Fail
call EchoSucc Set explorer parameters
exit /B 0
:Set_Explorer_Params_Fail
call EchoFail Set explorer parameters
if /I "%DEBUG%"=="YES" call :Hide_Explorer_Libraries
exit /B 1

:Hide_Explorer_Libraries
                             call>nul 2>nul :Delete_Reg_Key "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{031E4825-7B94-4dc3-B131-E946B44C8DD5}"             || goto Hide_Explorer_Libraries_Fail
if defined ProgramFiles(x86) call>nul 2>nul :Delete_Reg_Key "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" || goto Hide_Explorer_Libraries_Fail
call EchoSucc Hide libraries in Windows Explorer
exit /B 0
:Hide_Explorer_Libraries_Fail
call EchoFail Hide libraries in Windows Explorer
if /I not "%DEBUG%"=="YES" exit /B 1
                             reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{031E4825-7B94-4dc3-B131-E946B44C8DD5}"             /F
if defined ProgramFiles(x86) reg.exe delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" /F
exit /B 1

:Show_Explorer_Libraries
                             reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{031E4825-7B94-4dc3-B131-E946B44C8DD5}"             /VE                  /T REG_SZ /D "UsersLibraries"     /F || goto Show_Explorer_Libraries_Fail
                             reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{031E4825-7B94-4dc3-B131-E946B44C8DD5}"             /V "Removal Message" /T REG_SZ /D "@shell32.dll,-9047" /F || goto Show_Explorer_Libraries_Fail
if defined ProgramFiles(x86) reg.exe>nul 2>nul add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" /VE                  /T REG_SZ /D "UsersLibraries"     /F || goto Show_Explorer_Libraries_Fail
if defined ProgramFiles(x86) reg.exe>nul 2>nul add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" /V "Removal Message" /T REG_SZ /D "@shell32.dll,-9047" /F || goto Show_Explorer_Libraries_Fail
call EchoSucc Show libraries in Windows Explorer
exit /B 0
:Show_Explorer_Libraries_Fail
call EchoFail Show libraries in Windows Explorer
if /I not "%DEBUG%"=="YES" exit /B 1
                             reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{031E4825-7B94-4dc3-B131-E946B44C8DD5}"             /VE                  /T REG_SZ /D "UsersLibraries"     /F
                             reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{031E4825-7B94-4dc3-B131-E946B44C8DD5}"             /V "Removal Message" /T REG_SZ /D "@shell32.dll,-9047" /F
if defined ProgramFiles(x86) reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" /VE                  /T REG_SZ /D "UsersLibraries"     /F
if defined ProgramFiles(x86) reg.exe add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{031E4825-7B94-4dc3-B131-E946B44C8DD5}" /V "Removal Message" /T REG_SZ /D "@shell32.dll,-9047" /F
exit /B 1

:Delete_Reg_Key
if "%~1"=="" exit /B 255
reg.exe      delete "%~1" /F && exit /B 0
reg.exe 2>&1 delete "%~1" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "найти указанный раздел или параметр" && exit /B 0
reg.exe 2>&1 delete "%~1" /F|%SystemRoot%\System32\find.exe>nul 2>nul /I "эрщЄш єърчрээ√щ Ёрчфхы шыш ярЁрьхЄЁ" && exit /B 0
exit /B 1

:Finish
