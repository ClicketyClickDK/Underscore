

::----------------------------------------------------------------------

:_UnitTest_dummy
SETLOCAL

    SHIFT
    :: Dummy test - dummy is a - dummy function. No functional test
    ECHO:Skipped:Dummy function=no test>"%TEMP%\%0.skip" & GOTO :EOF

    REM :: Create ref
    REM (
        REM ECHO:dummy is a - dummy function. No functional test
    REM )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    REM :: Dump data
    REM (
        REM ECHO:dummy is a - dummy function. No functional test
    REM )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_dummy ***

::----------------------------------------------------------------------