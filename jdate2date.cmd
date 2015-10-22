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
::@(#)  Converts a Julian date number to an ISO date [YYYY-MM-DD]
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      CALL %$NAME% _var 2451544
::@(#)  Should give _var=2000-01-01
::@(#)
::@(#)  CALL shortDate2Iso _sdate "27/03/2015"
::@(#)  CALL %$NAME% _var %_sdate%
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
::@(#)  formatStr.cmd
::@(#) 
::@(#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#)  date2jdate.cmd      Converts ISO date to Julian date
::@ (#)  jdate2date.cmd      converts julian days to gregorian date format
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
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
  SET $VERSION=2015-10-22&SET $REVISION=06:00:00&SET $COMMENT=Update usage / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

IF /I "!-UnitTest"=="!%~1" GOTO :unittest.%~n0
IF "!"=="!%~2" FindStr "^:" %~f0 & GOTO :EOF

:jdate2date JD YYYY MM DD -- converts julian days to gregorian date format
::                     -- JD   [in]  - julian days
::                     -- YYYY [out] - gregorian year, i.e. 2006
::                     -- MM   [out] - gregorian month, i.e. 12 for december
::                     -- DD   [out] - gregorian day, i.e. 31
:$reference http://aa.usno.navy.mil/faq/docs/JD_Formula.html
:$created 20060101 :$changed 20080219 :$categories DateAndTime
:$source http://www.dostips.com
::SETLOCAL ENABLEDELAYEDEXPANSION
::2015-02-23/ErikBachmann: Correction + 2 http://scienceworld.wolfram.com/astronomy/JulianDate.html
::set /a L= %~1+68569+2,     N= 4*L/146097, L= L-(146097*N+3)/4, I= 4000*(L+1)/1461001
:: Truncate decimal
SET _jd=%~1
:: Correction acording to Scienceworld
::SET /A _jd+=2
SET /A _jd+=1

::set /a L= %~1+68569,     N= 4*L/146097, L= L-(146097*N+3)/4, I= 4000*(L+1)/1461001
set /a L= %_jd%+68569,     N= 4*L/146097, L= L-(146097*N+3)/4, I= 4000*(L+1)/1461001
set /a L= L-1461*I/4+31, J= 80*L/2447,  K= L-2447*J/80,      L= J/11
set /a J= J+2-12*L,      I= 100*(N-49)+I+L
set /a YYYY= I,  MM=100+J,  DD=100+K
set MM=%MM:~-2%
set DD=%DD:~-2%
( ENDLOCAL & REM RETURN VALUES
    IF "%~2" NEQ "" (SET %~2=%YYYY%) ELSE echo.%YYYY%
    IF "%~3" NEQ "" (SET %~3=%MM%) ELSE echo.%MM%
    IF "%~4" NEQ "" (SET %~4=%DD%) ELSE echo.%DD%
)
EXIT /b

::---------------------------------------------------------------------

:unittest.jdate2date
:$created 20080223 :$changed 20080223
:$source http://www.dostips.com
SETLOCAL ENABLEDELAYEDEXPANSION
SET _CSV=_j2d.csv
SET _D2J=_d2j.csv
SET _J2D=_j2d.csv
SET _Ref=jdate.ref.csv

IF EXIST "%_j2d%" DEL "%_j2d%"
SET _Error=0

for /F "DELIMS=; Tokens=1,2" %%A in ('TYPE "%_ref%"') DO (
    set "jd=%%~A"
    call jdate2date jd Y M D
    ECHO !jd!;!m!/!d!/!y!>>%_j2d%
::    call Format "[35] [35]." "'%%jd%%'"    "'%%Y%% %%M%% %%D%%'"
    IF NOT "%%B"=="!m!/!d!/!y!" (
        call FormatStr "[15] [15] [40]." "[%%~B]" "[%%s%%]" "Expected [%%B] but got [!m!/!d!/!y!]"
        CALL SET /A _Error+=1
    ) ELSE (
        call FormatStr "[15] [15] [40]." "[%%~B]" "[%%s%%]" "OK"
    )
)
REM IF EXIST "%_d2j%" FC "%_d2j%" "%_j2d%"
ECHO:&ECHO Errors [%_Error%] comparing to [%_ref%]
EXIT /b %_Error%

::*** End of File *****************************************************