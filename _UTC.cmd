@ECHO OFF
SETLOCAL&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Set environment UTC as current date in UTC format AND UTC_FILE as valid filename
SET $Author=Erik Bachmann, ClicketyClick.dk (ErikBachmann@ClicketyClick.dk)
SET $Source=%~dpnx0
::----------------------------------------------------------------------
::@(#)NAME
::@(#)  %$Name% -- %$Description%
::@(#) 
::@(#)SYNOPSIS
::@(#)  %$Name% {date}
::@(#) 
::@(#)DESCRIPTION
::@(#)  What's the quest?!?
::@(#)  ISO 8601: 
::@(#)  Complete date plus hours, minutes and seconds:
::@(#)      YYYY-MM-DDThh:mm:ssTZD (eg 1997-07-16T19:20:30+01:00)
::@(#)  Complete date plus hours, minutes, seconds and a decimal fraction of a
::@(#)  of a second
::@(#)      YYYY-MM-DDThh:mm:ss.sTZD (eg 1997-07-16T19:20:30.45+01:00)
::@(#) 
::@(#)  where:
::@(#) 
::@(#)  YYYY = four-digit year
::@(#)  MM   = two-digit month (01=January, etc.)
::@(#)  DD   = two-digit day of month (01 through 31)
::@(#)  hh   = two digits of hour (00 through 23) (am/pm NOT allowed)
::@(#)  mm   = two digits of minute (00 through 59)
::@(#)  ss   = two digits of second (00 through 59)
::@(#)  s    = one or more digits representing a decimal fraction of a second
::@(#)  TZD  = time zone designator (Z or +hh:mm or -hh:mm)
::@(#) 
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  _GetOpt.cmd     Parse command line options and create environment vars
::@(#)
::@(#)SOURCE
::@(#)  %$Source%
::@(#) 
::----------------------------------------------------------------------
::History
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm:ss&SET $COMMENT=Init Description
::SET $VERSION=00.000&SET $REVISION=2008-09-09T11:59:19&SET $COMMENT=EBP/Initial
::SET $VERSION=01.015&SET $REVISION=2009-01-25T18:01:00&SET $COMMENT=EBP/ 
::SET $VERSION=01.016&SET $REVISION=2009-03-??T00:00:00&SET $COMMENT=EBP/Bug fix for M$ danish DATE bug: 'dd DD-MM-YYYY'
::SET $VERSION=01.017&SET $REVISION=2009-03-??T00:00:00&SET $COMMENT=EBP/Reformatted
::SET $VERSION=01.300&SET $REVISION=2009-09-19T05:42:00&SET $COMMENT=EBP/Flags in CFG.FLAGS
::SET $VERSION=01.301&SET $REVISION=2009-09-20T05:56:00&SET $COMMENT=EBP/Replacing blanks with 0
::SET $VERSION=01.302&SET $REVISION=2010-10-20T17:15:00&SET $Comment=Addding $Source/EBP
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
  SET $VERSION=2015-11-23&SET $REVISION=16:30:00&SET $COMMENT=GetOpt replaced _getopt.sub simple call. Reduces runtime to 1/3 / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    ::CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
    :: Check ONLY for combinations of -h, /h, --help
    CALL _getopt.sub %*&IF ERRORLEVEL 1 EXIT /B 1

    CALL "%~dp0\_DEBUG"


%_DEBUG_% %NAME% v.%Version% -- %Description%
%_DEBUG_% Rev. %Revision%

CALL :_utc.Init
ENDLOCAL
CALL _Debug

CALL :_utc.Main %*

GOTO :EOF

::----------------------------------------------------------------------

:usage
    CALL what %~dpnx0
    EXIT /B 1
GOTO :EOF

::----------------------------------------------------------------------

:_utc.init
    IF DEFINED CFG.FLAG.usage GOTO usage
    ::IF DEFINED CFG.FLAG.Test GOTO test
    ::IF /I "" equ "%~1"     GOTO usage
    ::IF /I "" equ "%~2" >&2 ECHO ERROR: [substring] missing && >&2 ECHO . && GOTO usage
GOTO :EOF

::----------------------------------------------------------------------

:_utc.Main
    IF " "=="%date:~2,1%" (
        :: Bug fix for M$ danish DATE bug: "dd DD-MM-YYYY"
        SET UTC=%DATE:~9,4%-%DATE:~6,2%-%DATE:~3,2%T%TIME%

    ) ELSE (
        SET UTC=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%T%TIME%
    )
    SET UTC=%UTC: =0%
    %_DEBUG_% %UTC%

    SET UTC_FILE=%UTC:~0,13%-%UTC:~14,2%-%UTC:~17%
    SET UTC_FILE=%UTC_FILE:,=-%
    %_DEBUG_% %UTC_FILE%
GOTO :EOF

::*** End of File *****************************************************
