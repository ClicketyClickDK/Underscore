
::---------------------------------------------------------------------

:_UnitTest__previousmonth
    SHIFT

    (
        ECHO %0
        :: Create ref
        ECHO :: Create ref
    )>"%TEMP%\%0.trc"
    
    (
        ECHO:$previousmonth=2015-01
        ECHO:$previousmonth=2014-12
    )>>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump test data
    (
        CALL %0 $previousmonth "2015-02-01">nul
        set $previousmonth
        CALL %0 $previousmonth "2015-01-20">nul
        set $previousmonth
        
    )>"%TEMP%\%0.dump" 2>&1

GOTO :EOF *** :_UnitTest__previousmonth ***

::---------------------------------------------------------------------