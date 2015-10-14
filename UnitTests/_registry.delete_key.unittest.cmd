
::----------------------------------------------------------------------

:_UnitTest__registry.delete_key
SETLOCAL

    SHIFT
    SET _Key=HKEY_LOCAL_MACHINE\SOFTWARE\ClicketyClick.dk
    SET _REG=REG.exe
    SET #%$NAME%.Status=
    >>"%TEMP%\%0.trc" 2>&1 ECHO %0

    :: Setup reference
    >>"%TEMP%\%0.trc" 2>&1 ECHO :: Write test key [%_key%] "Status" "UnitTest" 
    CALL _registry.write_string ^
        "%_KEY%\%0\%0" ^
        "Status" "UnitTest" 

    :: Write ref data
    >>"%TEMP%\%0.trc" 2>&1 ECHO :: Reference
    CALL _registry.list_keys "%_KEY%" >"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"
    CALL _registry.list_keys "%_KEY%%0" >>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Delete keys
    >>"%TEMP%\%0.trc" 2>&1 ECHO :: Delete key
    SET #%$NAME%.Status=
    CALL _registry.delete_key "%_KEY%\%0\%0"

    ::Read string - again
    >>"%TEMP%\%0.trc" 2>&1 ECHO :: Read data
    CALL _registry.list_keys "%_KEY%" >"%TEMP%\%0.dump" 2>>"%TEMP%\%0.trc"
    CALL _registry.list_keys "%_KEY%%0" >>"%TEMP%\%0.dump" 2>>"%TEMP%\%0.trc"

::    :: Test
::    FC "%TEMP%\%0.ref" "%TEMP%\%0.dump">NUL 2>&1
::    IF ERRORLEVEL 1 (
::        ECHO %0 Fail
::    ) ELSE (
::        ECHO %0 OK
::    )    
GOTO :EOF *** :_UnitTest__registry.delete_key ***

::----------------------------------------------------------------------

