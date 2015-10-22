@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
SET $NAME=%~n0
SET $DESCRIPTION=Progress bar weighted in pct.
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
::@(#)      %$NAME% [ [ProcessMax] [ProcessBarMaker] [CurrentValue] ]
::@(#) 
::@(#)  Initiate process bar
::@(#)      %$NAME% [ProcessMax] {ProcessBarMaker}
::@(#) 
::@(#)  Update process bar
::@(#)      %$NAME% [CurrentValue]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)  ProcessMax          The highest value (ie. 100%%)
::@(#)  ProcessBarMaker     The marker char in the bar (Default= #)
::@(#)  CurrentValue        Current value in loop
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Updates the progressbar
::@(#)      [################################..................]
::@(#)      
::@(#)  This function requires an initiating call to %$NAME%
::@(#)      
::@(#)  NOTE There is NO loop control!
::@(#)      
::@(#)LIMITATIONS
::@(#)  The ProcessBarMarker CANNOT be a digit due to redirection rules in 
::@(#)  DOS [Default=@]
::@(#)  Avoid other special characters like ampersand or pipe
::@(#)      
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      SET _last_line=120
::@(#)      
::@(#)      Call %$NAME% %_last_line% #
::@(#)      
::@(#)      FOR /L %%x IN (1,1,%_last_line%) DO (
::@(#)          CALL %$NAME% %%x
::@(#)      )
::@(#)      
::@(#)EXIT STATUS
::@(#)  Exit status is 0 if any matches were found, otherwise 1.
::@(#) 
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
::@(#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#)  _registry.delete_string.cmd     _registry.list.cmd
::@(#)  _registry.read_string.cmd       _registry.write_string.cmd
::@(#)
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init Description/Initials [xx.xxx]
::SET $VERSION=2010-10-14&SET $REVISION=14:27:00&SET $COMMENT=Initial/ErikBachmann [01.000]
::SET $VERSION=2010-10-20&SET $REVISION=17:15:00&SET $COMMENT=Addding $Source/ErikBachmann [01.001]
::SET $VERSION=2015-02-19&SET $REVISION=03:09:09&SET $COMMENT=Autoupdate / ErikBachmann
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
  SET $VERSION=2015-10-22&SET $REVISION=06:00:00&SET $COMMENT=Update usage / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

ENDLOCAL

:MAIN
    CALL _GetOpt %*
    CALL _DEBUG

    CALL :ProcessBar %*
GOTO :EOF

::----------------------------------------------------------------------

:ProcessBar
    IF NOT "!"=="%~2!" (
        CALL :_ProcessBar %~1 %~2
        GOTO :EOF
    )

    :: Quit on 0 or negative
    IF "0" GEQ "%~1" GOTO :EOF

    :: Find percentage
    SET /a _ProcessBarCurrent=(%~1 * 100) / %_ProcessBarMax%
    SET ERRORLEVEL=%_ProcessBarCurrent%
    IF %ERRORLEVEL% GTR 100 (
        %_DEBUG_% OVERRUN [%~1]  "%_ProcessBarMark%" LEQ "%_ProcessBarCurrent%" 
        SET /p _=<nul >&2
        SET /p _=^^!<nul
        GOTO :EOF
    )
    SET ErrorLevel=0
    SET _1=000000000%_ProcessBarMark%
    SET _2=000000000%_ProcessBarCurrent%
    
   IF "%_1:~-9%" LEQ "%_2:~-9%" (
        CALL :_SetMark
    )
    EXIT /B 0
GOTO :EOF

::----------------------------------------------------------------------

:_SetMark
        FOR /L %%i IN ( %_ProcessBarMark%, 2,%_ProcessBarCurrent%) DO (
            SET /P _=%_ProcessBarMarker%<nul
            call SET /a _ProcessBarMark+=2
        )
GOTO :EOF

::----------------------------------------------------------------------

:_ProcessBar
    SET _ProcessBarMax=%~1
    SET _ProcessBarMark=2
    SET _ProcessBarMarker=%~2
    IF NOT DEFINED _ProcessBarMarker SET _ProcessBarMarker=#

    ::ATTENTION! The ProcessBarMarker CANNOT be a digit due to redirection rules in DOS
    FOR /L  %%i IN (0,1,9) DO (
        IF "%_ProcessBarMarker%"=="%%i" (
            %_DEBUG_% ATTENTION! The ProcessBarMarker CANNOT be a digit due to redirection rules in DOS ^(Default=@^)
            CALL SET "_ProcessBarMarker=a"
        )
    )

    ::Print template [.....]
    >&2 SET /P _=[< NUl
    FOR /L %%x IN (1,1,50) DO >&2 SET /P _=.< NUl
    >&2 SET /P _=]< NUl
    FOR /L %%x IN (1,1,51) DO @set /p=<nul >&2
GOTO :EOF

::*** End of File ******************************************************