
::----------------------------------------------------------------------

::Unit Test for UnitTest.cmd: Testing ref / dump compare

:_UnitTest_UnitTest
SETLOCAL

    SHIFT
    
    :: Create ref
    (
        ECHO:UnitTest is a template. No functional test
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        ECHO:UnitTest is a template. No functional test
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_UnitTest ***

::----------------------------------------------------------------------