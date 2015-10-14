

:_UnitTest_processBar
    SHIFT

    :: Create ref
    FOR /L %%x IN (1,1,50) DO (
        SET /P _=#<NUL
    )>>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump test data
    SET _max=120
    (
        Call %0 %_max% #
        FOR /L %%x IN (1,1,%_max%) DO (
            CALL %0 %%x
        )
    )>"%TEMP%\%0.dump" 2>>"%TEMP%\%0.trc"
    
    :: Convert to hexdump
    ::CALL HexDump /A /O "%TEMP%\%0.dump" >"%TEMP%\%0.hexdump" 2>>"%TEMP%\%0.trc"
GOTO :EOF *** :_UnitTest_processBar  ***

::----------------------------------------------------------------------