
::----------------------------------------------------------------------

:_UnitTest__registry.write_string
SETLOCAL
    SHIFT

    SET _Key=HKEY_LOCAL_MACHINE\SOFTWARE\ClicketyClick.dk\%0
    ECHO #%$NAME%.status=Started>"%TEMP%\%0.ref" 2>nul
    
    CALL _registry.write_string ^
        "%_Key%" ^
        "Status" "Started" 
    
    CALL _registry.read_string "%_Key%" "Status"
    CALL ECHO #%$NAME%.status=%%#%$NAME%.status%%>"%TEMP%\%0.dump"

::    :: Test
::    FC "%TEMP%\%0.ref" "%TEMP%\%0.dump">NUL 2>&1
::    IF ERRORLEVEL 1 (
::        ECHO %0 Fail
::    ) ELSE (
::        ECHO %0 OK
::    )
    EXIT /B 0
GOTO :EOF *** :_UnitTest__registry.write_string ***


::----------------------------------------------------------------------