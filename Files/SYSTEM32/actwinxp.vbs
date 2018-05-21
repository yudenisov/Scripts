On Error Resume Next

Dim VOL_PROD_KEY

VOL_PROD_KEY = "B77QF-DP27W-4H68R-72B48-78RPD"
VOL_PROD_KEY = Replace (VOL_PROD_KEY, "-", "")

For Each Obj in GetObject ("winmgmts:{impersonationLevel=impersonate}").InstancesOf ("win32_WindowsProductActivation")
  Result = Obj.SetProductKey (VOL_PROD_KEY)
Next

If (Result = "0") Then
  Wscript.Echo ("Windows XP activate successful")
  Wscript.Quit (0)
Else
  Wscript.Echo ("Windows XP activate failed")
  Wscript.Quit (1)
End If
