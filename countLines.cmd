@ECHO OFF

:: https://brett.batie.com/scripting/count-number-of-lines-in-a-file-using-dos/

findstr /R /N "^" "%~1 " | find /C ":"
