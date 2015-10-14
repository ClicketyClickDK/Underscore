

::----------------------------------------------------------------------

:_UnitTest__debug
SETLOCAL

    SHIFT
    SET _args=$LogFile $TraceFile _DEBUG_ _Log_ _TRACE_ _VERBOSE_ _Error_
    FOR %%a IN ( %_Args% ) DO SET %%a=
    CALL _DEBUG
    :: Create ref
    (
        FOR %%a IN ( %_Args% ) DO ECHO:%%a defined 
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    CALL %0 2>>"%TEMP%\%0.trc" 1>&2
    :: Dump data
    (
        FOR %%a IN ( %_Args% ) DO (
            IF DEFINED %%a (
                ECHO:%%a defined 
            ) ELSE (
                ECHO:%%a NOT defined 
            )
        )
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_0template ***

::----------------------------------------------------------------------