
::----------------------------------------------------------------------

:_UnitTest__registry.read_string
SETLOCAL

    SHIFT
    Set _Key=HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Windows
    ECHO #%$NAME%.Directory=%SystemRoot%>"%TEMP%\%0.ref" 2>nul

    ::          CALL _registry.read_string ^
    ::          "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion" ^
    ::          "ProgramFilesDir"
    ::     
    ::      Will read the key and value from the registration database
    ::      and create an environment variable: 
    ::        #%%$Name%%.ProgramFilesDir
    CALL _registry.read_string "%_Key%" "Directory"
    CALL ECHO #%$NAME%.Directory=%%#%$NAME%.Directory%%>"%TEMP%\%0.dump"
    :: Should display: #myreg.ProgramFilesDir=C:\Program Files

::    :: Test
::    FC "%TEMP%\%0.ref" "%TEMP%\%0.dump">NUL 2>&1
::    IF ERRORLEVEL 1 (
::        ECHO %0 Fail
::    ) ELSE (
::        ECHO %0 OK
::    )    
    EXIT /B 0
GOTO :EOF *** :_UnitTest__registry.read_string ***

::----------------------------------------------------------------------