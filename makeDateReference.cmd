@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Produces a series of dates for testing
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
::@(#)  %$Name% [Arguments]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)  -startyear:YYYY     First year in list (Default: 1970)
::@(#)  -endyear:YYYY       Last year in list (Default: 2030)
::@(#)  -r1c1               R1C1 reference format
::@(#)  -language           Laguage for formulas: EN, DA (DA = default)
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Produces a list of dates to load into a spreadsheet for processing
::@(#)  Data can be used as a reference for date conversion
::@(#)  
::@(#)  Note: List includes non valid dates, since any date number 1-31 
::@(#)  for any given month is included
::@(#)  
::@(#)  Output has these colums:
::@(#)      #ISO        YYYY-MM-DD
::@(#)      YYYY        Year
::@(#)  	MM          Month
::@(#)  	DD          Day
::@(#)  	JD          Julian date (number)
::@(#)  	DOY         Day of year (1-366)
::@(#)  	DOW         Day of week (0-6)
::@(#)      Weeknum     Week number (1-53). Depend on local rules
::@(#)      1900-01-01  Days since 1900-01-01
::@(#)      Valid       Is this date actually a valid date (February 30 is NOT)
::@(#)      LeapYear    Is year a leap year
::@(#)      LeapDay     Is day a leap day (YYYY-02-29 in a leap year)
::@(#)
::@(#)  Example:
::@(#)  In this example Feb 29-31st 1979 are invalid dates and 1979 is not a leap 
::@(#)  year.
::@(#)   #ISO       YYYY MM DD Julian  DOY DOW Week 1990  Valid   LeapY    LeapD
::@(#)   28-02-1979 1979 2  28 2443932 59  2   9    28914 ok      -        -
::@(#)   1979-02-29 1979 2  29 2443933 60  3   9    28915 Invalid -        -
::@(#)   1979-02-30 1979 2  30 2443934 61  4   9    28916 Invalid -        -
::@(#)   1979-02-31 1979 2  31 2443935 62  5   9    28917 Invalid -        -
::@(#)   01-03-1979 1979 3   1 2443933 60  3   9    28915 ok      -        -
::@(#)      
::@(#)  1980 is a leap year, Feb 29th 1980 is a leap day and Feb 30-31st are invalid 
::@(#)  dates
::@(#)   #ISO       YYYY MM DD Julian  DOY DOW Week 1990  Valid   LeapY    LeapD
::@(#)   28-02-1980 1980 2  28 2444297 59  3   9    29279 ok      LeapYear -
::@(#)   29-02-1980 1980 2  29 2444298 60  4   9    29280 ok      LeapYear Leap Day
::@(#)   1980-02-30 1980 2  30 2444299 61  5   9    29281 Invalid LeapYear -
::@(#)   1980-02-31 1980 2  31 2444300 62  6   10   29282 Invalid LeapYear -
::@(#)   01-03-1980 1980 3   1 2444299 61  5   9    29281 ok      LeapYear -
::@(#)
::@(#)  Please note: On non-valid dates the calculated values of Julian Date, 
::@(#)  Day of Year, Week num etc must be ignored!
::@(#)
::@(#)
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  :: The full monty: All dates in entire interval
::@(#)  CALL %$NAME 
::@(#) 
::@(#)  :: Interval 1980-01-01 - 1982-12-31
::@(#)  CALL %$NAME -startYear:1980 -endYear:1982
::@(#) 
::@(#)  :: Interval 1980-01-01 - 1982-12-31 - for english version of Excel
::@(#)  CALL %$NAME -startYear:1980 -endYear:1982 -language:en
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
::@ (#) %TEMP%\%$NAME%.csv  Data to read into spreadsheet
::@ (#)
::@ (#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@ (#) Data incluces formulas in Excel format. 
::@ (#) These need to be post processed by a spreadsheet
::@ (#)
::@ (#) Excel 2010 has changed cell reference format from A1 to R1C1.
::@ (#) This format can be switched on/off before loading the data:
::@ (#) Go to File / Options / Formula / Working with Formulas, Check/uncheck "R1C1 reference style"
::@ (#)
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  _GetOpt.cmd     Parse command line options and create environment vars
::@(#)
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  Utc2JulianDate.cmd
::@ (#)  JulianDate2Utc.cmd 
::@ (#)  
::@ (#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author: KB214019
::@ (#)  Title: Method to determine whether a year is a leap year
::@ (#)  URL: https://support.microsoft.com/en-us/kb/214019
::@ (#) 
::@(#)SOURCE
::@(-)  Where to find this source
::@(#)  %$Source%
::@(#)
::@ (#)AUTHOR
::@(-)  Who did what
::@ (#)  %$AUTHOR%
::*** HISTORY **********************************************************
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init Description [xx.xxx]
::SET $VERSION=2010-10-20&SET $REVISION=00:00:00&SET $COMMENT=Initial [01.000]
::SET $VERSION=2010-11-12&SET $REVISION=16:23:00&SET $COMMENT=Adding exact path to _prescript/ErikBachmann [01.010]
::SET $VERSION=2015-02-19&SET $REVISION=03:15:13&SET $COMMENT=Autoupdate / ErikBachmann
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
  SET $VERSION=2015-11-12&SET $REVISION=10:12:00&SET $COMMENT=Adding formulas for valid date, leap year / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

    ECHO:%$NAME% -- %$DESCRIPTION%
    ECHO:v. %$VERSION% r. %$REVISION%
    ECHO:

    ::SET _TAB=";"
    :: Column separator
    SET _SEP=;
    :: Default start year
    SET _StartYear=1970
    :: Default end year
    SET _EndYear=2030
    
    :: Prefered language (See language dependencies in :Excel_translations)
    SET _Lang=EN
    SET _Lang=DA
    CALL :Excel_translations
    
    :: Use command line arguments
    IF DEFINED @%$NAME%.startYear SET _StartYear=!@%$NAME%.startYear!
    IF DEFINED @%$NAME%.startYear SET _EndYear=!@%$NAME%.endYear!
    IF DEFINED @%$NAME%.language SET _lang=!@%$NAME%.language!
    
    SET _TitleStub=%$NAME% [%_StartYear%-%_EndYear%]
    ECHO:Range: [%_StartYear%-%_EndYear%]
    SET _DataOut=%TEMP%\%~n0.csv
    TITLE %_TitleStub%

    SET _StartOfset=3

    IF EXIST "%_DataOut%" DEL "%_DataOut%"

    :: Write header
    (
        ECHO:"#ISOdate"%_SEP%"YYYY"%_SEP%"MM"%_SEP%"DD"%_SEP%"JD"%_SEP%"DOY"%_SEP%"DOW"%_SEP%"Weeknum"%_SEP%"1900-01-01"%_SEP%Valid%_SEP%LeapY%_SEP%LeapD
        ECHO:"#=!Excel.%_LANG%.date!(1970;01;01)"%_SEP%"#1970"%_SEP%"#01"%_SEP%"#01"%_SEP%"#=!Excel.%_LANG%.date!(B3;C3;D3)+2415018"%_SEP%"#=!Excel.%_LANG%.date!(B3;C3;D3)-!Excel.%_LANG%.date!(B3;1;1)+1"%_SEP%"#=!Excel.%_LANG%.weekday!(!Excel.%_LANG%.date!(B3;C3;D3))"%_SEP%"#=!Excel.%_LANG%.weeknum!(!Excel.%_LANG%.date!(B3;C3;D3))"%_SEP%"#=!Excel.%_LANG%.trunc!((!Excel.%_LANG%.date!(B3;C3;D3)-!Excel.%_LANG%.date!(!Excel.%_LANG%.year!(!Excel.%_LANG%.date!(B3;C3;D3)+3-!Excel.%_LANG%.mod!(!Excel.%_LANG%.date!(B3;C3;D3)-2;7));1;!Excel.%_LANG%.mod!(!Excel.%_LANG%.date!(B3;C3;D3)-2;7)-9))/7)"
    )>"%_DataOut%"

    FOR /L %%Y in (%_StartYear%, 1, %_EndYear%) DO (
        ECHO:
        SET /P _=%%Y <nul 
        FOR /L %%M IN (01, 1, 12) DO (   
            REM Jan, Mar, May Jul
            SET /P _=%%M <nul
            FOR /L %%D IN (01, 1, 31) DO (
                REM Day of month
                CALL :SetDate %%Y %%M %%D
            )
        )
    )
GOTO :EOF

::---------------------------------------------------------------------

:SetDate
    ::ECHO :setdate %1 %2 %3

    SET _Y=%~1
    SET _M=0%~2
    SET _M=!_M:~-2!
    SET _D=0%~3
    SET _D=!_D:~-2!
    TITLE %_TitleStub%: %_Y%-%_M%-%_D%
    
    :: Old format B1;C1;D1
    SET Date_excel=B%_StartOfset%;C%_StartOfset%;D%_StartOfset%
    SET StartOfMonth_Excel=B%_StartOfset%;1;1
    SET Month_Excel=C%_StartOfset%
    SET Day_Excel=D%_StartOfset%

    IF DEFINED @%$NAME%.r1c1 (
        :: New format: R1C1;R1C2;R1C3
        SET Date_excel=R%_StartOfset%C2;R%_StartOfset%C3;R%_StartOfset%C4
        SET StartOfMonth_Excel=R%_StartOfset%C2;1;1
    )

    ::SET _Ref="%_Y%-%_M%-%_D%"%_SEP%"%_Y%"%_SEP%"%_M%"%_SEP%"%_D%"
    REM         ISO
    SET _Ref="%_Y%-%_M%-%_D%"
    REM Year
    SET _Ref=!_REF!%_SEP%"%_Y%"
    REM Month
    SET _Ref=!_REF!%_SEP%"%_M%"
    REM Day
    SET _Ref=!_REF!%_SEP%"%_D%"
    
    REM         Julian date http://www.vertex42.com/ExcelTemplates/julian-date-calendar.html
    SET _Ref=!_REF!%_SEP%"=!Excel.%_LANG%.date!^(%Date_excel%^)+2415018"

    REM         DayOfYear   http://www.excel-easy.com/examples/day-of-the-year.html
    SET _Ref=!_REF!%_SEP%"=!Excel.%_LANG%.date!^(%Date_excel%^)-!Excel.%_LANG%.date!^(%StartOfMonth_Excel%^)+1"

    REM         DayOfWeek
    SET _Ref=!_REF!%_SEP%"=!Excel.%_LANG%.weekday!^(!Excel.%_LANG%.date!^(%Date_excel%^);3^)"

    REM         Week no
    SET _Ref=!_REF!%_SEP%"=!Excel.%_LANG%.weeknum!^(!Excel.%_LANG%.date!^(%Date_excel%^)^)" 

   
    REM Days since 1900-01-01
    SET _REF=!_REF!%_SEP%"=!Excel.%_LANG%.date!(%_Y%;%_M%;%_D%)"

    REM Is date valid?
    SET _REF=!_REF!%_SEP%"=!Excel.%_LANG%.if!(!Excel.%_LANG%.not!(!Excel.%_LANG%.iserror!(!Excel.%_LANG%.datevalue!(!Excel.%_LANG%.text!(A%_StartOfset%;""!Excel.%_LANG%.yyyy!-mm-dd""))))!Excel.%_LANG%._sep!""ok""!Excel.%_LANG%._sep!""Invalid date"")"
    
    REM Is leap year
    REM https://support.microsoft.com/en-us/kb/214019
    REM =IF(OR(MOD(A1,400)=0,AND(MOD(A1,4)=0,MOD(A1,100)<>0)),"Leap Year", "NOT a Leap Year")
    SET _REF=!_REF!%_SEP%"=!Excel.%_LANG%.if!(!Excel.%_LANG%.or!(!Excel.%_LANG%.mod!(B%_StartOfset%!Excel.%_LANG%._sep!400)=0!Excel.%_LANG%._sep!!Excel.%_LANG%.and!(!Excel.%_LANG%.mod!(B%_StartOfset%!Excel.%_LANG%._sep!4)=0!Excel.%_LANG%._sep!!Excel.%_LANG%.mod!(B%_StartOfset%!Excel.%_LANG%._sep!100)<>0))!Excel.%_LANG%._sep!""Leap Year""!Excel.%_LANG%._sep! ""-"")"

    REM Is leap day
    REM =IF(AND(OR(MOD(B1;400)=0;AND(MOD(B1;4)=0;MOD(B1;100)<>0));C1=2;D1=29);"LeapDay";"-LeapDay")
    SET _REF=!_REF!%_SEP%"=!Excel.%_LANG%.if!(!Excel.%_LANG%.AND!(!Excel.%_LANG%.OR!(!Excel.%_LANG%.MOD!(B%_StartOfset%!Excel.%_LANG%._sep!400)=0!Excel.%_LANG%._sep!!Excel.%_LANG%.AND!(!Excel.%_LANG%.MOD!(B%_StartOfset%!Excel.%_LANG%._sep!4)=0!Excel.%_LANG%._sep!!Excel.%_LANG%.MOD!(B%_StartOfset%!Excel.%_LANG%._sep!100)<>0))!Excel.%_LANG%._sep!C%_StartOfset%=2!Excel.%_LANG%._sep!D%_StartOfset%=29)!Excel.%_LANG%._sep!""Leap Day""!Excel.%_LANG%._sep!""-"")"
    
    ECHO:!_REF!>>"%_DataOut%"
    SET /A _StartOfset+=1
GOTO :EOF   *** :SetDate ***


::---------------------------------------------------------------------

:Excel_translations
::ECHO Excel.%_LANG%.iserror=!Excel.%_LANG%.iserror!=ISERROR
:: Setting up a primitive localization
:: Translation of function names in Excel and separators in functions
:: 
:: Day of year variation:
:: English: =DATE(YEAR(A1),1,1)
:: Danish:  =DATO(ÅR(A1);1;1)
:: Before expansion
::           /-Date-------------\  /-B?C?D?---\   /-DATE-------------\  /-YYYY;1;1---------\
::          =!Excel.%_LANG%.date!^(%Date_excel%^)-!Excel.%_LANG%.date!^(%StartOfMonth_Excel%^)+1"

    :: Danish
    SET Excel.DA.date=DATO
    SET Excel.DA.weekday=UGEdag
    SET Excel.DA.weeknum=UGE.NR
    SET Excel.DA.trunc=AFKORT
    SET Excel.DA.mod=REST
    SET Excel.DA.year=ÅR
    SET Excel.DA.if=HVIS
    SET Excel.DA.and=OG
    SET Excel.DA.or=ELLER
    SET Excel.DA.not=IKKE
    SET Excel.DA.iserror=ER.FEJL
    SET Excel.DA.datevalue=DATOVÆRDI
    SET Excel.DA.text=TEKST
    SET Excel.DA.yyyy=åååå
    SET Excel.DA._sep=;

    :: English
    SET Excel.EN.date=DATE
    SET Excel.EN.weekday=WEEKDAY
    SET Excel.EN.weeknum=WEEKNUM
    SET Excel.EN.trunc=TRUNC
    SET Excel.EN.mod=MOD
    SET Excel.EN.year=YEAR
    SET Excel.EN.if=IF
    SET Excel.EN.and=AND
    SET Excel.EN.or=OR
    SET Excel.EN.not=NOT
    SET Excel.EN.iserror=ISERROR
    SET Excel.EN.datevalue=DATEVALUE
    SET Excel.EN.text=TEKST
    SET Excel.EN.yyyy=yyyy
    SET Excel.EN._sep=,
GOTO :EOF   *** :Excel_translations ***

::*** End of File *****************************************************