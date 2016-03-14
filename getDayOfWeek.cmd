@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Get day of week for a given date
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
::@(#)      %$NAME% [VAR] [YYYY-MM-DD]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Get day number in week: Man - Sun 0 - 6 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#) 
::@(#)      getDayOfWeek _dow 2015-03-31
::@(#)      set _dow
::@(#)      _dow=1
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
::@ (#)  Author:
::@(#)  URL: http://stackoverflow.com/questions/11364147/setting-a-windows-batch-file-variable-to-the-day-of-the-week
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
::SET $VERSION=2015-03-30&SET $REVISION=10:09:00&SET $COMMENT=Examples / ErikBachmann
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
  SET $VERSION=2016-03-14&SET $REVISION=10:00:00&SET $COMMENT=Set "%~dp0\ prefix on function calls / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

    SET UTC=%~2
    IF NOT DEFINED UTC CALL "%~dp0\_utc"

::http://stackoverflow.com/questions/11364147/setting-a-windows-batch-file-variable-to-the-day-of-the-week
:: Man - Sun 0 - 6
:DOW UTC
    IF DEFINED DEBUG IF NOT "0"=="%DEBUG%" ECHO %UTC%
    SET Year=%UTC:~0,4%
    SET Month=%UTC:~5,2%
    SET DAY=%UTC:~8,2%

    REM GET DAY OF WEEK VIA DATE TO JULIAN DAY NUMBER CONVERSION
    REM ANTONIO PEREZ AYALA
    REM GET MONTH, DAY, YEAR VALUES AND ELIMINATE LEFT ZEROS
    ::FOR /F "TOKENS=1-3 DELIMS=/" %%A IN ("%DATE%") DO SET /A MM=10%%A %% 100, DD=10%%B %% 100, YY=%%C
    
    SET /A MM=10%MONTH% %% 100, DD=10%DAY% %% 100, YY=%YEAR%
    IF DEFINED DEBUG (
        IF NOT "0"=="%DEBUG%" (
            SET MM
            SET DD
            SET YY
        )
    )
    REM CALCULATE JULIAN DAY NUMBER, THEN DAY OF WEEK
    IF %MM% LSS 3 SET /A MM+=12, YY-=1
    SET /A A=YY/100, B=A/4, C=2-A+B, E=36525*(YY+4716)/100, F=306*(MM+1)/10, JDN=C+DD+E+F-1524
    SET /A DOW=(JDN+1)%%7
        SET /A DOW-=1
    IF "-1"=="%DOW%" SET DOW=6
    SET DayOfWeek=%DOW%
    IF DEFINED DEBUG IF NOT "0"=="%DEBUG%" SET DayOfWeek
    ENDLOCAL&SET %~1=%DOW%
GOTO :EOF


:: Get day of week (Sunday=0, Saturday=6)
::FOR /f %%a in ('WMIC path win32_localtime get DayOfWeek /format:list ^| FIND "="') DO CALL SET %%a
::SET DayOfWeek

::*** End of File *****************************************************