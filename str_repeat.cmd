@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Repeat a string
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
::@(#)      %$NAME% STRING TIMES
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)  STRING  The string to be repeated.
::@(#)  TIMES   Number of time the string string should be repeated.
::@(#)          TIMES has to be greater than or equal to 0. If the TIMES is set to 0, the function will return an empty string.
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#) 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  
::@(#)  CALL str_repeat "Xyz" "3"
::@(#)  ECHO:[%str_repeat%]
::@(#) 
::@(#) Will give you:
::@(#)  [XyzXyzXyz]
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
  SET $VERSION=2021-12-28&SET $REVISION=13:20:00&SET $COMMENT=Initial/ErikBachmann
::**********************************************************************
::@(#){COPY}%$VERSION:~0,4% %$Author%
::**********************************************************************
::ENDLOCAL

:MAIN
    :: Initiating global environment
    ::CALL "%~dp0\_PreScript" %* || (CALL %~dp0\_PostScript & EXIT /B 1 )
    CALL "%~dp0\_Prefunction" %* || (CALL %~dp0\_PostScript & EXIT /B 1 )

    :: Initiating Local environment
    ::CALL :Init %*
:Init
    :: Return string in var with function name
    SET str_repeat=%~n0
    :: Remove leading :
    IF ":" == %str_repeat:~0,1% SET str_repeat=%str_repeat:~1%
    SET loop=

::Returns string repeated times times.
:str_repeat      string times
    :: Build the string
    FOR /L %%v IN (1,1,%~2) DO (
        CALL SET "loop=!loop!%~1"
    )
    
    :: Return string
    ENDLOCAL&CALL SET "%str_repeat%=%loop%"
GOTO :EOF

::*** End of File ******************************************************
