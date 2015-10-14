
::----------------------------------------------------------------------

:_UnitTest_test.date2jdate
SETLOCAL

    SHIFT
    :: Dummy test - test.date2jdate is a test module. No functional test
    ECHO:Skipping: Test module. No functional test>"%TEMP%\%0.skip" & GOTO :EOF
    
    REM :: Create ref
    REM (
        REM ECHO:test.date2jdate is a test module. No functional test
    REM )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    REM :: Dump data
    REM (
        REM ECHO:test.date2jdate is a test module. No functional test
    REM )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_test.date2jdate ***

::----------------------------------------------------------------------