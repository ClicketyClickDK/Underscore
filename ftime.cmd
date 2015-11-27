@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=returns the file time in julian days
SET $AUTHOR=http://www.dostips.com
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)      %$NAME% [VAR] [File name]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Returns the file date as a julian date in a variable
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  ftime _ftime ftime.cmd
::@(#)  set _ftime
::@(#)  _ftime=2457108
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
::@(#)  shortDate2Iso   Converts shortDate to ISO [YYYY-MM-ddThh:mm]
::@(#)  date2jdate      Converts ISO date to Julian date
::@(#)
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  
::@ (#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@(#)  URL: http://www.dostips.com/{QUEST}t=Function.ftime
::@(#) 
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
::SET $VERSION=2015-03-31&SET $REVISION=13:46:00&SET $COMMENT=Description update/ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

:ftime JD filename attr -- returns the file time in julian days
::                      -- JD    [out]    - valref file time in julian days
::                      -- attr  [in,opt] - time field to be used, creation/last-access/last-write, see 'dir /?', i.e. /tc, /ta, /tw, default is /tw
:$created 20060101 :$changed 20090322 :$categories DateAndTime
:$source http://www.dostips.com
::  SET $VERSION=2015-02-18&SET $REVISION=15:54:00&SET $COMMENT=ECHO^. to ECHO:

::SETLOCAL
set file=%~2
set attr=%~3

SET _DEBUG_=IF DEFINED DEBUG IF NOT "0"=="%DEBUG%" 2^>^&1 ECHO:[%0]: 

::if not defined attr (call jdate JD "- %~t2"
::) ELSE (for /f %%a in ('"dir %attr% /-c "%file%"^|findstr "^^[0-9]""') do call jdate JD "%%a")


::if not defined attr (call date2jdate JD "- %~t2"
::) ELSE (for /f %%a in ('dir %attr% /-c "%file%"^|findstr "^^[0-9]"') do call date2jdate JD "%%a")
::) ELSE (for /f %%a in ('dir %attr% /-c "%file%"^|findstr "^^[0-9]"') do call date2jdate JD "%%a")
::( ENDLOCAL & REM RETURN VALUES
::    IF "%~1" NEQ "" (SET %~1=%JD%) ELSE (echo:%JD%)
::)

SET _TIME=%~t2
IF NOT DEFINED attr (
    FOR /F %%a in ('DIR %attr% /-c "%file%"^|findstr "^^[0-9]"') DO SET _TIME=%%a
)

%_DEBUG_% CALL shortDate2Iso _time "%~t2"
CALL shortDate2Iso _TIME "%_TIME%"
SET _TIME=%_time:~0,10%
%_DEBUG_% _time[%_time%]

%_DEBUG_%CALL date2jdate _JD "%_time%"
CALL date2jdate _JD "%_time%"

%_DEBUG_%SET %~1=%_JD%
ENDLOCAL & IF "%~1" NEQ "" (SET %~1=%_JD%) ELSE (echo:%_JD%)

EXIT /b
