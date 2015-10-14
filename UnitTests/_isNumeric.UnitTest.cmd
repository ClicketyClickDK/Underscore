

::----------------------------------------------------------------------

:_UnitTest__isnumeric
SETLOCAL

    SHIFT
    
    :: Create ref
    (
        ECHO:OK
        ECHO:OK
        ECHO:OK
        ECHO:OK
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        CALL %0 12
        IF ERRORLEVEL 1 (ECHO FAIL) ELSE ECHO:OK

        CALL %0 x12
        IF ERRORLEVEL 1 (ECHO OK) ELSE ECHO:FAIL

        CALL %0 1.2
        IF ERRORLEVEL 1 (ECHO FAIL) ELSE ECHO:OK
        CALL %0 1a2
        IF ERRORLEVEL 1 (ECHO OK) ELSE ECHO:FAIL
    )>"%TEMP%\%0.dump"
    SET ErrorLevel=
GOTO :EOF *** :_UnitTest__isnumeric ***

::----------------------------------------------------------------------