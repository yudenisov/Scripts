' On Error Resume Next
Dim wshShell, shApp, fso, strFilePath, strWinPath
Set wshShell = CreateObject( "WScript.Shell" )
strWinPath = wshShell.ExpandEnvironmentStrings( "%SystemRoot%" )
Set shApp = CreateObject( "Shell.Application" )
Set fso = CreateObject( "Scripting.FileSystemObject" )
strFilePath = strWinPath & "\make_uninstall.AdminScripts.cmd"
if fso.FileExists( strFilePath ) then
    shApp.ShellExecute strFilePath, "","", "runas", 0
    TimeSleep( 10 )
    fso.DeleteFile( strFilePath )
else
    MsgBox "File " & strFilePath & " Not Found", 0, "Error"
end if

Sub TimeSleep ( delim )
	Dim dteWait
	dteWait = DateAdd("s", delim, Now())
	Do Until (Now() > dteWait)
		Loop
End Sub 
