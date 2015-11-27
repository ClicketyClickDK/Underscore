@ECHO OFF&SETLOCAL
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Parse command line options for help flags only
SET $Author=Erik Bachmann, ClicketyClick.dk (ErikBachmann@ClicketyClick.dk)
SET $SOURCE=%~f0
::----------------------------------------------------------------------
::@(#)NAME
::@(#)  %$Name% -- %$Description%
::@(#) 
::@(#)SYNOPSIS
::@(#)      CALL %$Name% %*
::@(#)  
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Usage/Help page and exit 1 (Hard coded)
::@(#)  --help  Usage/Help page and exit 1 (Hard coded)
::@(#)  -? /?   Usage/Help page and exit 1 (Hard coded)
::@(#)  
::@(#)DESCRIPTION
::@(#)  Build named environment variables from command line options
::@(#)  Slim-line version of _GetOpt
::@(#)  
::@(#)  Responds ONLY to help flags: -h and --help
::@(#)  
::@(#)  Faster than _getOpt at a ration 1:3,5
::@(#) 
::@(#)  NOTE!
::@(#)      If you entend to nest scripts both using %$NAME% you must 
::@(#)      start the nested script with a SETLOCAL statement to preserve
::@(#)      the callers environment!
::@(#) 
::@(#)EXAMPLES:
::@(#)  SET $SOURCE=%~f0
::@(#)  ::Parse options to current script
::@(#)  CALL %$NAME% %*&IF ERRORLEVEL 1 EXIT /B 1
::@(#) 
::@(#)  NOTE: "-flag" and "file" are NOT combined
::@(#) 
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  
::@(#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@(#)  0   OK
::@(#)  1   Usage (or error)
::@(#)  
::@(#)ENVIRONMENT
::@(-)  Variables affected
::@(#)  Will change environment according to the given arguments.
::@(#) 
::@(#)  If environment var DEBUG is defined and > 1 debug will be enabled as default.
::@(#) 
::@(#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@(#)  
::@(#)REQUIRES
::@(-)  Dependencies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  what.cmd        Show usage
::@(#) 
::@(#)REFERENCES:
::@(#)  https://en.wikipedia.org/wiki/Getopt
::@(#)  
::@(#)SOURCE
::@(#)  %$Source%
::----------------------------------------------------------------------
::History
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm:ss&SET COMMENT=Init/Description
::SET $VERSION=00.000&SET $REVISION=2009-04-17T11:01:00&SET COMMENT=ebp/Initial
  SET $VERSION=2015-11-07&SET $REVISION=17:28:00&SET $COMMENT=Clean up in debug info / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************
ENDLOCAL

:MAIN

:: Check for -h and --help
ECHO:%*| findstr /I "\<[-/][-/]*h\> \<[-/][-/]*help\>" >nul 2>&1 
IF NOT ERRORLEVEL 1 CALL "%~dp0\what" "%$SOURCE%" & EXIT /b 1 
:: Else return quietly
EXIT /b 0

::*** End of File *****************************************************