@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Setting up debug environment for batch scripts
SET $Author=Erik Bachmann, ClicketyClick.dk (ErikBachmann@ClicketyClick.dk)
SET $Source=%~dpnx0
::@(#) 
::@(#)NAME
::@(#)  %$Name% -- %$Description%
::@(#) 
::@(#)SYNOPSIS
::@(#)  %$Name% {options}
::@(#) 
::@(#)DESCRIPTION
::@(#)  This function sets up two environment variables
::@(#)  _Debug_ and _verbose_ as add ons to ECHO
::@(#)  _LOG_ and _TRACE_ prints to log and trace file
::@(#)
::@(#)  _Verbose_ is simply a replacement for ECHO which can be switch off (Silent mode)
::@(#)  _Verbose_ prints to STDOUT.
::@(#)  Use this feature instead of ECHO for printing standard info to user.
::@(#)
::@(#)  _Debug_ is a replacement for ECHO to print debug information to STDERR. 
::@(#)  By default this is switch off (Redirect to NUL)
::@(#)
::@(#)  _LOG_ is for general statements
::@(#)  _TRACE_ is only for debuging
::@(#)
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)  
::@(#)FLAGS
::@(#)  SET DEBUG=x
::@(#)  0	No debugging (default)
::@(#)  1	Debugging active
::@(#)  2	Debugging active and ECHO on
::@(#)
::@(#)  Environment variable _DEBUG_ will either print to NUL
::@(#)  OR if active print to STDERR
::@(#)
::@(#)  SET VERBOSE=x
::@(#)  0	Silent
::@(#)  1	Normal verbose (Default)
::@(#)
::@(#)  Environment variable _VERBOSE_ will either print to NUL
::@(#)  OR if active print to STDERR
::@(#)
::@(#)EXAMPLE
::@(#)  ECHO Default: Verbose on, Debug off
::@(#)  CALL _debug.cmd
::@(#)  %%_Verbose_%% verbosing on
::@(#)  %%_Debug_%% Debugging off
::@(#)  
::@(#)  ECHO Alternative: Verbose off, Debug on
::@(#)  SET DEBUG=1
::@(#)  SET VERBOSE=0
::@(#)  CALL _debug.cmd
::@(#)  %%_Verbose_%% verbosing off
::@(#)  %%_Debug_%% Debugging on
::@(#)  
::@(#)  ECHO Debug mode: Verbose on, Debug on level 2
::@(#)  SET DEBUG=2
::@(#)  SET VERBOSE=1
::@(#)  CALL _debug.cmd
::@(#)  %%_Verbose_%% verbosing on
::@(#)  %%_Debug_%% Debugging on (with Echo)
::@(#) 
::@(#)SOURCE
::@(#)  %$Source%
::@(#) 
::**********************************************************************
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm:ss&SET $COMMENT=Init Description
::SET $VERSION=01.000&SET $REVISION=2009-04-17T11:01:00&SET $COMMENT=Initial
::SET $VERSION=01.020&SET $REVISION=2009-10-11T20:21:00&SET $COMMENT=New header/EBP
::SET $VERSION=01.020&SET $REVISION=2010-10-20T17:00:00&SET $COMMENT=Level 3: ECHO + pause
::SET $VERSION=01.021&SET $REVISION=2010-10-20T17:15:00&SET $Comment=Addding $Source/EBP
::SET $VERSION=01.023&SET $REVISION=2010-12-02T16:43:00&SET $Comment=Addding _LOG_ and _Trace_/EBP
::SET $VERSION=01.024&SET $REVISION=2011-01-27T14:00:00&SET $Comment=Default $LogFile and $TraceFile/EBP
::SET $VERSION=01.026&SET $REVISION=2011-06-06T15:03:00&SET $Comment=Stub to errorhandler/EBP
  SET $VERSION=2015-10-08&SET $REVISION=16:00:00&SET $COMMENT=GetOpt: Calling usage and exit on error / ErikBachmann
::**********************************************************************
::@(#)(C)%$Version:~0,4% %$Author%
::**********************************************************************
ENDLOCAL

::Default
IF NOT DEFINED $LogFile SET $LogFile=%~n0.log.txt
IF NOT DEFINED $TraceFile SET $TraceFile=%~n0.trc.txt

SET _DEBUG_=1^>NUL 2^>^&1 ECHO
SET _Log_=1^>%$LogFile% 2^>^&1 ECHO
SET _TRACE_=1^>NUL 2^>^&1 ECHO
SET _VERBOSE_=1^>^&2 ECHO
::Stub to errorhandler
SET _Error_=CALL %~dp0_ErrorHandler %$Source%

IF /I "-h!"=="%~1!" CALL "%~dp0\what" %~f0

::----------------------------------------------------------------------

:: Debug mode
IF DEFINED DEBUG (
    IF /I "%DEBUG%" GTR "2" >&2 echo - _DEBUG_ defined
    IF "0" == "%DEBUG%" (
        IF /I "%DEBUG%" GTR "2" >&2 ECHO -- _DEBUG_ defined but not active!
    ) ELSE (
        SET _DEBUG_=^>^>^&2 ECHO
        SET _TRACE_=1^>^>%$TraceFile% 2^>^&1 ECHO

        IF /I "%DEBUG%" GTR "2" >&2 ECHO -- _DEBUG_ active
        IF "2" == "%DEBUG%" (
            ECHO ON
        )
        IF "3" == "%DEBUG%" (
            ECHO ON
            SET _DEBUG_=CALL _DEBUG3 
        )
        IF "3" == "%DEBUG%" (
            ECHO ON
            SET _DEBUG_=CALL _DEBUG4 
        )
        
    )
) ELSE (
    SET DEBUG=0
)
%_DEBUG_%:

::----------------------------------------------------------------------

::Verbose mode
IF DEFINED VERBOSE (
    IF /I "%DEBUG%" GTR "2" %_DEBUG_% - VERBOSE defined [%VERBOSE%]

    IF "0" == "%VERBOSE%" (
        SET _VERBOSE_=2^>NUL 1^>^&2 ECHO
        %_DEBUG_% -- Verbosing NOT active!
    ) else %_DEBUG_% -- Verbosing active!
) ELSE %_DEBUG_% - Verbosing active! / Verbose not defined
%_DEBUG_%:

::----------------------------------------------------------------------

::Trace mode
IF DEFINED TRACE SET _TRACE_=1^>^>%$TraceFile% 2^>^&1 ECHO

::*** End of File ******************************************************
