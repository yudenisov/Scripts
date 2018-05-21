@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Protect/unprotect system files
set USAGE=protect/unprotect

call :Sys_Files "%~1"
goto Finish


:Sys_Files
set SYS_FILES=GRUB HBCD boot.ini bootfont.bin bootmgr cmldr grldr io.sys loadmgr menu.lst msdos.sys ntdetect.com ntldr
if /I "%~1"=="PROTECT" (
  for %%f in (%SYS_FILES%) do if exist "%SYSTEMDRIVE%\%%f" (
    call      >nul 2>nul SetAccessMode "%SYSTEMDRIVE%\%%f" full
    attrib.exe>nul 2>nul +A +H +R +S   "%SYSTEMDRIVE%\%%f"
    call SetAccessMode                 "%SYSTEMDRIVE%\%%f" read
  )
  exit /B 0
)
if /I "%~1"=="UNPROTECT" (
  for %%f in (%SYS_FILES%) do if exist "%SYSTEMDRIVE%\%%f" (
    call SetAccessMode                 "%SYSTEMDRIVE%\%%f" full
    attrib.exe>nul 2>nul +A -H -R +S   "%SYSTEMDRIVE%\%%f"
  )
  exit /B 0
)
exit /B 255

:Finish
