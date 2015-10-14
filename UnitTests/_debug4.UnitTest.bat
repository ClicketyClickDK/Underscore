

::----------------------------------------------------------------------

:_UnitTest__debug4
SETLOCAL

    SHIFT
    :: Dummy test - _debug4 is a sub function to _debug. No functional test
    ECHO:Skipped:sub func=no test>"%TEMP%\%0.skip" & GOTO :EOF

    REM :: Create ref
    REM (
        REM ECHO:_debug4 is a sub function to _debug. No functional test
    REM )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    REM :: Dump data
    REM (
        REM ECHO:_debug4 is a sub function to _debug. No functional test
    REM )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest__debug4 ***

::----------------------------------------------------------------------