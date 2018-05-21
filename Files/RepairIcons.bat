@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Repair icons
set USAGE=

call :Repair_Icons
goto Finish


:Repair_Icons
reg.exe     >nul 2>nul add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "Max Cached Icons" /T REG_SZ /D "2000" /F
hidec.exe   >nul 2>nul ie4uinit.exe -ClearIconCache
call        >nul 2>nul :DelFileInAppData "IconCache.db"
call        >nul 2>nul :DelFileInAppData "Microsoft\Windows\Explorer\thumbcache*.db"
call        >nul 2>nul SetAccessMode "%SYSTEMROOT%\rescache" full
rmdir       >nul 2>nul /S /Q         "%SYSTEMROOT%\rescache"
del         >nul 2>nul /A /F /Q "%SYSTEMROOT%\ShellIconCache"
ping.exe    >nul 2>nul 127.0.0.1 -n 11
taskkill.exe>nul 2>nul /F /T /IM "ie4uinit.exe"
call EchoSucc Repair icons
if /I "%DEBUG%"=="YES" (
  reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /V "Max Cached Icons" /T REG_SZ /D "2000" /F
  ie4uinit.exe -ClearIconCache
  call :DelFileInAppData "IconCache.db"
  call :DelFileInAppData "Microsoft\Windows\Explorer\thumbcache*.db"
  call SetAccessMode "%SYSTEMROOT%\rescache" full
  rmdir /S /Q        "%SYSTEMROOT%\rescache"
  del /A /F /Q "%SYSTEMROOT%\ShellIconCache"
)
exit /B 0

:DelFileInAppData
if "%~1"=="" exit /B 1
setlocal
cd>nul 2>nul /D "%SYSTEMDRIVE%\Users" || ^
cd>nul 2>nul /D "%SYSTEMDRIVE%\Documents and Settings" || exit /B 1
for /D %%i in ("*.*" "All Users" "Default") do (
  del /A /F /Q "%%~i\AppData\Local\%~1"
  del /A /F /Q "%%~i\AppData\Roaming\%~1"
  del /A /F /Q "%%~i\Application Data\%~1"
  del /A /F /Q "%%~i\Local Settings\Application Data\%~1"
)
endlocal
exit /B

:Finish
