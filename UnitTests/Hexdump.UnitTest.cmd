

::----------------------------------------------------------------------

:_UnitTest_hexdump
SETLOCAL

    SHIFT
    
    :: Create ref
    (
        ECHO:00000000: 3A 68 65 78 44 75 6D 70 20 5B 2F 6F 70 74 69 6F  :hexDump [/optio
        ECHO:00000010: 6E 5D 2E 2E 2E 20 66 69 6C 65 20 20 20 20 20 20  n]... file      
        ECHO:00000020: 20 20 2D 2D 20 64 75 6D 70 20 61 20 66 69 6C 65    -- dump a file
        ECHO:00000030: 20 69 6E 20 68 65 78 20 66 6F 72 6D 61 74 0D 0A   in hex format..
        ECHO:00000040: 3A 09 41 75 74 68 6F 72 3A 20 44 61 76 65 20 42  :.Author: Dave B
        ECHO:00000050: 65 6E 68 61 6D 20 5B 64 62 65 6E 68 61 6D 5D 0D  enham [dbenham].
        ECHO:00000060: 0A                                               .
    )>"%TEMP%\%0.hexref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        ECHO::hexDump [/option]... file        -- dump a file in hex format
        ECHO::	Author: Dave Benham [dbenham]
    )>"%TEMP%\%0.dump"
    CALL HexDump.cmd "%TEMP%\%0.dump" >"%TEMP%\%0.hexdump"
GOTO :EOF *** :_UnitTest_hexdump ***

::----------------------------------------------------------------------