
::----------------------------------------------------------------------

:_UnitTest_spinner
    SETLOCAL
    SHIFT

    (
    ECHO:Ä\³/Ä\³/Ä\
    )1>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"
 
    SET _last_line=10
    SET _Spinner=
    (
        FOR /L %%x IN (1,1,10) DO @CALL spinner
    )>"%TEMP%\%0.dump" 2>&1 
    ENDLOCAL
GOTO :EOF *** :_UnitTest_spinner ***

::----------------------------------------------------------------------
