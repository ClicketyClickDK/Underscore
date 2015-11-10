@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Get week number for at given date
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
::@(#)      %$NAME% [VAR] [ISO DATE]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Please be ware, that week numbers are calculated based on 
::@(#)  national standards.
::@(#)  This script is localized to danish standard: 
::@(#)  First week of a year must have 4 or more days 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      getweekofyear _woy 2015-03-30
::@(#)      set _woy
::@(#)      _woy=14
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
::@(#)  URL: http://www.robvanderwoude.com/files/datepart_xp.txt
::@(#)  Author: Rob Van Der Woude
::@(#)  URL: http://stackoverflow.com/questions/11364147/setting-a-windows-batch-file-variable-to-the-day-of-the-week 
::@(#)  Author: ANTONIO PEREZ AYALA
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
:: URL=

    SET _UTC=%~2
    SET _ThursdayNo=4
    SET _ThursdayNo=3
    SET _WeekLength=7
    SET _DEBUG_=IF DEFINED DEBUG IF NOT "0"=="%DEBUG%" 2^>^&1 ECHO:[%0]: 

    IF NOT DEFINED _UTC CALL _utc>nul

    CALL GetDayOfYear _DayOfYear %_UTC%
    %_DEBUG_%_DayOfYear=%_DayOfYear%
    %_DEBUG_% --
    ::CALL :DOW %UTC%
    CALL getDayOfWeek _DayOfWeek %_UTC%
    %_DEBUG_%SET _DayOfYear=%_DayOfYear%
    %_DEBUG_%SET _DayofWeek=%_DayofWeek%
    CALL :WeekOfYear

    ::SET _
    ENDLOCAL&SET %~1=%_WeekOfYear%
GOTO :EOF


:_WeekOfYear
    SET /A _ThisWeeksSunday = %_DayOfYear% - %_DayOfWeek% + 7
    SET /A _WeekOfYear = %_ThisWeeksSunday% / 7
    SET /A _FirstThursday = %_ThisWeeksSunday% - 7 * %_WeekOfYear% + 4
    :: dag=31       + 3 - (ugedag=3      + 6) % 7 = 32
    ECHO FirstThursday %_FirstThursday%
    IF %_FirstThursday% GTR 7 SET /A _WeekOfYear += 1
GOTO:EOF

:: ISO week number
:: ISO-8601
:WeekOfYear UTC
    SET /A _ThisWeeksSunday = %_DayOfYear% - %_DayOfWeek% + %_WeekLength%
    %_DEBUG_% SET _ThisWeeksSunday=%_ThisWeeksSunday%
    SET /A _WeekOfYear = %_ThisWeeksSunday% / %_WeekLength%
    SET /A _FirstThursday = %_ThisWeeksSunday% - %_WeekLength% * %_WeekOfYear% + %_ThursdayNo%
    :: dag=31       + 3 - (ugedag=3      + 6) % 7 = 32
    IF %_FirstThursday% GTR %_WeekLength% SET /A _WeekOfYear += 1
    REM SET WeekOfYear
GOTO:EOF




::http://stackoverflow.com/questions/11364147/setting-a-windows-batch-file-variable-to-the-day-of-the-week
:_DOW UTC
    SET Year=%UTC:~0,4%
    SET /a Month+=10%UTC:~5,2% %% 100
    SET /a DAY+=10%UTC:~8,2% %% 100

    REM GET DAY OF WEEK VIA DATE TO JULIAN DAY NUMBER CONVERSION
    REM ANTONIO PEREZ AYALA
    REM GET MONTH, DAY, YEAR VALUES AND ELIMINATE LEFT ZEROS
    ::FOR /F "TOKENS=1-3 DELIMS=/" %%A IN ("%DATE%") DO SET /A MM=10%%A %% 100, DD=10%%B %% 100, YY=%%C
    
    SET /A MM=10%MONTH% %% 100, DD=10%DAY% %% 100, YY=%YEAR%
    ::SET MM
    ::SET DD
    ::SET YY
    REM CALCULATE JULIAN DAY NUMBER, THEN DAY OF WEEK
    IF %MM% LSS 3 SET /A MM+=12, YY-=1
    SET /A A=YY/100, B=A/4, C=2-A+B, E=36525*(YY+4716)/100, F=306*(MM+1)/10, JDN=C+DD+E+F-1524
    SET /A DOW=(JDN+1)%%7
    SET DayOfWeek=DOW
GOTO :EOF

:: Danish week numbers! 
:: Ugenumre
:: 
:: http://da.wikipedia.org/wiki/Gregorianske_kalender#Ugenumre
:: Det er torsdagen, der bestemmer, hvilket år en uge tilhører. 
:: Derfor er ugen fra mandag den 28. december 2009 til søndag den 3. januar 2010 
:: uge 2009-53, da torsdagen (den 31. december) er i 2009.
:: 
:: 
:: http://ing.dk/indhold/140122
:: Uge 1 er defineret som den første uge i det nye år som inderholder 4 
:: eller flere dage! Altså skal den 1. januar være en mandag, tirsdag, 
:: onsdag eller en torsdag for at være indeholdt i uge 1. Er 1. januar 
:: derimod en fredag, lørdag eller søndag er det uge 52/53 i det "gamle" 
:: år! 
:: 
:: 
:: 
::*** End of File *****************************************************