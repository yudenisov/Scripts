'----------------------------------------------------------
' Renew the Notification Area Icons in Windows XP, Vista, 7
'----------------------------------------------------------

Set WshShell = CreateObject ("WScript.Shell")
strComputer = "."
Set objWMIService = GetObject ("winmgmts:\\" & strComputer & "\root\cimv2")

' Determine Windows ver
Set colOperatingSystems = objWMIService.ExecQuery ("Select * from Win32_OperatingSystem")
For Each objOperatingSystem in colOperatingSystems
  if instr (objOperatingSystem.Caption,"Vista") or instr (objOperatingSystem.Caption,"Windows 7") then
    strBasekey = "HKCU\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\TrayNotify\"
  elseif instr (objOperatingSystem.Caption,"XP") Then
    strBasekey = "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TrayNotify\"
  else
'   MsgBox "This script works on Windows XP, Vista, 7 systems only"
    wscript.Quit
  end if
Next

' Clear the notifications dialog
On Error resume next
WshShell.Regdelete strBasekey & "IconStreams"
WshShell.Regdelete strBasekey & "PastIconsStream"
On Error goto 0

' Get user name
Set colItems = objWMIService.ExecQuery ("Select * From Win32_ComputerSystem")
For Each objItem in colItems
  strCurrentUserName = objItem.UserName
Next

'restart user shell
Set colProcessList = objWMIService.ExecQuery ("Select * from Win32_Process Where Name = 'Explorer.exe'")
For Each objProcess in colProcessList
  colProperties = objProcess.GetOwner (strNameOfUser,strUserDomain)
  If strUserDomain & "\" & strNameOfUser = strCurrentUserName then
    objProcess.Terminate ()
  end if
Next
'Msgbox "Notification tray icons cleared, reboot now."
