@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Template for DOS batch script
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
::@(#)      %$NAME% [VAR]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#) 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#) 
::@(#) 
::@(#) 
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
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
::@(#) _Prescript.cmd
::@(#) _PostScript.cmd
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
::SET $VERSION=2015-02-19&SET $REVISION=00:00:00&SET $COMMENT=Initial/ErikBachmann
  SET $VERSION=2016-03-14&SET $REVISION=10:00:00&SET $COMMENT=Set "%~dp0\ prefix on function calls / ErikBachmann
::**********************************************************************
::@(#){COPY}%$VERSION:~0,4% %$Author%
::**********************************************************************
::ENDLOCAL

:MAIN
    :: Initiating global environmen
    CALL "%~dp0\_PreScript" %* || (CALL %~dp0\_PostScript & EXIT /B 1 )

    :: Initiating Local environmen
    CALL :Init %*

    :: DO what you have to do! 
    :: DoSomething returns the argument as errorlevel
    :: 0 = OK
    CALL :CallFunc "Do something 0"         ":DoSomething 0"
    :: 1 = error
    CALL :CallFunc "Do something 1"         :DoSomething 1
    :: none = OK
    CALL :CallFunc "Do something none"      :DoSomething
    :: callfunc
    CALL :CallFunc "Do something callfunc"  ":DoSomething"
    :: call with error
    CALL :CallFunc "DIR out error"          ">out.err.txt 2>&1" "DIR /w XX: "
    :: successfull call
    CALL :CallFunc "DIR out OK"             ">>out.ok.txt 2>&1" "DIR /b %SystemDrive%\"

    :: Post processing
    CALL "%~dp0\_PostScript"
GOTO :EOF

::----------------------------------------------------------------------

:: Local initiation for this script only
:init
    SET $Status=0
    ::IF /I "" equ "%~1"       %_VERBOSE_% NO Arguments [%~1] - using defaults

GOTO :EOF

::---------------------------------------------------------------------

:: Dummy function
:DoSomething arg
    ::exit /b 0
    EXIT /b %1
GOTO :EOF

::---------------------------------------------------------------------

:: SubFunction handling status reports, verbose info and trace
:CallFunc [Argument]
    CALL "%~dp0\_Action" "%~1"

    CALL %~2 %~3 %~4 %~5 %~6 %~7 %~8 %~9
    %_DEBUG_% ErrorLevel: [%ErrorLevel%]
    IF ERRORLEVEL 1 ( 
        SET /A $ErrorLevel+=%ErrorLevel%
        CALL "%~dp0\_STATUS" "Failure"
    ) ELSE (
        CALL "%~dp0\_Status" OK
    )
GOTO :EOF

::*** End of File ******************************************************