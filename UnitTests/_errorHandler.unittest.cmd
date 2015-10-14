
::---------------------------------------------------------------------

:_UnitTest__errorhandler
    SHIFT

    (
        ECHO %0
        :: Create ref
        ECHO :: Create ref
    )>"%TEMP%\%0.trc"
    
    (
        ECHO:
        ECHO:_errorhandler.cmd(^)[ERROR.000]: Testing error 0 
        ECHO:::#Error.000 Error.000 -- Template
        ECHO:::#Error.000 // *Cause: 
        ECHO:::#Error.000 // *Action: 
        ECHO:////
        ECHO:[{CrLf}::#Error.000 Error.000 -- Template{CrLf}::#Error.000 // *Cause: {CrLf}::#Error.000 // *Action: ]
        ECHO:////
        ECHO:
    )>>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    echo CALL %0 "%0" "ERROR.000" "Testing error 0" -1 Continue
    :: Dump test data
    (
        CALL %0 "%0" "ERROR.000" "Testing error 0" -1 Continue
    )>"%TEMP%\%0.dump" 2>&1
GOTO :EOF *** :_UnitTest__errorhandler ***

::---------------------------------------------------------------------