
::----------------------------------------------------------------------

:_UnitTest_repl
SETLOCAL
    SHIFT
    
    :: Create ref
    (
        ECHO:00000000: 48 65 6C 6C 6F 20 6F 75 72 20 77 6F 72 6C 64 0D  Hello our world.
        ECHO:00000010: 0A                                               .
    )>"%TEMP%\%0.hexref" 2>>"%TEMP%\%0.trc"

    :: Simple dump
    1>"%TEMP%\%0.dump" 2>&1 ECHO:Hello my world
    CALL %0 "my" "our" "%TEMP%\%0.dump" >"%TEMP%\%0.dump2"

    :: Convert to hexdump
    CALL HexDump /A /O "%TEMP%\%0.dump2" >"%TEMP%\%0.hexdump" 2>>"%TEMP%\%0.trc"
    
GOTO :EOF *** :_UnitTest_repl ***

::----------------------------------------------------------------------