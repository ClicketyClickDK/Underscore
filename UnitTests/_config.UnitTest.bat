

::----------------------------------------------------------------------

:_UnitTest__config
SETLOCAL

    SHIFT
    SET _args=_LOGFILE _TraceFile _SysAdmMail
    :: Create ref
    (
        FOR %%a IN ( %_Args% ) DO ECHO:%%a defined 
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    CALL %0  1>&2 2>>"%TEMP%\%0.trc"
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