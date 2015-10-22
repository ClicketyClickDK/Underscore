
ECHO:Hello world>"%TMP%\hello.txt" 
CALL zip.bat "%TMP%\hello.zip" "%TMP%\hello.txt" 
DEL "%TMP%\hello.txt" 
DIR "%TMP%\hello.txt" 
CALL unzip.bat "%TMP%\hello.zip" "%TMP%" 
DIR "%TMP%\hello.txt" 
