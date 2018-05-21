@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Disable/enable short file names creation for all NTFS volumes
set USAGE=disable/enable

if /I "%~1"=="DISABLE" (
  call :Disable_Short_File_Names_Creation
  goto Finish
)
if /I "%~1"=="ENABLE" (
  call :Enable_Short_File_Names_Creation
  goto Finish
)
exit /B 255


:Disable_Short_File_Names_Creation
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsDisable8dot3NameCreation" /T REG_DWORD /D "1" /F && (
  call EchoSucc Disable short file names creation for all NTFS volumes
  exit /B 0
)
call EchoFail Disable short file names creation for all NTFS volumes
if /I "%DEBUG%"=="YES" reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsDisable8dot3NameCreation" /T REG_DWORD /D "1" /F
exit /B 1

:Enable_Short_File_Names_Creation
reg.exe>nul 2>nul add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsDisable8dot3NameCreation" /T REG_DWORD /D "0" /F && (
  call EchoSucc Enable short file names creation for all NTFS volumes
  exit /B 0
)
call EchoFail Enable short file names creation for all NTFS volumes
if /I "%DEBUG%"=="YES" reg.exe add "HKLM\SYSTEM\CurrentControlSet\Control\FileSystem" /V "NtfsDisable8dot3NameCreation" /T REG_DWORD /D "0" /F
exit /B 1

::    ƒл€ каждого файла NTFS автоматически генерирует длинное  и  короткое  им€
:: (оно же им€ формата 8.3). Ёто позвол€ет сохранить совместимость  со  старыми
:: верси€ми ќ— Microsoft (MS-DOS и MicrosoftЃ Windows 3.x).
::    „тобы отключить короткие имена, мен€ем  значение  параметра  HKLM\SYSTEM\
:: CurrentControlSet\Control\FileSystem\NtfsDisable8dot3NameCreation на:
::   0 Ц включить генерацию имен 8.3 дл€ всех разделов систем,
::   1 Ц выключить генерацию имен 8.3 дл€ всех разделов систем,
::   2 Ц включить генерацию имен 8.3, дл€ выбранных разделов,
::   3 Ц выключить генерацию имен 8.3 дл€ всех разделов кроме системного.

:Finish
