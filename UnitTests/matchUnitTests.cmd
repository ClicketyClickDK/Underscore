
PUSHD "%~dp0\..\"
DIR /b /A:-D *.cmd *.bat >"%TEMP%\_.txt"
CD "%~dp0\"
DIR /b /A:-D *.cmd *.bat >"%TEMP%\_.unittests.txt"

POPD
CALL "%~dp0\..\jrepl.bat" ".UnitTest." "."  /I /F "%TEMP%\_.unittests.txt" /O "%TEMP%\_.unit.txt"

FC /C "%TEMP%\_.txt" "%TEMP%\_.unit.txt" >"%TEMP%\_.diff.txt"

"%TEMP%\_.diff.txt"