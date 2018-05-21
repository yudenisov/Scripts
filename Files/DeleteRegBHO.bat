@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Delete Browser Helper Object registry keys
set USAGE={bho_guid}

call :Delete_Reg_Browser_Helper_Object "%~1"
goto Finish


:Delete_Reg_Browser_Helper_Object
if "%~1"=="" exit /B 255
call DeleteRegEntry           "HKCR\CLSID\%~1"
call DeleteRegHKLMSoftware "Classes\CLSID\%~1"
call DeleteRegHKCU "Software\Microsoft\Windows\CurrentVersion\Ext\Settings\%~1"
call DeleteRegHKCU "Software\Microsoft\Windows\CurrentVersion\Ext\Stats\%~1"
call DeleteRegHKCU "Software\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\%~1"
call DeleteRegHKLMSoftware "Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects\%~1"
call DeleteRegHKLMSoftware "Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\%~1"
call DeleteRegHKLMSoftware "Microsoft\Windows\CurrentVersion\Shell Extensions\Approved" "%~1"

exit /B

:Finish
