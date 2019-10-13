@echo off
if not exist "%ProgramFiles(x86)%\AdminScripts.Set01\Scripts.SFX.exe" goto Error
"%ProgramFiles(x86)%\AdminScripts.Set01\Scripts.SFX.exe" -p1234
for /F "tokens=1,2,*" %%i in ('reg.exe 2^>nul query "HKU"') do (
  reg.exe   >nul 2>nul add "%%~i\Software\Sysinternals\C"       /V "EulaAccepted" /T REG_DWORD /D "1" /F
  reg.exe   >nul 2>nul add "%%~i\Software\Sysinternals\PSExec"  /V "EulaAccepted" /T REG_DWORD /D "1" /F
  reg.exe   >nul 2>nul add "%%~i\Software\Sysinternals\Regjump" /V "EulaAccepted" /T REG_DWORD /D "1" /F
)
call        >nul 2>nul "%~dp0Files\CheckMemberOfDomain.bat" || (
  reg.exe   >nul 2>nul import "%~dp0Files\REGFILES\SRP.reg"
  reg.exe   >nul 2>nul import "%~dp0Files\REGFILES\DisallowedCerts.reg"
  reg.exe   >nul 2>nul import "%~dp0Files\REGFILES\TrustedPublisherCerts.reg"
)
rem schtasks.exe     2>&1  /CREATE /TN "Admin_Scripts" /SC "DAILY" /ST "12:10:00" /TR "ApplySettingsProfile.bat" /RU "SYSTEM" /RL "HIGHEST" /F|findstr.exe>nul 2>nul /I "�ᯥ譮 successfully" && goto Finish
rem schtasks.exe>nul 2>nul /CREATE /TN "Admin_Scripts" /SC "DAILY" /ST "12:10:00" /TR "ApplySettingsProfile.bat" /RU "SYSTEM"
goto Finish
:Error
echo "File %ProgramFiles(x86)%\AdminScripts.Set01\Scripts.SFX.exe not found"
pause
:Finish
