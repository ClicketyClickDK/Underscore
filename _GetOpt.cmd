@ECHO OFF&SETLOCAL
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Parse command line options and create environment vars
SET $Author=Erik Bachmann, ClicketyClick.dk (ErikBachmann@ClicketyClick.dk)
SET $SOURCE=%~f0
::----------------------------------------------------------------------
::@(#)NAME
::@(#)  %$Name% -- %$Description%
::@(#) 
::@(#)SYNOPSIS
::@(#)      CALL %$Name% %*
::@(#)  
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Usage/Help page and exit 1 (Hard coded)
::@(#)  -? /?   Usage/Help page and exit 1 (Hard coded)
::@(#)  -! /!   Debug on (Hard coded)   See BUGS section. Use --Debug:1
::@(#)  -!- /!- Debug off (Hard coded)  See BUGS section. Use --Debug:0
::@(#)  
::@(#)DESCRIPTION
::@(#)  Build named environment variables from command line options
::@(#)  
::@(#)  Arguments can either be:
::@(#)      Simple      Like a name with no prefix [filename]
::@(#)      Option      Letter prefixed with one valid flag prefix [-h]
::@(#)      Combined    Option with a value separated by colon [-f:name]
::@(#)      Long        Long option [--help]
::@(#)      Long comb.  Long option with a value [--file:name]
::@(#)  
::@(#)  Valid flag prefixes are  "-" or "/".
::@(#)  The seperator between option and value can only be colon since
::@(#)  WinDOS will treat = as a blank.
::@(#)  If $NAME is not a defined environment var "UNDEFINED" is used as $NAME
::@(#)  
::@(#)      filename            Simple argument stored in sequential numbered 
::@(#)                          environment variables: @UNDEFINED.1=filename
::@(#)      -file:filename      Combined argument: @UNDEFINED.file=filename
::@(#)      /file:filename      Combined argument: @UNDEFINED.file=filename
::@(#)      --//file:filename   Combined argument: @UNDEFINED.file=filename
::@(#) 
::@(#)  NOTE!
::@(#)      If you entend to nest scripts both using %$NAME% you must 
::@(#)      start the nested script with a SETLOCAL statement to preserve
::@(#)      the callers environment!
::@(#) 
::@(#)EXAMPLES:
::@(#)  SET $NAME=x
::@(#)  ::Parse options to current script
::@(#)  CALL %$NAME% %*
::@(#)    
::@(#)  ::Show options
::@(#)  set @x
::@(#)    
::@(#)  ::Clear env vars
::@(#)  CALL %$NAME%
::@(#) 
::@(#)  If x.bat contains the statement:
::@(#)      SET $NAME=x
::@(#)      CALL %$NAME% %*
::@(#)      SET @
::@(#) 
::@(#)  :: Enable delayed expansion of vars to use content of vars
::@(#)      SETLOCAL ENABLEDELAYEDEXPANSION
::@(#)      ECHO z=!@%$NAME%.z!! 
::@(#)      SETLOCAL DISABLEDELAYEDEXPANSION
::@(#) 
::@(#)  :: Or hard code reference
::@(#)      ECHO a=%@x.z%
::@(#) 
::@(#)  :: Clear flags
::@(#)      CALL %$NAME%
::@(#) 
::@(#)  Executing: x.bat -y:z -flag file -z:"hello world"
::@(#) 
::@(#)  x.bat will have the environment:
::@(#)      $x.x=yy
::@(#)      @x.z=1
::@(#) 
::@(#)  CALL x.bat -y:z -flag file -z:"hello world"
::@(#)      @x.1=file
::@(#)      @x.flag=1
::@(#)      @x.y=z
::@(#)      @x.z="hello world"
::@(#) 
::@(#)  NOTE: "-flag" and "file" are NOT combined
::@(#) 
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  
::@(#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@(#)  0   OK
::@(#)  1   Usage (or error)
::@(#)  
::@(#)ENVIRONMENT
::@(-)  Variables affected
::@(#)  Will change environment according to the given arguments.
::@(#) 
::@(#)  If environment var DEBUG is defined and > 1 debug will be enabled as default.
::@(#) 
::@(#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@(#)  -! and /! will activate debug and set env variable @x.debug=1
::@(#)  -!- and /!- will deactivate debug BUT set env variable @x.debug=1
::@(#)  
::@(#)  ! flags are not available if you use delayed expantion as in 
::@(#)  SETLOCAL ENABLEDELAYEDEXPANSION
::@(#)  
::@(#)REQUIRES
::@(-)  Dependencies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  what.cmd        Show usage
::@(#) 
::@(#)REFERENCES:
::@(#)  https://en.wikipedia.org/wiki/Getopt
::@(#)  
::@(#)SOURCE
::@(#)  %$Source%
::----------------------------------------------------------------------
::History
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm:ss&SET COMMENT=Init/Description
::SET $VERSION=00.000&SET $REVISION=2009-04-17T11:01:00&SET COMMENT=ebp/Initial
::SET $VERSION=00.200&SET $REVISION=2009-06-10T17:41:00&SET COMMENT=ebp/Update headers and debug information
::SET $VERSION=01.000&SET $REVISION=2010-10-12T15:30:00&SET COMMENT=ebp/Update headers and $ARG syntax
::SET $VERSION=01.010&SET $REVISION=2010-10-13T23:50:00&SET COMMENT=ebp/Update headers and arg stored in @name.
::SET $VERSION=01.011&SET $REVISION=2010-10-20T17:15:00&SET $Comment=Addding $Source/EBP
::SET $VERSION=01.020&SET $REVISION=2010-11-12T16:17:00&SET $Comment=Exact path to _debug/EBP
::SET $VERSION=01.050&SET $REVISION=2015-10-08T11:19:00&SET $Comment=Call to usage. Exit on error 1/EBP
::SET $VERSION=2015-10-08&SET $REVISION=16:00:00&SET $COMMENT=GetOpt: Calling usage and exit on error / ErikBachmann
::SET $VERSION=2015-10-15&SET $REVISION=11:22:00&SET $COMMENT=--help defaults to usage / ErikBachmann
::SET $VERSION=2015-11-05&SET $REVISION=14:27:00&SET $COMMENT=Long options and multiple prefix flags / ErikBachmann
::SET $VERSION=2015-11-06&SET $REVISION=10:05:00&SET $COMMENT=Special usage flags hard coded -? et.al. usage/help / ErikBachmann
::SET $VERSION=2015-11-06&SET $REVISION=10:25:00&SET $COMMENT=Special usage flags hard coded -! et.al. = debug / ErikBachmann
::SET $VERSION=2015-11-07&SET $REVISION=17:28:00&SET $COMMENT=Clean up in debug info / ErikBachmann
  SET $VERSION=2016-07-07&SET $REVISION=13:15:00&SET $COMMENT=  Only cut the first separator (:) / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************
ENDLOCAL

:MAIN
    :: Hard coded check on -? --? /? flags since these are hard to pass to functions
    ECHO:%*| findstr "\<[-/]*\?\>" >nul 2>&1
    IF NOT ERRORLEVEL 1 GOTO usage&&GOTO :EOF
    :: Hard coded debug flag -! --! /! since these are hard to pass to functions
    ECHO:%*| findstr "\<[-/]*\!\>" >nul 2>&1 
    IF NOT ERRORLEVEL 1 CALL SET DEBUG=1&ECHO:Debug on
    :: Hard coded debug flag -! --! /! since these are hard to pass to functions
    ECHO:%*| findstr "\<[-/]*\!-\>" >nul 2>&1 
    IF NOT ERRORLEVEL 1 CALL SET DEBUG=0
    CALL "%~dp0\_Debug"
    CALL :init %*
    CALL :_GetOpt %*&IF ERRORLEVEL 1 EXIT /B 1

    :: Hard coded flags for help
    IF defined @%$NAME%.h       GOTO usage
    IF defined @%$NAME%.help    GOTO usage
    IF defined @%$NAME%.debug   SET DEBUG=!@%$NAME%.debug!
    ::IF defined @%$NAME%.manual  SET DEBUG=1 && SET _Pattern=&& GOTO usage
GOTO :EOF

::----------------------------------------------------------------------

:init
    ENDLOCAL
    
    SET _prefixFlags=/ -
    SET _prefixFlagMask=%_prefixFlags: =%

    IF NOT DEFINED $NAME SET $NAME=UNDEFINED
    :: Set all temp vars to 0
    FOR %%i IN (_@ _ARGC) DO CALL SET %%i=0

    IF /I "%DEBUG%" GTR "2" %_DEBUG_% ...Remove old flags
    FOR /F "usebackq delims==" %%C IN (`SET @%$NAME% 2^>nul`) DO IF DEFINED %%C SET %%C=&&%_DEBUG_% Removing %%C=
GOTO :EOF   *** :init ***

::----------------------------------------------------------------------

:usage
    IF NOT DEFINED $Source SET $Source=%~f0
    CALL "%~dp0\what.cmd" "%$Source%"
    SET $ErrorLevel=1
    EXIT /b 1
GOTO :EOF   *** :usage ***

::----------------------------------------------------------------------

:_GetOpt
    IF "%~1!"=="!" (
        %_DEBUG_% ...No arguments. Skipping
        GOTO :EOF
    ) ELSE (
        %_DEBUG_% ...Arguments [%*]
        REM Dummy for %_DEBUG_
    )

    %_DEBUG_% - Parsing [%*]
    FOR %%A IN (%*) DO (
        %_DEBUG_% .. current @[%%A]
        CALL :_parse %%A
    )

    %_DEBUG_% .. parsing done
    :: Remove all temp vars
    FOR %%i IN (_@ _ARGC) DO CALL SET %%i=
GOTO :EOF   *** :_GetOpt ***

::---------------------------------------------------------------------

:_parse
    SET $ARG=%~1

    :: Remove prefix from flags
    SET _FlagFound=0
    
    %_DEBUG_% ... Parsing(%0) "%_prefixFlags%" IN [%$ARG%]
    FOR %%a IN (%_prefixFlags%) DO (
        %_DEBUG_% ... Parsing[%0] "Flag found [%%a]"
        IF "%%a"=="%$ARG:~0,1%" CALL SET /a _FlagFound+=1
    )

    %_DEBUG_% ... Parsing(%0) Status on flags found: [%_FlagFound%]
    FOR /F "tokens=* delims=%_prefixFlagMask%" %%a IN ("%$ARG%") DO SET "$ARG=%%a"
    %_DEBUG_% ... Parsing(%0) w/o prefix [%$ARG%] [%_FlagFound%]

    IF DEFINED _FlagFound (
       CALL :__parse
    ) ELSE (
        CALL :_NoFlag "%$ARG%"
    )
GOTO :EOF   *** :_parse ***

::---------------------------------------------------------------------

:_NoFlag
    SET /A _ARGC+=1
    SET @%$NAME%.%_ARGC%=%~1
GOTO :EOF   *** :_NoFlag ***

::---------------------------------------------------------------------
:__parse
    %_DEBUG_% .... Parsing(%0): %$ARG%
    ::FOR /F "usebackq tokens=1-2 delims=:" %%C IN (`ECHO %$ARG%`) DO (
    :: Only cut the first separator (:)
    FOR /F "usebackq tokens=1* delims=:" %%C IN (`ECHO %$ARG%`) DO (
        IF /I "" NEQ "%%D" (
            %_DEBUG_% ...Simple argument: [%%C]=[%%D]
            SET @%$NAME%.%%C=%%D
            %_DEBUG_% ...Setting [@%$NAME%.%%C]=[%%D]
            REM
        ) else (
            %_DEBUG_% ...Argument with value: [%%C][%%D]
            SET @%$NAME%.%$ARG%=1
            %_DEBUG_% ...Setting [@%$NAME%.%$ARG%]=[1]
        )
    )
GOTO :EOF   *** :__parse ***

::*** END Of File ******************************************************
