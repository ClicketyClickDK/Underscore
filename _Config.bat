::@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Global configuration file
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
::@(#)      CALL %$NAME%
::@(#)   
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Setting up global vars needed by most scripts like logging, trace etc. 
::@(#) 
::@ (#)EXAMPLES
::@(-)  Some examples of common usage.
::@ (#) 
::@ (#) 
::@ (#) 
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)
::@(#)ENVIRONMENT
::@(-)  Variables affected
::@(#)  _LogFile    Location of log file
::@(#)  _TraceFile  Location of trace file
::@(#)  _LOG_       Log command
::@(#)  _TRACE_     Trace command
::@(#)  _FINAL_     Footer
::@(#)
::@ (#)FILES, 
::@(-)  Files used, required, affected
::@ (#)
::@ (#)
::@ (#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@ (#)
::@ (#)
::@ (#)REQUIRES
::@(-)  Dependecies
::@ (#)  
::@ (#)
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  
::@ (#)  
::@ (#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@ (#)  URL: http://en.wikipedia.org/wiki/Man_page
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
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm&SET $COMMENT=Description/init
::SET $VERSION=2015-02-19&SET $REVISION=00:00:00&SET $COMMENT=Initial/ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=16:00:00&SET $COMMENT=GetOpt: Calling usage and exit on error / ErikBachmann
::**********************************************************************
::@(#)(C)%$Version:~0,4% %$Author%
::**********************************************************************
ENDLOCAL

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

    CALL "%~dp0_utc" > nul

    SET _LOGFILE=%TMP%\%$NAME%.%DTS%.log
    SET _TraceFile=%TMP%\%$NAME%.trc.%DTS%.txt

    SET _LOG_=^>^>"%_logFile%" 2^>^&1 ECHO:
    SET _TRACE_=^>^>"%_TraceFile%" 2^>^&1 ECHO:
    SET _SysadmMail=BIB-IT@roskilde.dk

    ::SET _Servers=Helge Frode, Calm, Arena, Adlib
    ::SET _Servers=HELGE FRODE, CALM, ARENA

    ::SET _SourceDir=%~dp0\bib-it\scripts.archive\

    :: Header
    FOR %%A IN ( ^&2 "%_LogFile%" "%_TraceFile%" ) DO (
        ECHO:%$NAME% - %$DESCRIPTION% 
        ECHO:%Date% %Time% start
        ECHO:
    )>%%A

    :: Footer
    SET _FINAL_=FOR %%a IN ( CON: "%_LogFile%" "%_TraceFile%" ) DO ^
        ( ECHO:^&ECHO:%$NAME% %Date% %Time% Done )^>^>%%a

::*** End of File ******************************************************