@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Unittest for Underscore
SET $AUTHOR=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
::**********************************************************************
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)      %$NAME%
::@(#)      %$NAME% [function]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Runs a test suite for the function.
::@(#)  If a function is given as argument, this specific function is tested.
::@(#)  If no argument is given, the entire suite is tested.
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)    unittest what.cmd
::@(#)    what.cmd                                [OK.                             ] 
::@(#) 
::@(#)    unittest
::@(#)    
::@(#)    unittest v.2015-03-19 -- Unittest for Underscore
::@(#)    No arg
::@(#)    Name                                    [                                ]
::@(#)    Testing                                 [                                ]
::@(#)    Script Dir                              [C:\_\                           ]
::@(#)    Unit test                               [                                ]
::@(#)    Unit Test Dir                           [C:\_\UnitTests\                 ]
::@(#)    _MissingLog                             [C:\Users\ERIKBA~1\AppData\Local ]
::@(#)    _FailedLog                              [C:\Users\ERIKBA~1\AppData\Local ]
::@(#)    Scripts to process                      [83                              ]
::@(#)    :
::@(#)    :
::@(#)    shortDate2Iso.cmd                       [OK.                             ]
::@(#)    startScreenSaver.cmd                    [Skipped:Win internal=no test    ]
::@(#)    strstr.cmd                              [OK.                             ]
::@(#)    tail.cmd                                [OK.                             ]
::@(#)    test.date2jdate.cmd                     [Skipping: Test module. No funct ]
::@(#)    unittest.cmd                            [Skipped:Template=no test        ]
::@(#)    unzip.bat                               [OK.                             ]
::@(#)    Utc2JulianDate.cmd                      [OK.                             ]
::@(#)    wget.bat                                [FAIL [2]                        ]
::@(#)    what.cmd                                [OK.                             ]
::@(#)    which.cmd                               [OK.                             ]
::@(#)    zip.bat                                 [OK.                             ]
::@(#)      
::@(#)    Scripts processed                       [69                              ]
::@(#)    - Missing                               [1                               ]
::@(#)    - Failed                                [4                               ]
::@(#)    - Skipped                               [14                              ]
::@(#)    - Succeeded                             [64                              ]
::@(#)    Log files:
::@(#)    _MissingLog                             [C:\Users\ERIKBA~1\AppData\Local ]
::@(#)    _FailedLog                              [C:\Users\ERIKBA~1\AppData\Local ]
::@(#)      
::@(#)    HKEY_LOCAL_MACHINE.failed.log
::@(#)    HKEY_LOCAL_MACHINE.missing.log
::@(#)    All run
::@(#) 
::@(#)
::@(#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@(#)  errorlevel is 0 if OK, otherwise 1+.
::@(#)
::@ (#)ENVIRONMENT
::@(-)  Variables affected
::@ (#)
::@ (#)
::@(#)FILES, 
::@(-)  Files used, required, affected
::@(#)  Test suite in unittest\ directory
::@(#)
::@ (#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@ (#)
::@ (#)
::@ (#)REQUIRES
::@(-)  Dependencies
::@ (#)  
::@ (#)
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  
::@ (#)  
::@ (#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@ (#)  URL: 
::@ (#) 
::@(#)
::@(#)SOURCE
::@(-)  Where to find this source
::@(#)  %$Source%
::@(#)
::@ (#)AUTHOR
::@(-)  Who did what
::@ (#)  %$AUTHOR%
::*** HISTORY **********************************************************
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Description/init
::SET $VERSION=2015-30-30&SET $REVISION=11:37:00&SET $COMMENT=EB / Init
::SET $VERSION=2015-10-08&SET $REVISION=16:00:00&SET $COMMENT=GetOpt: Calling usage and exit on error / ErikBachmann
  SET $VERSION=2015-10-09&SET $REVISION=10:20:00&SET $COMMENT=Temp and log files in %TEMP%\underscore\ / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************
::endlocal
    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

:Main
    CALL "%~dp0\_debug"
    SET _TEMPDIR=%TEMP%\underscore\
    IF NOT EXIST "%_TEMPDIR%" MKDIR "%_TEMPDIR%"
    
    IF "#"=="#%~1" (
        %_VERBOSE_% %$NAME% v.%$Version% -- %$Description%
        %_DEBUG_% %$Revision% - %$Comment%

        CALL :Init_main %*
        CALL :RunAll
        ECHO All run
        EXIT /B 0
    )
    
    (
    ENDLOCAL
        CALL :Init %*
        CALL :Process 
    
    )>>"%_TEMPDIR%\unittest.log.txt" 2>&1
    CALL :Finalize
    
GOTO :EOF :Main

::---------------------------------------------------------------------

:init_main
    SET _Result=0
    SET _MissingCount=0
    SET _SkippedCount=0
    SET _FailedCount=0
    SET _SuccessCount=0

    SET _MissingLog=%_TEMPDIR%\unittest.missing.log
    SET _FailedLog=%_TEMPDIR%\unittest.failed.log
    SET _ScriptTypes=*.bat *.cmd

    SET _ScriptDir=%~dp0
    ::SET _UnitTestDir=%_ScriptDir%UnitTest\todo\
    SET _UnitTestDir=%_ScriptDir%UnitTests\
GOTO :EOF

:init
    ::ECHO:INIT >CON:
    SET _Result=0

    SET _ScriptFile=%~nx1
    IF NOT DEFINED _ScriptFile SET _ScriptFile=%~nx0
    SET _ScriptName=%~n1
    IF NOT DEFINED _ScriptName SET _ScriptName=%~n0
    IF NOT DEFINED _UnitTestDir SET _UnitTestDir=%_ScriptDir%UnitTests\
    
    SET _UnitTestScript=%_UnitTestDir%\%~n1.UnitTest%~x1

    SET _PatternFile=%~f1
    CALL _Action "Name"
    CALL _Status "%_scriptName%"
    CALL _Action "Testing"
    CALL _Status "%_scriptFile%"
    CALL _Action "Script Dir"
    CALL _Status "%_scriptDir%"
    CALL _Action "Unit test"
    CALL _Status "%_PatternFile%"
    CALL _Action "Unit Test Dir"
    CALL _Status "%_UnitTestDir%"

    
    CALL _Action "_MissingLog"
    CALL _Status "%_MissingLog%"
    CALL _Action "_FailedLog"
    CALL _Status "%_FailedLog%"

    PUSHD "%~dp0"
GOTO :EOF :init
    
::---------------------------------------------------------------------

:Process
    ECHO:
    CALL _Action "%_ScriptFile%">Con:

    TITLE %$NAME%: %_ScriptName% - Cleanup
    ::ECHO: "%$NAME%"=="%_ScriptName%" >CON:
    
    IF NOT "%$NAME%"=="%_ScriptName%" (
        IF EXIST "%_TEMPDIR%\%_ScriptName%.*" (
            DEL "%_TEMPDIR%\%_ScriptName%.*"
        )
    )
    IF NOT "0"=="%DEBUG%" ECHO - 18 RESULT[%_result%]
    
    TITLE %$NAME%: %_ScriptName% - Testing..
    SET ErrorLevel=
    ::CALL :_UnitTest_%_scriptName% %_scriptFile%
    IF NOT "0"=="%DEBUG%" ECHO "Test run:"
    IF NOT "0"=="%DEBUG%" ECHO:CALL "%_UnitTestScript%" %_scriptFile%

    IF NOT EXIST "%_UnitTestScript%" (
        CALL _STATUS "Missing"
        TITLE %$NAME%: %_ScriptName% - Missing
        ECHO:%_UnitTestScript%>>"%_MissingLog%"
        CALL SET _Result=999
        EXIT /b 999
    ) ELSE (
        CALL _STATE "Testing..">CON:
        TITLE %$NAME%: %_ScriptName% - Testing
    )
    
    SET ErrorLevel=
    CALL "%_UnitTestScript%" %_scriptFile%
    SET /A _Result+=%ErrorLevel%

    ::ECHO FailedLog[%_FailedLog%]>CON:
    :: Skip test
    IF EXIST "%_TEMPDIR%\%_ScriptFile%.skip" (
        SET /A _Result=998
        EXIT /b 998
    )

    IF NOT "0"=="%DEBUG%" ECHO - 26 RESULT[%_result%]
    TITLE %$NAME%: %_ScriptName% - Testing done
    
    SET ErrorLevel=
    IF EXIST "%_TEMPDIR%\%_ScriptFile%.HEXdump" (
        FC "%_TEMPDIR%\%_ScriptFile%.HEXref" "%_TEMPDIR%\%_ScriptFile%.HEXdump"
    ) ELSE IF EXIST "%_TEMPDIR%\%_ScriptFile%.ref" (
        FC "%_TEMPDIR%\%_ScriptFile%.ref" "%_TEMPDIR%\%_ScriptFile%.dump"
    ) ELSE (
        ECHO Simple match test on output
        ECHO Testing     Target                               patterns

        CALL matchTest "%_TEMPDIR%\%_ScriptFile%.dump" "%_patternFile%" 
        SET /A _Result+=%ErrorLevel%
    )
    SET /A _Result+=%ErrorLevel%
    IF NOT "0"=="%DEBUG%" ECHO - 34 RESULT[%_result%]
    TITLE %$NAME%: %_ScriptName% - %_result%
GOTO :EOF :Process

::---------------------------------------------------------------------

:Finalize
    IF "0"=="%_Result%" (
        CALL SET /A _SuccessCount+=1
        CALL _Status "OK."
    ) ELSE IF "999"=="%_Result%" (
        CALL SET /A _MissingCount+=1
        CALL _Status "Missing"
    ) ELSE IF "998"=="%_Result%" (
        CALL SET /A _SkippedCount+=1
        CALL _State "Skipped"
        FOR /F "DELIMS=;" %%A IN ('TYPE "%_TEMPDIR%\%_ScriptFile%.skip"') DO CALL _Status "%%A"
        
    ) ELSE (
        CALL SET /A _FailedCount+=1
        CALL _Status "FAIL [%_Result%]"
        ECHO:%_UnitTestScript%>>"%_FailedLog%"
        REM ECHO:"%_FailedLog%">CON:
    )
    REM dir /b "%_FailedLog%">CON:
    ::ENDLOCAL&SET /A _Result+=%_Result%&SET /A _MissingCount+=%_MissingCount%&SET /A _FailedCount+=%_FailedCount%
    ::SET _
    EXIT /B %_Result%
GOTO :EOF :Finalize

::---------------------------------------------------------------------

:RunAll
        ECHO No arg
        CALL :Init %*

        :: Cleanup tmp files
        TITLE %$NAME%: %$NAME% - Cleanup
        :: Unittest 
        IF EXIST "%_TEMPDIR%\%$NAME%.*" DEL "%_TEMPDIR%\%$NAME%.*"
        
        
        FOR /F %%a IN ('DIR /B %_ScriptTypes%^|find /c "."') DO CALL SET _ScriptsTotal=%%a

        CALL _Action "Scripts to process"
        CALL _Status "%_ScriptsTotal%"
        ECHO: 
        FOR /F %%a IN ('DIR /B %_ScriptTypes%^|sort') DO CALL %~f0 %%a

        CALL SET /A _ScriptsCount= %_MissingCount% + %_FailedCount% + %_SuccessCount%

        ECHO:
        CALL _Action "Scripts processed"
        CALL _Status "%_ScriptsCount%"
        CALL _Action "- Missing"
        CALL _Status "%_MissingCount%"
        CALL _Action "- Failed"
        CALL _Status "%_FailedCount%"
        CALL _Action "- Skipped"
        CALL _Status "%_SkippedCount%"
        CALL _Action "- Succeeded"
        CALL _Status "%_SuccessCount%"
        
        ECHO:Log files:
        CALL _Action "_MissingLog"
        CALL _Status "%_MissingLog%"
        CALL _Action "_FailedLog"
        CALL _Status "%_FailedLog%"
        ECHO:
        DIR /B "%_TEMPDIR%\%$NAME%.*.log"

        ::IF NOT "0"=="%DEBUG%" ECHO IF EXIST "%_MissingLog%" START notepad "%_MissingLog%"
        ::IF NOT "0"=="%DEBUG%" ECHO IF EXIST "%_FailedLog%"  START notepad "%_FailedLog%"
        IF EXIST "%_MissingLog%" START notepad "%_MissingLog%"
        IF EXIST "%_FailedLog%" START notepad "%_FailedLog%"
        EXIT /B 0
GOTO :EOF

::*** End Of File *****************************************************