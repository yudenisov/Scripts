@echo off
set PATH=%SYSTEMROOT%\SYSTEM32;%SYSTEMROOT%;%SYSTEMROOT%\SYSTEM32\WBEM;

set  HELP=Join lines split with backslash (filter)
set USAGE=[search [change]]

call :Join_Lines_Split_With_Backslash %*
goto Finish


:Join_Lines_Split_With_Backslash
sed.exe -e :0 -e "/\\$/N; s/\\\n%~1/%~2/; t0; s/$/\r/"
exit /B

:Finish
