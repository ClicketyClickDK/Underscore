::----------------------------------------------------------------------

:_UnitTest_head
    SETLOCAL
    SHIFT

    (
        ECHO:@ECHO OFF
        ECHO:SETLOCAL ENABLEDELAYEDEXPANSION&::^(Don't pollute the global environment with the following^)
        ECHO:::*********************************************************************
        ECHO:SET $NAME=^%~n0
        ECHO:SET $DESCRIPTION=Print the first n lines of a file to STDOUT
        ECHO:SET $SOURCE=^%~f0
        ECHO:SET $Author=Erik Bachmann, ClicketyClick.dk (E_Bachmann@ClicketyClick.dk)
    )1>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"
    
    ::>"%TEMP%\%0.hex" 2>&1 CALL tail.cmd "%~dp0\tail.cmd" 4
    ::COPY "%TEMP%\%0.hex" "%TEMP%\%0.dump" >nul 
    >"%TEMP%\%0.dump" 2>&1 CALL head.cmd "%~dp0\head.cmd" 4
    ENDLOCAL
GOTO :EOF *** :_UnitTest_tail ***

::----------------------------------------------------------------------
