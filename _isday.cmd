@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Checks if time is morning, day or evening
SET $AUTHOR=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $SOURCE=%~f0
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(#)  %$Name% [time] [End of morning] [start of evening]
::@(#) 
::@ (#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) TIME     Default is %%TIME%%
::@(#) 
::@(#) Default morning ends at 07:00 and evening starts at 22:00
::@(#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Note! Night is either Morning nor evening ;-)
::@(#)
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      CALL %$NAME% 
::@(#)  Same as:
::@(#)      CALL %$NAME% %%TIME%%
::@(#)  
::@(#)      CALL %$NAME% %%TIME%% 06:00:00 20:00:00
::@(#)  Day between 06:00 and 22:00
::@(#)  
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@(#)  0   OK  (Daytime)
::@(#)  1   Help or manual page 
::@(#)  2   Morning
::@(#)  3   Evening
::@(#)  4+  Error
::@(#)
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
::@ (#)  URL: 
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init Description [xx.xxx]
::SET $VERSION=2010-10-27&SET $REVISION=15:15:00&SET $COMMENT=Initial [01.000]
::SET $VERSION=2014-01-07&SET $REVISION=15:09:00&SET $COMMENT=Bugfix on return value/ErikBachmann [01.001]
::SET $VERSION=2015-02-19&SET $REVISION=03:25:37&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************
    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
::ENDLOCAL

:MAIN
    CALL SET _Periode=99
    CALL _PreFunction %* || ( EXIT /B 1 )

    CALL :Init %*
    CALL :IsDay "%_Time%"
    @ENDLOCAL&SET _Isday=%_Periode%
    EXIT /B %_isday%
GOTO :EOF

::----------------------------------------------------------------------

:Init Time morning evening
    CALL SET _Time=%~1
    IF NOT DEFINED _Time CALL SET _TIME=%TIME:~0,8%
    IF NOT (%2!)==(!) SET _Morning=%2
    IF NOT (%3!)==(!) SET _EVENING=%3

    IF NOT DEFINED _Morning SET _Morning=06:00:00
    IF NOT DEFINED _EVENING SET _EVENING=22:00:00
GOTO :EOF

::----------------------------------------------------------------------

:IsDay

    IF /I "%~1" LSS "%_Morning%" (
        %_Debug_% 1 _Morning: %1 ^< %_Morning% 
        CALL SET _Periode=2
    ) ELSE IF /I "%~1" GTR "%_EVENING%" (
        %_Debug_% 2 _EVENING: %1 ^> %_EVENING% 
        CALL SET _Periode=3
    ) ELSE IF /I "%~1" LSS "24:00:01" (
        %_Debug_% 0 Daytime: %_Morning% ^< %1 ^< %_EVENING% 
        CALL SET _Periode=0
    ) ELSE (
        %_Debug_% 0 Daytime: %_Morning% ^< %1 ^< %_EVENING% 
        CALL SET _Periode=0
    )
GOTO :EOF

::*** End of File ******************************************************