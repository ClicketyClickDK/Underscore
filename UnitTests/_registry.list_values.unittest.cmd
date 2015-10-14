
::----------------------------------------------------------------------

:_UnitTest__registry.list_values
SETLOCAL
    SHIFT
::    ECHO --- _registry.list_values ---
    SET _KEY=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion
    SET _REG=REG.exe
    
    (
        FOR /F "usebackq tokens=1" %%C IN (`%_REG% query "%_KEY%" ^| find /i /v "%_KEY%"2^>nul`) DO ECHO %%C
    )>"%TEMP%\%0.ref" 2>nul
    ::CALL :TruncList %%C

    ::%_REG% query "%_KEY%" | find "CurrentVersion\" >"%TEMP%\%0.ref"
    ::          CALL _registry.list_values "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion"
    ::      Will print a list of values like:
    ::          SM_GamesName
    ::          SM_ConfigureProgramsName
    ::          ::
    ::          PF_AccessoriesName
    CALL _registry.list_values "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion" >"%TEMP%\%0.dump"

::    :: Test
::    FC "%TEMP%\%0.ref" "%TEMP%\%0.dump">NUL 2>&1
::    IF ERRORLEVEL 1 (
::        ECHO %0 Fail
::    ) ELSE (
::        ECHO %0 OK
::    )    
GOTO :EOF *** :_UnitTest__registry.list_values ***

::----------------------------------------------------------------------