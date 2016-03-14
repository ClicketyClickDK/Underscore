@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Match patterns on a text file
SET $AUTHOR=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)  %$Name% [target] [match]
::@(#) 
::@ (#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  target  is the file to be tested
::@(#)  match   the file containing the match strings
::@:(#)  -h      Help page
::@(#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Runs a series of pattern matchings on a text file
::@(#)
::@(#)  The Match file should contain patterns to match 
::@(#)  prefixed with ::MATCH:: like
::@(#)  ::MATCH::SET.$DESCRIPTION
::@(#)  ::MATCH:vSET.FAILURE
::@(#)
::@(#)  Two special flags can be used:
::@(#)      ::MATCH:v   NOT matching the pattern
::@(#)      ::MATCHi:   Case insensitive
::@(#)
::@(#)  Please note that the pattern is a regular expression for findstr
::@(#)  i.e.
::@(#)  Pattern         Match
::@(#)  Hello.world     The string "Hello?world"
::@(#)  Hello world     Either "Hello" or "world"
::@(#)  ^Hello          "Hello" only at the beginning of the line
::@(#)
::@(#)  Please refer to the command findstr for more info
::@(#)
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  CALL %$NAME% %$SOURCE% %$SOURCE%
::@(#)  
::@(#)  Should display:
::@(#)  
::@(#)      Tests to execute       [2     ]
::@(#)  
::@(#)      1: SET.$DESCRIPTION    [OK    ]
::@(#)      2: SET.FAILURE         [OK    ]
::@(#)  
::@(#)      Tests executed [2]
::@(#)      Tested [matchTest.cmd] [2] OK
::@(#)  
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)  0   OK
::@ (#)  1   Help or manual page 
::@ (#)  1+  Error
::@ (#)
::@ (#)ENVIRONMENT
::@(-)  Variables affected
::@ (#)
::@ (#)
::@ (#)FILES, 
::@(-)  Files used, required, affected
::@ (#)
::@ (#)
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
::@(#)  URL: http://clicketyclick.dk/development/dos/
::@(#)
::@(#)  URL: http://stackoverflow.com/questions/6612415
::@(#)
::@(#)SOURCE
::@(-)  Where to find this source
::@(#)  %$Source%
::@(#)
::@ (#)AUTHOR
::@(-)  Who did what
::@ (#)  %$AUTHOR%
::*** HISTORY **********************************************************
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init Description [xx.xxx]
::SET $VERSION=2015-02-09&SET $REVISION=09:55:05&SET $COMMENT=Erik/Initial
::SET $VERSION=2015-02-19&SET $REVISION=03:07:27&SET $COMMENT=Autoupdate / ErikBachmann
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
  SET $VERSION=2016-03-14&SET $REVISION=10:00:00&SET $COMMENT=Set "%~dp0\ prefix on function calls / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
::ENDLOCAL

:MAIN
    CALL :Init %*
    CALL :Process %*
    CALL :Finalize %*
GOTO :EOF

::----------------------------------------------------------------------

:init
    SET $Status=0
    ::IF /I "" equ "%~1"       %_VERBOSE_% NO Arguments [%~1] - using defaults
    SET _Errors=0
    SET _lines=0
    SET _ErrorsFound=
    SET _script=%~f1
    SET _unittest=%~f2
GOTO :EOF

::---------------------------------------------------------------------

:Process
:matchTest [target] [match strings]
:: inspired by
:: URL: http://stackoverflow.com/questions/6612415/is-there-a-unit-test-framework-for-windows-batch-files
:: answered Jul 7 '11 at 23:41 by Ryan Bemrose

    %_DEBUG_% %$NAME% %0 start
    FOR /F "tokens=1 delims=:" %%G in (
        'findstr "^::MATCH[:vi]*" "%_unittest%"^|findstr /n /v "^#"^|findstr /n ":"') DO (
        CALL SET _TestsExpected=%%G)
    CALL "%~dp0\_Action" "Tests to execute"
    CALL "%~dp0\_Status" "%_TestsExpected%"
    ECHO:
    FOR /F "tokens=*" %%a in ('findstr "^::MATCH[:vi]*" "%_unittest%"') DO (
        CALL SET _pattern=%%a
        CALL SET _OK=OK
        CALL SET _FAIL=FAIL
        CALL SET _patternFlags=!_pattern:~7,2!
        REM :: Set flags /I /V
        IF NOT "::"=="!_patternFlags!" (
            ECHO !_patternFlags!|FIND "v" >NUL
            IF "0"=="!ErrorLevel!" (
                CALL SET _patternFlags=!_patternFlags:v= /v!
                CALL SET _OK=OK = not found
                CALL SET _FAIL=FAIL = found
            )
            CALL SET _patternFlags=!_patternFlags:i= /I!
        )
        REM :: Remove remaining colons
        CALL SET _patternFlags=!_patternFlags::= !
        CALL SET _pattern=!_pattern:~9!

        ECHO:!_pattern!|FindStr "^#" >nul && ECHO:[%%a]|| (
            CALL SET /A _Lines+=1
            ::CALL "_action" "!_lines!: !_pattern!"
            ECHO:!_lines!: !_pattern!
            REM :: Note: pattern is a regular expression!
            ECHO findstr !_patternFlags! "!_pattern!" "%~f1"
            findstr !_patternFlags! "!_pattern!" "%~f1">NUL 2>&1 && CALL "_status" "!_OK!" || call :matchFail "!_pattern!" "!_FAIL!"
        )
    )
    %_DEBUG_% %$NAME% %0 END
GOTO :EOF :matchTest

::---------------------------------------------------------------------

:Finalize
    %_DEBUG_% %$NAME% %0 start
    ECHO:
    ECHO:Tests executed [%_Lines%]
    IF "%_Lines%" NEQ "%_TestsExpected%" (
        ECHO:Attention Not alle tests done: [%_TestsExpected%] expected
    )
    IF 0 NEQ %_Errors% (
        ECHO:Errors: %_Errors% found on line [%_ErrorsFound:~1%]
        EXIT /b %_Errors%
    ) ELSE ECHO:Tested [%~1] [%_lines%] OK
    ENDLOCAL&EXIT /b %_Errors%
GOTO :EOF :Finalize

::---------------------------------------------------------------------

:matchFail [errormessage]
    CALL "_status" "%~2"
    ECHO:- Didn't find string %1
    SET /A _Errors+=1
    SET _ErrorsFound=%_ErrorsFound%,%_lines%
GOTO :EOF :matchFail

::*** Match strings for testing output --------------------------------
::# Test strings for test matching script.bat
::MATCH::SET.$DESCRIPTION
::MATCH:vSET.FAILURE

::*** End of File ******************************************************