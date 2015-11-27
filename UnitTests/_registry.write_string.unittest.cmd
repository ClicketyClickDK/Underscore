
::----------------------------------------------------------------------

:_UnitTest__registry.write_string
SETLOCAL
    SHIFT

    CALL :CheckForAdminPermissions >>"%TEMP%\%0.skip" 2>nul&IF ERRORLEVEL 1 GOTO :EOF

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

:CheckForAdminPermissions
    REM  --> Check for permissions
    >nul 2>&1 "%SYSTEMROOT%\system32\icacls.exe" "%SYSTEMROOT%\system32\config\system"

    REM --> If error flag set, we do not have admin.
    if '%errorlevel%' NEQ '0' ECHO:No admin rights&EXIT /b 1
GOTO :EOF

::----------------------------------------------------------------------

