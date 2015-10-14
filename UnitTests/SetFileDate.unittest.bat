
::----------------------------------------------------------------------

:_UnitTest_setFileDate
    FOR %%a IN (setFileDate.bat shortDate2Iso.cmd) DO ( 
        IF NOT EXIST "%_scriptDir%\%%a" ( 
            ECHO::%%a MISSING 
            ECHO::%%a MISSING >CON:
            REM GOTO :EOF 
        )
    )>>"%TEMP%\%0.trc"
    
    SHIFT
    SETLOCAL
    (
        ECHO:1999-12-31T11:32
        :: Create ref
        ECHO:: Create ref>&2
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"
    
    CALL %0 "%TEMP%\%0.ref" "1999-12-31T11:32"

    DIR "%TEMP%\%0.ref" >>"%TEMP%\%0.trc" 2>&1
    FOR  %%a in (%TEMP%\%0.ref) DO CALL SET "_fileTime=%%~ta" &ECHO: filefix %%a / %%~ta >>"%TEMP%\%0.trc"
    ECHO: _fileTime=%_fileTime% >>"%TEMP%\%0.trc"
    :: Dump test data
    (
        CALL shortDate2Iso _iso "%_fileTime%"
        ECHO:!_iso!
        ECHO:!_iso!/ %%a / %%~ta>>"%TEMP%\%0.trc"
    )>>"%TEMP%\%0.dump" 2>&1
    ENDLOCAL
GOTO :EOF *** :_UnitTest_getFilesOlderThan ***

::----------------------------------------------------------------------
