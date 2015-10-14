

::----------------------------------------------------------------------

:_UnitTest_jrepl
SETLOCAL

    SHIFT
    
    :: Create ref
    (
        ECHO:xYz
        ECHO:Hello World
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    ECHO:Hello world>"%TEMP%\%0.tmp"
    :: Dump data
    (
        echo xyz|%0 y Y
        CALL %0 world World <"%TEMP%\%0.tmp"
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_jrepl ***

::----------------------------------------------------------------------