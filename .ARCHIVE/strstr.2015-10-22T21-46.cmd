@ECHO OFF 
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Find string in a string
SET $Author=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $Source=%~dpnx0
::----------------------------------------------------------------------
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
::@(#)  %$Name% pattern string {flags}
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)  pattern The needle to look for
::@(#)  string  The haystack to look in
::@(#)  flags   Flags for FINDSTR ^(see FINDSTR^)
::@(#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Display a tag and an indicator and delays processing for X seconds
::@(#) 
::@(#)
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      REM Match case sensitive
::@(#)      c:\_{GT}strstr xxx abcxXxdefx
::@(#)      No match
::@(#)      
::@(#)      c:\_{GT}echo %errorlevel%
::@(#)      1
::@(#)      
::@(#)      REM Match case insensitive
::@(#)      c:\_{GT}strstr xxx abcxXxdefx /I
::@(#)      Match
::@(#)      c:\_{GT}echo %errorlevel%
::@(#)      0
::@(#) 
::@(#) Please note the absolute exact match requires to follow the
::@(#) FINDSTR syntax
::@(#) 
::@(#)      strstr /C:"Hello world" "Hello wonderfull world" 
::@(#) will not match - since the string pattern is not found
::@(#)      strstr "Hello world" "Hello wonderfull world" 
::@(#) will match - since both the words "world" and "Hello" is found
::@(#) 
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init Description [xx.xxx]
::SET $VERSION=2013-12-27&SET $REVISION=14:35:00&SET $COMMENT=ErikBachmann/Initial [01.000]
::SET $VERSION=2015-02-18&SET $REVISION=15:54:00&SET $COMMENT=ECHO^. to ECHO:
::SET $VERSION=2015-02-19&SET $REVISION=03:13:01&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1


ECHO:%~2 | FINDSTR %~3 "%~1" 1>NUL
SET _result=%ErrorLevel%

IF "0"=="%_result%" (
    ECHO:Match
) ELSE (
    ECHO:No match %_result%
)
ENDLOCAL&exit /B %_result%

::*** End Of File ******************************************************