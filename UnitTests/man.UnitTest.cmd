

::----------------------------------------------------------------------

:_UnitTest_man
SETLOCAL

    SHIFT

    :: Create ref
    (
        type "%_scriptDir%\Documentation\man.txt
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        CALL %0 man
    )>"%TEMP%\%0.dump"
    
    
GOTO :EOF *** :_UnitTest_man ***

::----------------------------------------------------------------------