@ECHO OFF
SETLOCAL&::(Don't pollute the global environment with the following)
::*********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Action part of _action / _status line
SET $Author=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $Source=%~f0
::----------------------------------------------------------------------
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)  %$NAME% "string"
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  %$NAME% echos a string to STDOUT with the maximum length of $ActionRange.
::@(#)  Line is NOT terminated by a NEWLINE!
::@(#)
::@(#)  %$NAME% is usually used in combination with _status.cmd to display
::@(#)  status information durring processing
::@(#)
::@(#)EXAMPLE
::@(-)  Some examples of common usage.
::@(#)  CALL _ACTION "Hello"
::@(#)  CALL _STATUS "World"
::@(#)
::@(#)  Will produce the line:
::@(#)  Hello                                             [World                   ]
::@(#)
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)  0 if OK
::@ (#)
::@ (#)ENVIRONMENT
::@(-)  Variables affected
::@ (#)
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
::@(#)
::@(#)SEE ALSO
::@(#)  _status.cmd
::@(#)  _state.cmd
::@(#)
::@(#)SOURCE
::@(-)  Where to find this source
::@(#)  %$Source%
::@(#) 
::**********************************************************************
::History
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Comment/Init [00.000]
::SET $VERSION=2010-10-07&SET $REVISION=08:35:00&SET $COMMENT=Intial/ErikBachmann [00.010]
::SET $VERSION=2010-10-20&SET $REVISION=17:15:00&SET $COMMENT=Addding $Source/ErikBachmann [01.011]
::SET $VERSION=2011-01-17&SET $REVISION=15:43:00&SET $COMMENT=ActionRange=45/ErikBachmann [01.012]
::SET $VERSION=2015-02-19&SET $REVISION=03:18:29&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=16:00:00&SET $COMMENT=GetOpt: Calling usage and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************
::ENDLOCAL

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
::ENDLOCAL

:_Action
    SETLOCAL
    SET _=%~1
    IF NOT DEFINED $ActionRange SET $ActionRange=45
    ::FOR /L %%i IN (0,1,%$ActionRange%) DO CALL SET "_=%_%_"
    SET _=%_%                                                                     !

    CALL SET /P _=%%_:~0,%$ActionRange%%%<nul
    ENDLOCAL
    EXIT /b 0
GOTO :EOF

::*** End of File ******************************************************