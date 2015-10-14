
::---------------------------------------------------------------------

:_UnitTest__utf2ansi
:: This file MUST be in ANSI!!!
    SHIFT
    SETLOCAL
    (
        ECHO %0
        :: Create ref
        ECHO :: Create ref
    )>"%TEMP%\%0.trc"
    
    (
        ECHO:_utf=æøåÆØÅ
    )>>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump test data
    (
        CALL %0 _utf "Ã¦Ã¸Ã¥Ã†Ã˜Ã…"
        set _utf
    )>"%TEMP%\%0.dump" 2>&1
    ENDLOCAL
GOTO :EOF *** :_UnitTest__utf2ansi ***

::---------------------------------------------------------------------
