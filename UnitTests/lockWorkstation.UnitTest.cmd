

::----------------------------------------------------------------------

:_UnitTest_lockWorkstation
SETLOCAL

    SHIFT
    :: Dummy test - lockWorkstation is calling an internal Windows function. No functional test
    ECHO:Skipped:Win internal=no test>"%TEMP%\%0.skip" & GOTO :EOF
    
    REM :: Create ref
    REM (
        REM ECHO:lockWorkstation is calling an internal Windows function. No functional test
    REM )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    REM :: Dump data
    REM (½