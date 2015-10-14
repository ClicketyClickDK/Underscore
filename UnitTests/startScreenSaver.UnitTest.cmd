

::----------------------------------------------------------------------

:_UnitTest_startScreenSaver
SETLOCAL

    SHIFT
    :: Dummy test - startScreenSaver is calling an internal Windows function. No functional test
    ECHO:Skipped:Win internal=no test>"%TEMP%\%0.skip" & GOTO :EOF
    
    REM :: Create ref
    REM (
        REM ECHO:startScreenSaver is calling an internal Windows function. No functional test
    REM )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    REM :: Dump data
    REM (
        REM ECHO:startScreenSaver is calling an internal Windows function. No functional test
    REM )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_startScreenSaver ***

::----------------------------------------------------------------------