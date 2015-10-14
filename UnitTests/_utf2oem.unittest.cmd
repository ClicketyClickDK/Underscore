
::---------------------------------------------------------------------

:_UnitTest__utf2oem
    :: This file MUST be in ANSI
    SHIFT

    (
        ECHO %0
        :: Create ref
        ECHO :: Create ref
    )>"%TEMP%\%0.trc"
    
    (
        REM :: Please note: There may be "hidden" characters in 
        REM ::this string, when viewed in ANSI
        ECHO:_utf=[‘›†’]
    )>>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump test data
    (
        CALL %0 _utf "Ã¦Ã¸Ã¥Ã†Ã˜Ã…"
        ECHO:_utf=[!_utf!]
    )>"%TEMP%\%0.dump" 2>&1
GOTO :EOF *** :_UnitTest__utf2oem ***

::---------------------------------------------------------------------
