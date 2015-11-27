@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Post processing template
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
::@(#)      %$NAME% [function] {arguments}
::@(#)   
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Used as a post processing template with _preScript.cmd
::@(#)  No detailed example currently available
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)     CALL _preScript
::@(#)     :: processing
::@(#)     CALL %$NAME%
::@(#) 
::@ (#) 
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)
::@ (#)ENVIRONMENT
::@(-)  Variables affected
::@(#)  $ErrorLevel     Increased with OS errorlevel
::@(#)
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
::@(#)  _UTC                    Current time
::@(#)  _registry.write_string  Write data to registry
::@(#)
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
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm&SET $COMMENT=Description/init
::SET $VERSION=2015-02-19&SET $REVISION=00:00:00&SET $COMMENT=Initial/ebp
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
  SET $VERSION=2015-11-23&SET $REVISION=16:30:00&SET $COMMENT=GetOpt replaced _getopt.sub simple call. Reduces runtime to 1/3 / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    ::CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
    :: Check ONLY for combinations of -h, /h, --help
    CALL _getopt.sub %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

    CALL _UTC
    
    CALL _registry.write_string ^
        "HKEY_LOCAL_MACHINE\SOFTWARE\ClicketyClick.dk\%$Name%" ^
        "End" "%UTC%"
    
    CALL _registry.write_string ^
        "HKEY_LOCAL_MACHINE\SOFTWARE\ClicketyClick.dk\%$Name%" ^
        "Status" "%$ErrorLevel%"
    
    %_DEBUG_% .Exit status [%$ErrorLevel%]
    
    IF "0"=="%$ErrorLevel%" (
        %_Verbose_% Done!
    ) ELSE (
        %_Verbose_% Ooops! %$ErrorLevel% - Check the log and trace files
        IF EXIST %$LogFile%   %_Verbose_% Log file: %$LogFile%
        IF EXIST %$Tracefile% %_Verbose_% Trace file: %$Tracefile%

        CHOICE /T 10 /C ny /D n /m "Want to see the logs?"
        IF ERRORLEVEL 2 (
            IF EXIST %$LogFile%   START NOTEPAD %$LogFile%
            IF EXIST %$Tracefile% START NOTEPAD %$Tracefile%
        )
    )
    
    EXIT /b %$ErrorLevel%