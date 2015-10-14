::----------------------------------------------------------------------

:_UnitTest_strstr
    SHIFT
    SETLOCAL ENABLEDELAYEDEXPANSION
    :: Create ref
    (
        ECHO:No match 1
        ECHO:1
        ECHO:Match
        ECHO:0
        ECHO:Match
        ECHO:0
        ECHO:Match
        ECHO:0
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"
    
    ::Dump test data
    (
        CALL strstr "xxx" "AxXxB"
        ECHO:!ErrorLevel!
        CALL strstr "xxx" "AxxxB"
        ECHO:!ErrorLevel!
        CALL strstr "xxx" "AxXxB" /I
        ECHO:!ErrorLevel!
        CALL strstr "xxx" "AxxxB" /I
        ECHO:!ErrorLevel!
    )>"%TEMP%\%0.dump" 2>>"%TEMP%\%0.trc"
GOTO :EOF *** strstr ***

::----------------------------------------------------------------------