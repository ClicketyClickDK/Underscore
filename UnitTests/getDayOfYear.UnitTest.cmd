

::----------------------------------------------------------------------

:_UnitTest_getDayOfYear
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)

    SHIFT
    SET _Dates=2015-01-01:1 1999-02-28:59 1999-02-29:60 1999-12-31:365 2000-01-01:1 2000-12-31:365

    :: Create ref
    (
        FOR %%a IN (%_dates%) DO (
            CALL SET _Date=%%a
            CALL ECHO:[!_date:~0,10!] [!_date:~11!]
        )
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        FOR %%a IN (%_dates%) DO (
            CALL SET _Date=%%a
            CALL %0 _getDayOfYear "!_date:~0,10!"
            CALL ECHO [!_date:~0,10!] [!_getDayOfYear!]
        )
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_getDayOfYear ***

::----------------------------------------------------------------------