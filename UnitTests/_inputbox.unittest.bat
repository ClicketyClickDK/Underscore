    

::----------------------------------------------------------------------

:_UnitTest__inputBox
SETLOCAL

    SHIFT
    :: Dummy test - _inputBox is a call to the Windows interface. No functional test
    ECHO:Skipped:Win interface=no test>"%TEMP%\%0.skip" & GOTO :EOF

    REM :: Create ref
    REM (
        REM ECHO:_inputBox is a call to the Windows interface. No functional test
    REM )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    REM :: Dump data
    REM (
        REM ECHO:_inputBox is a call to the Windows interface. No functional test
    REM )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest__inputBox ***

::----------------------------------------------------------------------