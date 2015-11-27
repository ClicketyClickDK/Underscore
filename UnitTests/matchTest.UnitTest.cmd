

::----------------------------------------------------------------------

:_UnitTest_matchTest
SETLOCAL

    SHIFT
    
    :: Create ref
    (
        ECHO:Tests to execute                             [2                               ]
        ECHO:
        ECHO:1: SET.$DESCRIPTION
        ECHO:findstr    "SET.$DESCRIPTION" "%_scriptDir%matchTest.cmd"
        ECHO:[OK                              ]
        ECHO:2: SET.FAILURE
        ECHO:findstr   /v "SET.FAILURE" "%_scriptDir%matchTest.cmd"
        ECHO:[OK = not found                  ]
        ECHO:
        ECHO:Tests executed [2]
        ECHO:Tested [%_scriptDir%\matchTest.cmd] [2] OK
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        CALL "%_scriptDir%\matchTest.cmd" "%_ScriptDir%\matchTest.cmd" "%_ScriptDir%\matchTest.cmd"
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_matchTest ***

::----------------------------------------------------------------------