@ECHO OFF
SETLOCAL ENABLEEXTENSIONS EnableDelayedExpansion&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Convert UTC date [YYYY-MM-MM] to Julian date [Numeric]
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
::@(#)  %$Name% {function} {PIPE} ALL
::@(#)
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Converting af human readable UTC date YYYY-MM-DD to a 
::@(#)  numeric Julian date
::@(#)
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  CALL utc2JulianDate #JD "2010-01-20"
::@(#)  SET #JD
::@(#)  #JD=2455217
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
::@(#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#)  JulianDate2Utc
::@(#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@(#)  URL: http://aa.usno.navy.mil/faq/docs/JD_Formula.php
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
::SET $VERSION=2015-02-19&SET $REVISION=03:15:48&SET $COMMENT=Autoupdate / EBP
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1


:utc2JulianDate varJulian stringUTC
    SET UTC=%~2
    SET I=%UTC:~0,4%
    SET J=%UTC:~5,2%
    SET K=%UTC:~8,2%

    SET /A JD= K-32075+1461*(I+4800+(J-14)/12)/4+367*(J-2-(J-14)/12*12)/12-3*((I+4900+(J-14)/12)/100)/4

    ENDLOCAL&SET %~1=%JD%
GOTO :EOF *** :utc2JulianDate ***

::*** End of File *****************************************************