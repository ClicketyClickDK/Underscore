@ECHO OFF
SETLOCAL ENABLEEXTENSIONS EnableDelayedExpansion&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Convert Julian date [Numeric] to UTC [YYYY-MM-MM]
SET $AUTHOR=Erik Bachmann Pedersen, ClicketyClick.dk [E_Bachmann@ClicketyClick.dk]
SET $SOURCE=%~f0
::----------------------------------------------------------------------
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)  %$Name% varJD stringUTC
::@(#)
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  
::@(#)  
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  CALL JulianDate2utc #JD "24552172010-01-20"
::@(#)  SET #JD
::@(#)  #JD=2010-01-20
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
::@ (#)REQUIRES
::@(-)  Dependencies
::@ (#)  
::@ (#)
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#)  Utc2JulianDate
::@ (#)  
::@ (#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@ (#)  URL: 
::@(#)  http://aa.usno.navy.mil/faq/docs/JD_Formula.php
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
::SET $VERSION=2014-01-08&SET $REVISION=11:10:00&SET $COMMENT=EBP/Initial [01.000]
::SET $VERSION=2015-02-19&SET $REVISION=03:06:20&SET $COMMENT=Autoupdate / EBP
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1


:JulianDate2utc varJD stringUTC
    :: URL=http://aa.usno.navy.mil/faq/docs/JD_Formula.php
    SET JD=%~2
    SET /A L= JD+68569
    SET /A N= 4*L/146097
    SET /A L= L-(146097*N+3)/4
    SET /A I= 4000*(L+1)/1461001
    SET /A L= L-1461*I/4+31
    SET /A J= 80*L/2447
    SET /A K= L-2447*J/80
    SET /A L= J/11
    SET /A J= J+2-12*L
    SET /A I= 100*(N-49)+I+L

    SET YEAR=20%I%
    SET MONTH=0%J%
    SET DAY=0%K%

    ENDLOCAL&SET %~1=%Year:~-4%-%Month:~-2%-%Day:~-2%
GOTO :EOF *** :JulianDate2utc ***

::*** End of File *****************************************************