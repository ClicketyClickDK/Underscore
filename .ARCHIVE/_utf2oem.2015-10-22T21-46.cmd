@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Convert UTF string to OEM and return in VAR
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
::@(#)  %$NAME% ReturVar String
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Returns the string with UTF converted to OEM (ASCII)
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      CALL %$NAME% _ "+™+©+—+Â+ˇ+‡"
::@(#)      ECHO %_%
::@(#) 
::@(#)  Will produce:
::@(#)      Ê¯Â∆ÿ≈
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
::@(#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@(#)  Special characters and diacritics are NOT converted correct
::@ (#)
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  _GetOpt.cmd     Parse command line options and create environment vars
::@(#)
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#)  _Utf2Ansi
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init Description/Initials [xx.xxx]
::SET $VERSION=2011-01-31&SET $REVISION=10:39:00&SET $COMMENT=Initial/ErikBachmann [01.000]
::SET $VERSION=2015-02-19&SET $REVISION=03:39:08&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

::    SET _=%~2
    CALL :map_utf2oem _ %2
    @ENDLOCAL&SET %1=%_%
GOTO :eof

::Convert UTF string to OEM and return in VAR
:map_utf2oem VAR string
    ::SETLOCAL
    SET _=%~2
    SET _=%_:√¶=ë%
    SET _=%_:√∏=õ%
    SET _=%_:√•=Ü%
    SET _=%_:√Ü=í%
    SET _=%_:√ò=ù%
    SET _=%_:√Ö=è%
    ::@ENDLOCAL&SET %1=%_%
GOTO :EOF

::*** End of File ******************************************************