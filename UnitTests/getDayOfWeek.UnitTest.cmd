

::----------------------------------------------------------------------

:_UnitTest_getDayOfWeek
SETLOCAL

    SHIFT
    
    :: Create ref
    (
        ECHO:DayOfWeek=6
        ECHO:DayOfWeek=4
        ECHO:DayOfWeek=5
        ECHO:DayOfWeek=6
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"
    
    :: Man - Sun 0 - 6
    :: Dump data
    (
        REM sun 7
        CALL getDayOfWeek DayOfWeek 1999-02-28
        SET DayOfWeek
        rem fre 5
        CALL getDayOfWeek DayOfWeek 1999-12-31
        SET DayOfWeek
        REM sat 6
        CALL getDayOfWeek DayOfWeek 2000-01-01
        SET DayOfWeek
        REM Sun 7
        CALL getDayOfWeek DayOfWeek 2000-12-31
        SET DayOfWeek
        
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_getDayOfWeek ***

::----------------------------------------------------------------------