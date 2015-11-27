

::----------------------------------------------------------------------

:_UnitTest_updateArchive
SETLOCAL

    SHIFT
    IF EXIST "%_ScriptDir%\.archive\current" (
        DEL "%_ScriptDir%\.archive\current" 
    ) 1>&2 2>>"%TEMP%\%0.trc"
    
    CALL %0 2>>"%TEMP%\%0.trc" 1>&2
    IF ERRORLEVEL 1 CALL :skip %ErrorLevel% >>"%TEMP%\%0.skip" 2>nul
    
    :: Create ref
    (
        ECHO:current
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        ::ECHO DIR /B "%_ScriptDir%\.archive\current"
        DIR /B "%_ScriptDir%\.archive\current"
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_updateArchive ***

::----------------------------------------------------------------------
:SKIP
    Echo:Check internet connection&exit /b %1
GOTO :EOF