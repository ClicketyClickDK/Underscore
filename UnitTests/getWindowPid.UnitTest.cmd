
::----------------------------------------------------------------------

:_UnitTest_getWindowPid
SETLOCAL

    SHIFT
    
    :: Create ref
::    (
    IF EXIST "%TEMP%\%0.ref" DEL"%TEMP%\%0.ref"

    :: Dump data
    (
        CALL %0
    )>"%TEMP%\%0.dump"
    type "%TEMP%\%0.dump"
    ECHO:
GOTO :EOF *** :_UnitTest_getWindowPid ***
    
::----------------------------------------------------------------------

::*** Match strings for testing output --------------------------------
::# Test strings for test matching getLastBootupTime.cmd
::01 Match Three or more digits
::MATCH::^[0-9][0-9][0-9]*$
::
