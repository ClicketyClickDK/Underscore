

::----------------------------------------------------------------------

:_UnitTest_updateArchive
SETLOCAL

    SHIFT
    IF EXIST "%_ScriptDir%\.archive\current" (
        DEL "%_ScriptDir%\.archive\current" 
    ) 1>&2 2>>"%TEMP%\%0.trc"
    
    CALL %0 2>>"%TEMP%\%0.trc" 1>&2 
    :: Create ref
    (
        ECHO:current
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        DIR /B "%_ScriptDir%\.archive\current"
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_updateArchive ***

::----------------------------------------------------------------------