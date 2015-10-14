::@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Convert UTF string to ANSI and return in VAR
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
::@(#)  Returns the string with UTF converted to Ansi
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      CALL %$NAME% _ "+ª+©+Ñ+å+ÿ+à"
::@(#)      ECHO %_%
::@(#) 
::@(#)  Will produce:
::@(#)      µ°ÕãÏ+
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
::@(#)  
::@ (#)REQUIRES
::@(-)  Dependencies
::@ (#)  
::@ (#)
::@(#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#)  _Utf2Oem
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init Description/Initials [xx.xxx]
::SET $VERSION=2011-01-31&SET $REVISION=10:39:00&SET $COMMENT=Initial/ErikBachmann [01.000]
::SET $VERSION=2015-02-19&SET $REVISION=03:38:35&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

::    SET _=%~2
    CALL :map_utf2ansi _ %2
    @ENDLOCAL&SET %1=%_%
GOTO :eof

::Convert UTF string to ANSI and return in VAR
:map_utf2ansi VAR string
    ::SETLOCAL
    SET _=%~2
    SET _=%_:Ã¦=æ%
    SET _=%_:Ã¸=ø%
    SET _=%_:Ã¥=å%
    SET _=%_:Ã†=Æ%
    SET _=%_:Ã˜=Ø%
    SET _=%_:Ã…=Å%
    ::@ENDLOCAL&SET %1=%_%
GOTO :EOF

::*** End of File ******************************************************