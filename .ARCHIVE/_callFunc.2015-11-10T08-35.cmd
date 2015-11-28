@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Function call wrapper
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
::@(#)      %$NAME% [function] {arguments}
::@(#) 
::@(#)   
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)  Function   The function to test 
::@(#)  Arguments  Argument to sendt to function
::@(#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Used in script template
::@(#) 
::@ (#)EXAMPLES
::@(-)  Some examples of common usage.
::@ (#) 
::@ (#) 
::@ (#) 
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)
::@ (#)ENVIRONMENT
::@(-)  Variables affected
::@(#)  $ErrorLevel     Increased with OS errorlevel
::@(#)
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
::@(#)  _action.cmd
::@(#)  _status.cmd
::@(#)
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  
::@ (#)  
::@ (#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@ (#)  URL: http://en.wikipedia.org/wiki/Man_page
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
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm&SET $COMMENT=Description/init
::SET $VERSION=2015-02-19&SET $REVISION=00:00:00&SET $COMMENT=Initial/ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=16:00:00&SET $COMMENT=GetOpt: Calling usage and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************
    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
ENDLOCAL


:CallFunc
    CALL _Action "%~1"

    CALL %~2 %~3 %~4 %~5 %~6 %~7 %~8 %~9
    %_DEBUG_% ErrorLevel: [%ErrorLevel%]
    IF ERRORLEVEL 1 ( 
        SET /A $ErrorLevel+=%ErrorLevel%
        CALL _STATUS "Failure"
    ) ELSE (
        CALL _Status OK
    )

GOTO :EOF

::*** End Of File *****************************************************