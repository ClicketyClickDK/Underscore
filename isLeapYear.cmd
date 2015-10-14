@ECHO OFF
SETLOCAL EnableDelayedExpansion&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Determins wether a given year is a leap year
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
::@(#)      %$NAME% [VAR] [Year]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Set an environment variable LeapYear with the value 1 if the given year½ 
::@(#)  is a leap year. 0 if no a leap year.
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
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
::@ (#)REQUIRES
::@(-)  Dependencies
::@ (#)  
::@ (#)
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  
::@ (#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@(#)  Author:
::@(#)  URL: URL=http://www.robvanderwoude.com/files/datepart_xp.txt 
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
::SET $VERSION=2015-02-19&SET $REVISION=16:00:00&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

    SET UTC=%~2
    IF NOT DEFINED UTC CALL _utc
    CALL :LeapYear %UTC:~0,4%
    ::IF NOT "0"=="%DEBUG%" SET LeapYear
ENDLOCAL&SET %~1=%LeapYear%
GOTO :EOF    

:LeapYear Year
    SET LeapYear=0
    SET /A "Test = %~1 %% 4"
    IF %Test% EQU 0 SET LeapYear=1
    SET /A "Test = %~1 %% 100"
    IF %Test% EQU 0 SET LeapYear=0
    SET /A "Test = %~1 %% 400"
    IF %Test% EQU 0 SET LeapYear=1
GOTO:EOF

::*** End of File ******************************************************