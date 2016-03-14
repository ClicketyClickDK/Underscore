@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Test if argument is numeric
SET $AUTHOR=jeb
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
::@(#)  Tests if argument is numeric. Accepted digits are "0-9,."
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)        CALL _IsNumeric 12
::@(#)        IF ERRORLEVEL 1 (ECHO not) ELSE ECHO:OK
::@(#)        OK
::@(#)        
::@(#)        CALL _IsNumeric x12
::@(#)        IF ERRORLEVEL 1 (ECHO not) ELSE ECHO:OK
::@(#)        not
::@(#)        
::@(#)        CALL _IsNumeric 1.2
::@(#)        IF ERRORLEVEL 1 (ECHO not) ELSE ECHO:OK
::@(#)        OK
::@(#)        
::@(#)        CALL _IsNumeric 1a2
::@(#)        IF ERRORLEVEL 1 (ECHO not) ELSE ECHO:OK
::@(#)        not
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
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@(#)  Author: jeb
::@(#)  URL: http://www.dostips.com/forum/viewtopic.php?f=3{AMP}t=193
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
::SET $VERSION=2007-08-30&SET $REVISION=15:13:00&SET $COMMENT=Initial/jeb
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::SET $VERSION=2015-11-23&SET $REVISION=16:30:00&SET $COMMENT=GetOpt replaced _getopt.sub simple call. Reduces runtime to 1/3 / ErikBachmann
  SET $VERSION=2016-03-14&SET $REVISION=10:00:00&SET $COMMENT=Set "%~dp0\ prefix on function calls / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    ::CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
    :: Check ONLY for combinations of -h, /h, --help
    CALL "%~dp0\_getopt.sub" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

:isnumeric
:: http://www.dostips.com/forum/viewtopic.php?f=3&t=193
:: jeb  30 Aug 2007 15:13
SETLOCAL
    SET _rest=_
    FOR /F "delims=.,0123456789" %%a IN ("%~1") DO SET _rest=_%%a
    SET _return=1
    IF "%_rest%"=="_" SET _return=0
    EXIT /B %_Return%
::    ( endlocal
::        if "%~2" NEQ "" set %~2=%return%
::        goto:eof
::    )
ENDLOCAL
GOTO :EOF

::*** End of File *****************************************************