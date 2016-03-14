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
::@(#)      %$NAME% [flags]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h          Help page
::@(#)  --selftest  Internal self test (see example below)
::@(#) 
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
::@(#)SELFTEST
::@(#)  Testing the test methods build into %$NAME%:
::@(#)  
::@(#)  %$NAME% --selftest
::@(#)  
::@(#)   Running self tests
::@(#)  ::Missing - no script            [Expect: Missing                 ]
::@(#)  unittest.cmd                     [Missing                         ]
::@(#)  :: match = no hexdump or ref     [Expect: OK                      ]
::@(#)  unittest.cmd                     [OK.                             ]
::@(#)  ::Ref exists                     [Expect: OK                      ]
::@(#)  unittest.cmd                     [OK.                             ]
::@(#)  ::HEXdump exists                 [Expect: OK                      ]
::@(#)  unittest.cmd                     [OK.                             ]
::@(#)  ::Skip file exists               [Expect: Skipped:...             ]
::@(#)  unittest.cmd                     [Skipped:Internal selftest=no te ]
::@(#)  
::@(#)  All self tests are OK
::@(#)
::@ (#)
::@(#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@(#)  errorlevel is 0 if OK, otherwise 1+.
::@(#)
::@ (#)ENVIRONMENT
::@(-)  Variables affected
::@ (#)
::@(#)FILES, 
::@(-)  Files used, required, affected
::@(#)  Test suite in unittest\ directory
::@(#)
::@ (#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@ (#)
::@ (#)
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  _GetOpt.cmd     Parse command line options and create environment vars
::@(#) 
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
    
    IF DEFINED @%$NAME%.selftest (
        CALL :selftest
        IF ERRORLEVEL 1 %_VERBOSE_%: Self test with errors&EXIT /B 1
        %_VERBOSE_% All self tests are OK
        EXIT /B 0
    )
    CALL :CheckTempDir

    IF "#"=="#%~1" (
        %_VERBOSE_% %$NAME% v.%$Version% -- %$Description%
        %_DEBUG_% %$Revision% - %$Comment%

        CALL :InitAll %*
        CALL :RunAll
        %_VERBOSE_% All run
        EXIT /B 0
    ) ELSE (
        :: Testing individual functions
        CALL :Init %* 
        CALL :Process 
    ) >>"%_TEMPDIR%\unittest.log.txt" 2>&1
    CALL :Finalize
    
GOTO :EOF   *** :Main ***

:CheckTempDir
    IF NOT DEFINED _TEMPDIR (
        SET _TEMPDIR=%TEMP%\underscore\
        SET TEMP=%TEMP%\underscore\
    )
    IF NOT EXIST "%_TEMPDIR%" MKDIR "%_TEMPDIR%"
GOTO :EOF   *** :CheckTempDir ***
::---------------------------------------------------------------------

:initAll
    SET _Result=0
    SET _MissingCount=0
    SET _SkippedCount=0
    SET _FailedCount=0
    SET _SuccessCount=0

    CALL :init_logs
    
    SET _ScriptTypes=*.bat *.cmd

    SET _ScriptDir=%~dp0
    ::SET _UnitTestDir=%_ScriptDir%UnitTest\todo\
    SET _UnitTestDir=%_ScriptDir%UnitTests\
GOTO :EOF   *** :initAll ***

:init_logs
    IF NOT DEFINED _MissingLog  SET _MissingLog=%_TEMPDIR%\unittest.missing.log
    IF NOT DEFINED _SkippedLog  SET _SkippedLog=%_TEMPDIR%\unittest.skipped.log
    IF NOT DEFINED _FailedLog   SET _FailedLog=%_TEMPDIR%\unittest.failed.log
    IF NOT DEFINED _SuccededLog SET _SuccededLog=%_TEMPDIR%\unittest.succeded.log
GOTO :EOF

:init
    SET _Result=0

    SET _ScriptDir=%~dp0
    SET _ScriptFile=%~nx1
    IF NOT DEFINED _ScriptFile SET _ScriptFile=%~nx0
    SET _ScriptName=%~n1
    IF NOT DEFINED _ScriptName  SET _ScriptName=%~n0
    IF NOT DEFINED _UnitTestDir SET _UnitTestDir=%_ScriptDir%UnitTests\
    CALL :init_logs
    
    IF NOT "X"=="X%~2" (
        SET _UnitTestScript=%_UnitTestDir%\%~2
    ) ELSE (
        SET _UnitTestScript=%_UnitTestDir%\%~n1.UnitTest%~x1
    )
    
    SET _PatternFile=%~f1
    SET _PatternFile=%_UnitTestScript%
    CALL "%~dp0\_Action" "Name"
    CALL "%~dp0\_Status" "%_scriptName%"
    CALL "%~dp0\_Action" "Testing"
    CALL "%~dp0\_Status" "%_scriptFile%"
    CALL "%~dp0\_Action" "Script Dir"
    CALL "%~dp0\_Status" "%_scriptDir%"
    CALL "%~dp0\_Action" "Unit test"
    CALL "%~dp0\_Status" "%_PatternFile%"
    CALL "%~dp0\_Action" "Unit Test Dir"
    CALL "%~dp0\_Status" "%_UnitTestDir%"
    
    CALL "%~dp0\_Action" "_MissingLog"
    CALL "%~dp0\_Status" "%_MissingLog%"
    CALL "%~dp0\_Action" "_FailedLog"
    CALL "%~dp0\_Status" "%_FailedLog%"

    PUSHD "%~dp0"
GOTO :EOF :init
    
::---------------------------------------------------------------------

:Process
    %_VERBOSE_%:
    CALL "%~dp0\_Action" "%_ScriptFile%">Con:

    TITLE %$NAME%: %_ScriptName% - Cleanup
    
    IF NOT "%$NAME%"=="%_ScriptName%" (
        IF EXIST "%_TEMPDIR%\%_ScriptName%.*" (
            DEL "%_TEMPDIR%\%_ScriptName%.*"
        )
    )

    IF NOT EXIST "%_UnitTestScript%" (
        CALL "%~dp0\_STATUS" "Missing"
        TITLE %$NAME%: %_ScriptName% - Missing
        ECHO:%_UnitTestScript%>>"%_MissingLog%"
        CALL SET _Result=999
        EXIT /b 999
    ) ELSE (
        CALL "%~dp0\_STATE" "Testing..">CON:
        TITLE %$NAME%: %_ScriptName% - Testing
    )
    %_DEBUG_% Script found - result[%_result%]
    
    TITLE %$NAME%: %_ScriptName% - Testing..
    SET ErrorLevel=
    ::CALL :_UnitTest_%_scriptName% %_scriptFile%
    ::CALL "%_UnitTestScript%" %_scriptFile%

    ::SET TEMP
    ::SET _temp
    SET ErrorLevel=
    CALL "%_UnitTestScript%" %_scriptFile%
    SET /A _Result+=%ErrorLevel%
    %_DEBUG_% After test result=[%_result_%]
    ::ECHO FailedLog[%_FailedLog%]>CON:
    :: Skip test
    IF EXIST "%_TEMPDIR%\%_ScriptFile%.skip" (
        SET /A _Result=998
        EXIT /b 998
    )

    %_DEBUG_% no skip - RESULT[%_result%]
    TITLE %$NAME%: %_ScriptName% - Testing done
    
    SET ErrorLevel=
    %_VERBOSE_%: DUMP    "%_TEMPDIR%\%_ScriptFile%.HEXdump"
    %_VERBOSE_%: REF     "%_TEMPDIR%\%_ScriptFile%.ref"
    %_VERBOSE_%: PATTERN "%_TEMPDIR%\%_ScriptFile%.ref"
    IF EXIST "%_TEMPDIR%\%_ScriptFile%.HEXdump" (
        %_VERBOSE_%:- Match hex files "%_ScriptFile%.HEXref" "%_ScriptFile%.HEXdump"
        FC "%_TEMPDIR%\%_ScriptFile%.HEXref" "%_TEMPDIR%\%_ScriptFile%.HEXdump"
    ) ELSE IF EXIST "%_TEMPDIR%\%_ScriptFile%.ref" (
        %_VERBOSE_%:- Match ref files: "%_ScriptFile%.ref" "%_ScriptFile%.dump"
        FC "%_TEMPDIR%\%_ScriptFile%.ref" "%_TEMPDIR%\%_ScriptFile%.dump"
    ) ELSE (
        CALL :MatchTest
    )
    SET /A _Result+=%ErrorLevel%
    %_DEBUG_% no skip - RESULT[%_result%]

    TITLE %$NAME%: %_ScriptName% - %_result%
GOTO :EOF :Process

::---------------------------------------------------------------------
:matchTest
        %_VERBOSE_%:- MatchTest: "%_TEMPDIR%\%_ScriptFile%.dump" "%_patternFile%"
        %_VERBOSE_% Simple match test on output
        %_VERBOSE_% Testing     Target                               patterns

        CALL matchTest "%_TEMPDIR%\%_ScriptFile%.dump" "%_patternFile%" 
        SET /A _Result+=%ErrorLevel%
        %_DEBUG_% matchTest ErrorLevel[%ErrorLevel%]
GOTO :EOF

:Finalize
    %_DEBUG_% %$NAME%:%0 - Start

    IF "0"=="%_Result%" (
        %_DEBUG_% %$NAME%:%0 - Success
        CALL SET /A _SuccessCount+=1
        ECHO:%_UnitTestScript% >>"%_SuccededLog%"
        CALL "%~dp0\_Status" "OK."
    ) ELSE IF "999"=="%_Result%" (
        %_DEBUG_% %$NAME%:%0 - Missing
        CALL SET /A _MissingCount+=1
        ECHO:%_UnitTestScript% >>"%_missingLog%"
        CALL "%~dp0\_Status" "Missing"
    ) ELSE IF "998"=="%_Result%" (
        %_DEBUG_% %$NAME%:%0 - Skipped
        CALL SET /A _SkippedCount+=1
        ECHO:%_UnitTestScript% >>"%_skippedLog%"
        CALL "%~dp0\_State" "Skipped"
        FOR /F "DELIMS=;" %%A IN ('TYPE "%_TEMPDIR%\%_ScriptFile%.skip"') DO CALL "%~dp0\_Status" "%%A"
    ) ELSE (
        %_DEBUG_% %$NAME%:%0 - Failed
        CALL SET /A _FailedCount+=1
        CALL "%~dp0\_Status" "FAIL [%_Result%]"
        ECHO:%_UnitTestScript% >>"%_FailedLog%"
    )
    
    %_DEBUG_% %$NAME%:%0 - End
    EXIT /B %_Result%
GOTO :EOF :Finalize

::---------------------------------------------------------------------

:RunAll
        %_VERBOSE_%:No arg
        CALL :Init %*

        :: Cleanup tmp files
        TITLE %$NAME%: %$NAME% - Cleanup tmp files
        :: Unittest 
        IF EXIST "%_TEMPDIR%\%$NAME%.*" DEL "%_TEMPDIR%\%$NAME%.*"
        
        :: Count status
        FOR /F %%a IN ('DIR /B %_ScriptTypes%^|find /c "."') DO CALL SET _ScriptsTotal=%%a

        CALL "%~dp0\_Action" "Scripts to process"
        CALL "%~dp0\_Status" "%_ScriptsTotal%"
        %_VERBOSE_%: 
        FOR /F %%a IN ('DIR /B %_ScriptTypes%^|sort')  DO CALL %~f0 %%a

        FOR /F %%a IN ('FIND /C "." ^<%_missingLog%')  DO CALL SET _MissingCount=%%a
        FOR /F %%a IN ('FIND /C "." ^<%_skippedLog%')  DO CALL SET _skippedCount=%%a
        FOR /F %%a IN ('FIND /C "." ^<%_failedLog%')   DO CALL SET _failedCount=%%a
        FOR /F %%a IN ('FIND /C "." ^<%_SuccededLog%') DO CALL SET _SuccessCount=%%a

        CALL SET /A _ScriptsCount= %_MissingCount% + %_FailedCount% + %_SuccessCount%

        %_VERBOSE_%:
        CALL "%~dp0\_Action" "Scripts processed"
        CALL "%~dp0\_Status" "%_ScriptsCount%"
        CALL "%~dp0\_Action" "- Missing"
        CALL "%~dp0\_Status" "%_MissingCount%"
        CALL "%~dp0\_Action" "- Failed"
        CALL "%~dp0\_Status" "%_FailedCount%"
        CALL "%~dp0\_Action" "- Skipped"
        CALL "%~dp0\_Status" "%_SkippedCount%"
        CALL "%~dp0\_Action" "- Succeeded"
        CALL "%~dp0\_Status" "%_SuccessCount%"
        
        %_VERBOSE_%:Log files:
        CALL "%~dp0\_Action" "_MissingLog"
        CALL "%~dp0\_Status" "%_MissingLog%"
        CALL "%~dp0\_Action" "_FailedLog"
        CALL "%~dp0\_Status" "%_FailedLog%"
        %_VERBOSE_%:
        %_VERBOSE_%:Logs:
        DIR /B "%_TEMPDIR%\%$NAME%.*.log"

        IF EXIST "%_MissingLog%" START notepad "%_MissingLog%"
        IF EXIST "%_FailedLog%"  START notepad "%_FailedLog%"
        EXIT /B 0
GOTO :EOF

::---------------------------------------------------------------------

:SelfTest
    %_VERBOSE_% %$NAME% v.%$Version% -- %$Description%
    %_DEBUG_% %$Revision% - %$Comment%
    %_VERBOSE_%:
    
    %_DEBUG_% %$NAME%:%0 - start
    SET _TEMPDIR=%TEMP%\underscore\
    %_DEBUG_%: _tempDir="%_TEMPDIR%"

    %_DEBUG_%:Delete old dump files
    FOR %%a IN (main skip ref dump hexdump hexref ) DO (
        %_DEBUG_%:- %~nx0.%%a
        IF EXIST "%_TEMPDIR%%~nx0.%%a" (
            DEL "%_TEMPDIR%%~nx0.%%a"
            %_DEBUG_%:-- Deleted
        ) ELSE (
            %_DEBUG_%:-- OK
        )
    )
    SET _TEMPDIR=

    %_VERBOSE_%: Running aelf tests
    (
        CALL "%~dp0\_Action" "::Missing - no script"
        CALL "%~dp0\_Status" "Expect: Missing"
        CALL "%~f0" "%~nx0" "%~n0.%~n0.missing%~x0"
        
        CALL "%~dp0\_Action" ":: match = no hexdump or ref"
        CALL "%~dp0\_Status" "Expect: OK"
        CALL "%~f0" "%~nx0" "%~n0.%~n0.match%~x0"
        
        CALL "%~dp0\_Action" "::Ref exists"
        CALL "%~dp0\_Status" "Expect: OK"
        CALL "%~f0" "%~nx0" "%~n0.%~n0.ref%~x0"
        
        CALL "%~dp0\_Action" "::HEXdump exists"
        CALL "%~dp0\_Status" "Expect: OK"
        CALL "%~f0" "%~nx0" "%~n0.%~n0.hex%~x0"
            
        CALL "%~dp0\_Action" "::Skip file exists"
        CALL "%~dp0\_Status" "Expect: Skipped:..."
        CALL "%~f0" "%~nx0" "%~n0.%~n0.skip%~x0"
    )

    SET _Status=0

    FC "%TEMP%\underscore\%~nx0.dump" "%TEMP%\underscore\%~nx0.ref">nul 2>&1
    SET /A _Status+=%ErrorLevel%
    %_DEBUG_% dump/ref status=%_status%

    FC "%TEMP%\underscore\%~nx0.hexdump" "%TEMP%\underscore\%~nx0.hexref">nul 2>&1
    SET /A _Status+=%ErrorLevel%
    %_DEBUG_% Hexdump/hexref status=%_status%

    findstr "^Skipped:Internal.selftest=no.test" "%TEMP%\underscore\%~nx0.skip">nul 2>&1
    SET /A _Status+=%ErrorLevel%
    %_DEBUG_% Skip status=%_status%

    %_DEBUG_% %$NAME%:%0 - end
    %_VERBOSE_%:
    EXIT /B %_status%
GOTO :EOF

::*** End Of File *****************************************************