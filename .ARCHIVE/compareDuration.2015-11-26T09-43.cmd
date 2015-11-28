@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Compare duration of two operations
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
::@(#)      %$NAME% [cmd1] [cmd2]
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
::@(#)  %$NAME% "dir/s" "dir/s/b"
::@(#)    
::@(#)  Will return:
::@(#)    compareDuration - Compare duration of two operations
::@(#)    
::@(#)    No of loops                        [20                              ]
::@(#)    Command1                           [dir/s                           ]
::@(#)    Command2                           [dir/s/b                         ]
::@(#)    
::@(#)    Duration                           [dir/s                           ]
::@(#)    _loop                              [20151126085103.217000+060       ]
::@(#)    Start                              [20151126085103.217000+060       ]
::@(#)    End                                [20151126085104.188000+060       ]
::@(#)    Milliseconds                       [971                             ]
::@(#)    Duration                           [00:00:00.971                    ]
::@(#)    
::@(#)    Duration                           [dir/s/b                         ]
::@(#)    _loop2                             [20151126085107.969000+060       ]
::@(#)    Start                              [20151126085107.969000+060       ]
::@(#)    End                                [20151126085108.919000+060       ]
::@(#)    Milliseconds                       [950                             ]
::@(#)    Duration                           [00:00:00.950                    ]
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
::@(#)  Duration.cmd    Get duration between to time stamps
::@(#)  Times.cmd       Get duration of a command
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
  SET $VERSION=2015-11-26&SET $REVISION=11:37:00&SET $COMMENT=EB / Init
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************
::endlocal
:init
    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

    ECHO:%$NAME% - %$DESCRIPTION%
    ECHO:

    SET _MAX_Loop=20
    SET _CMD1=%~1
    SET _CMD2=%~2

:process

    CALL _Action "No of loops"
    CALL _Status "%_MAX_Loop%"

    CALL _Action Command1
    CALL _Status "%_CMD1%"

    CALL _Action Command2
    CALL _Status "%_CMD2%"
    ECHO:


    FOR %%i in (_loop _loop2) DO IF DEFINED %%i SET %%i=

    CALL _Action Duration of command1
    CALL _Status "%_CMD1%"
    CALL duration _loop
    FOR /L %%a IN (1,1,%_MAX_Loop%) DO CALL %_CMD1% >"%TEMP%\cmd1.log" 2>&1
    CALL duration _loop

    CALL _Action Duration of command2
    CALL _Status "%_CMD2%"
    CALL duration _loop2
    FOR /L %%a IN (1,1,%_MAX_Loop%) DO CALL %_CMD2% >"%TEMP%\cmd2.log" 2>&1
    CALL duration _loop2
GOTO :EOF

::*** End of File *****************************************************