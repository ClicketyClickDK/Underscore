
::----------------------------------------------------------------------

:_UnitTest_checkPath
SETLOCAL

    SHIFT
    
    :: Create ref
::    (
    IF EXIST "%TEMP%\%0.ref" DEL"%TEMP%\%0.ref"

    :: Dump data
    (
        CALL %0
        CALL %0 "C:\Windows"
        CALL %0 -add:"C:\msdos\"
    )>"%TEMP%\%0.dump"
    type "%TEMP%\%0.dump"
    ECHO:
GOTO :EOF *** :_UnitTest_checkPath ***
    
::----------------------------------------------------------------------

::*** Match strings for testing output --------------------------------
::	c:\_>checkpath
::	"C:\ProgramData\Oracle\Java\javapath"
::	"C:\Windows\system32"
::	"C:\Windows"
::	"C:\Windows\System32\Wbem"
::	"C:\Windows\System32\WindowsPowerShell\v1.0\"
::	"C:\Program Files (x86)\Skype\Phone\"
::	c:\_>checkpath "C:\Windows"
::	"C:\Windows" exists in PATH
::	c:\_>checkpath -add:"C:\msdos\"
::	Appending [C:\msdos\]
::  
::# Test strings for test 
::
::checkpath
::MATCH::\"C:\Windows\system32\"
::
::"C:\Windows"
::MATCH::\"C:\Windows\"
::
::checkpath "C:\Windows"
::MATCH::^\"C:\Windows\" exists in PATH
::
::checkpath -add:"C:\msdos\"
::MATCH::^Appending [C:\msdos\]
::
