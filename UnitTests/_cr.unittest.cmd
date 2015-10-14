
::---------------------------------------------------------------------

:_UnitTest__cr
    SHIFT
    
    :: Create ref
    ECHO 00000000: 5B 0D 5D 0D 0A                                   [.]..>"%TEMP%\%0.HEXref" 2>>"%TEMP%\%0.trc"
    ::                ^^
    
    CALL %0 1>&2 2>>"%TEMP%\%0.trc"
    :: Dump test data
    >"%TEMP%\%0.dump" 2>>"%TEMP%\%0.trc" ECHO [!_CR!]

    :: Convert to hexdump
    CALL HexDump /A /O "%TEMP%\%0.dump" >"%TEMP%\%0.hexdump" 2>>"%TEMP%\%0.trc"
    
GOTO :EOF *** :_CR ***

::---------------------------------------------------------------------