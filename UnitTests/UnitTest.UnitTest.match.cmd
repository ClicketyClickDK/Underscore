
::----------------------------------------------------------------------

::Unit Test for UnitTest.cmd: Testing matching pattern

:_UnitTest_UnitTest
SETLOCAL

    SHIFT
    
    REM :: Create ref
    REM (
        REM ECHO:UnitTest is a template. No functional test
    REM )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        ECHO:UnitTest is a template. No functional test
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_UnitTest ***

::----------------------------------------------------------------------
::*** Match strings for testing output --------------------------------
::# Test strings for test matching script.bat
::     YYYY-MM-DDThh:mm
::MATCH::^UnitTest is a template. No functional test$
::
::----------------------------------------------------------------------
