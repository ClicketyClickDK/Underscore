
::----------------------------------------------------------------------

:_UnitTest_spinner
    SETLOCAL
    SHIFT

    REM (
    REM     ECHO:Ä\³/Ä\³/Ä\
    REM )1>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"
    (
        ECHO:00000000: C4 08 5C 08 B3 08 2F 08 C4 08 5C 08 B3 08 2F 08  ..\.../...\.../.
        ECHO:00000010: C4 08 5C 08                                      ..\.
    )>"%TEMP%\%0.hexref" 2>>"%TEMP%\%0.trc"

    SET _last_line=10
    SET _Spinner=
    (
        FOR /L %%x IN (1,1,10) DO @CALL spinner
    )>"%TEMP%\%0.dump" 2>&1 

    :: Convert to hexdump
    CALL HexDump /A /O "%TEMP%\%0.dump" >"%TEMP%\%0.hexdump" 2>>"%TEMP%\%0.trc"

    ENDLOCAL
GOTO :EOF *** :_UnitTest_spinner ***

::----------------------------------------------------------------------
