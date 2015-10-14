
::----------------------------------------------------------------------

:_UnitTest_oerr
    SETLOCAL
    SHIFT

    (
        rem ECHO:oerr v.01.003 -- Extracts Error messaged from script files using uniq ErrorID
        REM ECHO:
        ECHO:
        ECHO:Error.001 - first error - Non fatal
        ECHO:// *Cause: Some error has occured ^(Continuing^)
        ECHO:// *Action: What to do to prevent this error
        ECHO:// OR what action to take to clean up the mess
        ECHO:
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc" 
    
    ECHO CALL "%0" "%0" Error.001 "Default message/description"
    >"%TEMP%\%0.dump" 2>&1 CALL "%0" "%0" Error.001 "Default message/description"
    
    ENDLOCAL
GOTO :EOF *** :_UnitTest_oerr ***

::----------------------------------------------------------------------