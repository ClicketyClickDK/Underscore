
::----------------------------------------------------------------------

:_UnitTest__status
SETLOCAL
    SHIFT
    >"%TEMP%\%0.trc" ECHO %0

    :: Create ref
    >>"%TEMP%\%0.trc" ECHO :: Create ref
    (
    ECHO 00000000: 5B 48 65 6C 6C 6F 20 57 6F 72 6C 64 20 20 20 20  [Hello World    
    ECHO 00000010: 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20                  
    ECHO 00000020: 20 5D 0D 0A                                       ]..
    )>>"%TEMP%\%0.hexref" 2>>"%TEMP%\%0.trc"

    :: Dump test data
    >>"%TEMP%\%0.trc" ECHO :: Dump test data
    CALL %0 "Hello World" 1>"%TEMP%\%0.dump" 2>&1

    :: Convert to hexdump
    >>"%TEMP%\%0.trc" ECHO :: Convert to hexdump
    CALL HexDump /A /O "%TEMP%\%0.dump" >"%TEMP%\%0.hexdump" 2>>"%TEMP%\%0.trc"
GOTO :EOF *** :_UnitTest__status ***

::----------------------------------------------------------------------