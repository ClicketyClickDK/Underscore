@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Converts ISO date to Julian date
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
::@(#)      %$NAME% [VAR] [IsoDate]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Converts a ISO date [YYYY-MM-DD] to a Julian date number
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      CALL %$NAME% _var 2015-03-27
::@(#)  Should give _var=2457108
::@(#)
::@(#)  CALL shortDate2Iso _sdate "27/03/2015"
::@(#)  CALL %$NAME% _var {PCT}_sdate{PCT}
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
::@(#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  date2jdate.cmd      Converts ISO date to Julian date
::@(#)  jdate2date.cmd      converts julian days to gregorian date format
::@(#)  shortDate2Iso.cmd   Converts shortDate to ISO [YYYY-MM-ddThh:mm]
::@(#)  date.reference.csv  Reference file for date convertions
::@(#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@(#)  URL: http://en.wikipedia.org/wiki/Julian_day
::@(#)  URL: http://en.wikipedia.org/wiki/ISO_8601 
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
::SET $VERSION=2015-02-19&SET $REVISION=00:00:00&SET $COMMENT=Initial/ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

:gregorianDate2JulianDate VAR "ISOdate"
    ::SETLOCAL
        ::http://scienceworld.wolfram.com/astronomy/JulianDate.html
        ::For Gregorian calendar dates 1901-2099, the formula can be simplified!!
        :: Expecting date in ISO format: YYYY-MM-DD

        SET _DEBUG_=IF DEFINED DEBUG IF NOT "0"=="%DEBUG%" ECHO:[%0]: 
        SET _YYYY=%~2
        %_DEBUG_% YYYY=[%_YYYY%]

        :: Use modulus to avoid confusion with octal values
        SET /A _MM=1%_YYYY:~5,2% %% 100
        SET /A _DD=1%_YYYY:~8,2% %% 100
        SET _YYYY=%_YYYY:~0,4%
        SET _REF=%3
        %_DEBUG_% YYYY[%_YYYY%] MM[%_mm%] dd[%_dd%] ref[%_ref%]
        
        SET /A _JD=(367 * %_YYYY%) - (7 * (%_YYYY% + ((%_MM% + 9) / 12 )) /4 ) + (275 * %_mm% / 9) + %_dd% + 1721013,5 + (0 / 24)
        
        :: Add an extra day if .5+
::        IF DEFINED _REF (
            IF "!."=="!%_REF:~-2,1%" SET /A _REF+=1
            IF "%_JD%"=="%_ref%" (SET _result=0) else SET _result=1
  ::      )
    ENDLOCAL&SET %~1=%_jd%&EXIT /B %_result%
GOTO :EOF

::*** End of File *****************************************************