
::----------------------------------------------------------------------

::Unit Test for UnitTest.cmd: Testing hexref / hexdump compare

:_UnitTest_UnitTest
SETLOCAL

    SHIFT
    
    :: Create ref
    (
        ECHO:UnitTest is a template. No functional test
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"
    CALL HexDump.cmd "%TEMP%\%0.ref" >"%TEMP%\%0.hexref" 

    :: Dump data
    (
        ECHO:UnitTest is a template. No functional test
    )>"%TEMP%\%0.dump"
    CALL HexDump.cmd "%TEMP%\%0.dump" >"%TEMP%\%0.hexdump"
    
GOTO :EOF *** :_UnitTest_UnitTest ***

::----------------------------------------------------------------------