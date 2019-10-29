Dim wshShell, shApp, objFile, strFilePath, strProgPath, fso
Set wshShell = CreateObject( "WScript.Shell" )
Set shApp = CreateObject( "Shell.Application" )
Set fso = CreateObject( "Scripting.FileSystemObject" )
strProgPath = wshShell.ExpandEnvironmentStrings( "%ProgramFiles%")
strFilePath = strProgPath & "\AdminScripts.Set01\" & "call.uninstall.bat"
if fso.FileExists( strFilePath ) then
    shApp.ShellExecute strFilePath, "", "", "runas", 1
    TimeSleep( 10 )
else
    MsgBox "File " & strFilePath & " Not Found", 0, "Error"
end if
Sub TimeSleep ( delim )
	Dim dteWait
	dteWait = DateAdd("s", delim, Now())
	Do Until (Now() > dteWait)
		Loop
End Sub 
