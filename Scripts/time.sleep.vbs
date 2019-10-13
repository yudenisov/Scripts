Sub TimeSleep ( delim )
	Dim dteWait
	dteWait = DateAdd("s", delim, Now())
	Do Until (Now() > dteWait)
		Loop
End Sub 
  
Dim Th
Th = 1
MsgBox"Делаем паузу в 1 секунду", 0, "Error"
TimeSleep( Th )
Th = 3
MsgBox "Делаем паузу в 3 секунды", 0, "Error"
TimeSleep( 3 )
MsgBox "Форматируй винт!", 0, "Error"
