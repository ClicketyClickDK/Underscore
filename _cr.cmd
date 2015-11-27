@ECHO OFF
SETLOCAL&::(Don't pollute the global environment with the following)
::*********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Create a Cariage Return variable
SET $Author=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $Source=%~f0
::----------------------------------------------------------------------
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)  %$NAME% -- %$Description%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)  CALL %$NAME%
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Create a environment variable _CR with a single Cariage Return
::@(#)  Useful for printing multiple messages on one line
::@(#)
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  SETLOCAL ENABLEDELAYEDEXPANSION
::@(#)  CALL _CR
::@(#)  SET /P _=-- {PCT}CD{PCT} : OK      {EXCL}CR{EXCL}{LT}nul
::@(#)
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)  0 if OK
::@ (#)
::@ (#)ENVIRONMENT
::@(-)  Variables affected
::@ (#) _CR     Holds a Carriage retur
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
::@(#)SEE ALSO
::@(#)  _BS.cmd     Back space
::@(#)  _LF.cmd     Line Feed
::@(#)
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Comment/Init [00.000]
::SET $VERSION=00.010&SET $REVISION=2013-10-02T198:50:00&SET $COMMENT=Intial/ErikBachmann
::SET $VERSION=2015-02-19&SET $REVISION=03:20:37&SET $COMMENT=Autoupdate / ErikBachmann
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
  SET $VERSION=2015-11-23&SET $REVISION=16:30:00&SET $COMMENT=GetOpt replaced _getopt.sub simple call. Reduces runtime to 1/3 / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************
    CALL "%~dp0\_DEBUG"
    ::CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
    :: Check ONLY for combinations of -h, /h, --help
    CALL _getopt.sub %*&IF ERRORLEVEL 1 EXIT /B 1

ENDLOCAL

::----------------------------------------------------------------------

    ::Define CR variable containing a carriage return (0x0D)
    for /f %%a in ('copy /Z "%~dpf0" nul') do set "_CR=%%a"
GOTO :EOF
::&CALL SET _CR=%_CR%

::*** End of File *****************************************************