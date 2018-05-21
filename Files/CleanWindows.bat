@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Cleaning Windows recycle bin, temp/cache and other files
set USAGE=

call :Cleaning_Windows
goto Finish


:Cleaning_Windows
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Active Setup Temp Folders"                    /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Content Indexer Cleaner"                      /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Downloaded Program Files"                     /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\GameNewsFiles"                                /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\GameStatisticsFiles"                          /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\GameUpdateFiles"                              /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Internet Cache Files"                         /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Memory Dump Files"                            /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Microsoft Office Temp Files"                  /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Offline Pages Files"                          /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Old ChkDsk Files"                             /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Previous Installations"                       /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Recycle Bin"                                  /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Setup Log Files"                              /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error memory dump files"               /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\System error minidump files"                  /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Files"                              /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Setup Files"                        /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Temporary Sync Files"                         /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Thumbnail Cache"                              /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Upgrade Discarded Files"                      /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Archive Files"        /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting Queue Files"          /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting System Archive Files" /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Error Reporting System Queue Files"   /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
reg.exe>nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Windows Upgrade Log Files"                    /V "StateFlags0064" /T REG_DWORD /D "2" /F || goto Cleaning_Windows_Fail
:: Стандартный менеджер очистки
psx.exe 2>nul /ACCEPTEULA /E /S cleanmgr.exe>nul 2>nul /SAGERUN:64 && (
  call EchoSucc Cleaning Windows
  exit /B 0
)
:Cleaning_Windows_Fail
call EchoFail Cleaning Windows
if /I "%DEBUG%"=="YES" cleanmgr.exe /SAGERUN:64
exit /B 1

:Finish
