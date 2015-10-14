
::---------------------------------------------------------------------

:_UnitTest_drivetypes
    SHIFT
    SETLOCAL
    (
        ECHO %0
        :: Create ref
        ECHO :: Create ref
    )>"%TEMP%\%0.trc"
    
    ::(
        SET "DRLIST="
        for /f "tokens=1*" %%A in ('fsutil fsinfo drives^|find "\"') do (
           CALL set "DRLIST=%%B"
        )
    (
        ECHO DRLIST=[%drlist%]
        for %%A in (%drlist%) do fsutil fsinfo drivetype %%A
    )>>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump test data
    (
        CALL %0
    )>"%TEMP%\%0.dump" 2>&1
    ENDLOCAL
GOTO :EOF *** :_UnitTest_drivetypes ***

::---------------------------------------------------------------------
