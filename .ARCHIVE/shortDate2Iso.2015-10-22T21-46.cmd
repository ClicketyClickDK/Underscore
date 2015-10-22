@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Converts shortDate to ISO [YYYY-MM-ddThh:mm]
SET $AUTHOR=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  
::@(#)      %$NAME% [var] [shortDate]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Convert any date output in ShortDate to ISO.
::@(#)  Like date from Date.EXE or environment variable {PCT}DATE{PCT} or DIR
::@(#)  The function uses Windows registry to determine the valid sShortDate format
::@(#)  Please use only the standard formats as predefined in 
::@(#)  Windows regional settings.
::@(#)  If you invent your own formats and manipulate registry directly
::@(#)  then you're on you own.
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      FOR {PCT}i IN {LPAR}%$SOURCE%{RPAR} DO %$SOURCE% {PCT}~ti
::@(#) 
::@(#) Will give you date and time of the function file in ISO format
::@(#) [YYYY-MM-ddThh:mm]
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
::@(#)  URL: https://technet.microsoft.com/en-us/library/cc978653
::@(#)  URL: http://stackoverflow.com/questions/203090/how-to-get-current-datetime-on-windows-command-line-in-a-suitable-format-for-us
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

::
:: https://technet.microsoft.com/en-us/library/cc978653
:: reg query "HKCU\Control Panel\International" /v sShortDate
::
:: HKEY_CURRENT_USER\Control Panel\International
::    sShortDate    REG_SZ    dd-MM-yyyy
:: Notation d,dd = day ddd,dddd weekday MM = month YY,YYYY = year
::    MM/dd/yyyy
::    M/d/yy
::    M/d/yyyy
::    MM/dd/yy
::    yy/MM/dd
::    yyyy-MM-dd
::    dd-MMM-yy
::
::ddd dd-MM-yyyy
::  the date independently of the region day/month order, 
::  you can use "WMIC os GET LocalDateTime" as a source, since it's in ISO order

:: https://technet.microsoft.com/en-us/library/cc978653

        SET _DEBUG_=IF DEFINED DEBUG IF NOT "0"=="%DEBUG%" 2^>^&1 ECHO:[%0]: 
        SET _date=%~2
        SET _TT=%~3
        SET _toks=1-3*
        set v_day=
        set v_month=
        set v_year=

        %_DEBUG_%_date[%_date%] _tt[%_TT%]
        
        :: Find sShortDate format
        FOR /F "skip=2 tokens=2*" %%a IN ('reg query "HKCU\Control Panel\International" /v sShortDate') DO CALL SET _sShortDate=%%b
        %_DEBUG_%sShortdate[%_sShortDate%]

        :: If sShortDate holds weekday assume weekday as prefix (Windows XP style: ddd dd-MM-yyyy)
        IF NOT "%_sShortDate%"=="%_sShortDate:ddd=;%" CALL SET _toks=2-4* &:: weekday prefix

        %_DEBUG_%toks[%_toks%]
        
        :: Value	Meaning
        ::     0	mm/dd/yy
        ::     1	dd/mm/yy
        ::     2	yy/mm/dd
        FOR /F "skip=2 tokens=3*" %%a IN ('reg query "HKCU\Control Panel\International" /v iDate') DO CALL SET _iDate=%%a
        %_DEBUG_%iDate=%_iDate%
        
        %_DEBUG_%[%_date%][%_toks%]
        FOR /F "TOKENS=%_toks% DELIMS=.-/ " %%a IN ("%_Date%") DO (
            IF "0"=="%_iDate%" ( SET _YY=%%c&SET _MM=%%a&SET _DD=%%b)
            IF "1"=="%_iDate%" ( SET _YY=%%c&SET _MM=%%b&SET _DD=%%a)
            IF "2"=="%_iDate%" ( SET _YY=%%a&SET _MM=%%b&SET _DD=%%c)
            SET _T=%%d
        )
        SET _ISO=%_yy%-%_mm%-%_dd%
        IF DEFINED _T (
            SET _ISO=%_ISO%T%_T%
        ) ELSE IF DEFINED _TT SET _ISO=%_ISO%T%_T%

        rem ECHO:%_ISO%
    ENDLOCAL&IF "%~1" NEQ "" (SET %~1=%_ISO%) ELSE (echo:%_ISO%)
GOTO :EOF

::*** End of File *****************************************************