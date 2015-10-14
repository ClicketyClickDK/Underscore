
::----------------------------------------------------------------------

:_UnitTest_removeVarByType
SETLOCAL

    SHIFT
    (
        ECHO %0
        :: Create ref
        ECHO :: Create ref
    )>"%TEMP%\%0.trc"
    
    (
        ECHO:- Removing vars [#]: 2                       [Done                            ]
        ECHO:- Removing vars [#]: 0                       [Done                            ]
    )>>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    CALL removevarbytype #>nul 2>&1
    
    :: Dump test data
    (
        SET #x=x
        SET #y=y
        CALL removevarbytype #
        CALL removevarbytype #
    )>"%TEMP%\%0.dump" 2>&1
GOTO :EOF *** :_UnitTest_removeVarByType  ***

::----------------------------------------------------------------------