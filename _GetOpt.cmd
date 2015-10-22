@ECHO OFF&SETLOCAL
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Parse command line options and create environment vars
SET $Author=Erik Bachmann, ClicketyClick.dk (ErikBachmann@ClicketyClick.dk)
SET $SOURCE=%~dpnx0
::----------------------------------------------------------------------
::@(#)NAME
::@(#)  %$Name% -- %$Description%
::@(#) 
::@(#)SYNOPSIS
::@(#)      CALL %$Name% %*
::@(#) 
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
::@(#)DESCRIPTION
::@(#)  If $NAME is not a defined environment var "UNDEFINED" is used as $NAME
::@(#) 
::@(#)  NOTE!
::@(#)      If you entend to nest scripts both using %$NAME% you must 
::@(#)      start the nested script with a SETLOCAL statement to preserve
::@(#)      the callers environment!
::@(#) 
::@(#)EXAMPLES:
::@(#) 
::@(#)  If x.bat contains the statement:
::@(#)      SET $NAME=x
::@(#)      CALL %$NAME% %*
::@(#)      SET @
::@(#) 
::@(#)  :: Enable delayed expansion of vars to use content of vars
::@(#)      SETLOCAL ENABLEDELAYEDEXPANSION
::@(#)      ECHO z=!@%$NAME%.z! 
::@(#)      SETLOCAL DISABLEDELAYEDEXPANSION
::@(#) 
::@(#)  :: Or hard code reference
::@(#)      ECHO a=%@x.z%
::@(#) 
::@(#)  :: Clear flags
::@(#)      CALL %$NAME%
::@(#) 
::@(#) Executing: x.bat -y:z -flag file -z:"hello world"
::@(#) 
::@(#) x.bat will have the environment:
::@(#)      $x.x=yy
::@(#)      @x.z=1
::@(#) 


::CALL _getopt -y:z -flag file -z:"hello world"

::@(#)      @x.1=file
::@(#)      @x.flag=1
::@(#)      @x.y=z
::@(#)      @x.z="hello world"


::@(#) NOTE! Environment var DEBUG will enable debug info
::@(#) 
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)
::@(#)SOURCE
::@(#)  %$Source%
::@(#) 
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
  SET $VERSION=2015-10-22&SET $REVISION=06:00:00&SET $COMMENT=Update usage / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************
ENDLOCAL

:MAIN
    CALL "%~dp0\_Debug"
    CALL :init %*
    CALL :_GetOpt %*&IF ERRORLEVEL 1 EXIT /B 1
    
    ::SETLOCAL ENABLEDELAYEDEXPANSION
    ::ECHO:["!@%$name%.help!"]
    IF DEFINED @%$name%.help ECHO: Helping [%$source%]
    IF defined @%$NAME%.?       GOTO usage
    IF defined @%$NAME%.h       GOTO usage
    IF defined @%$NAME%.-help   GOTO usage
    IF defined @%$NAME%.manual  SET DEBUG=1 && GOTO usage 

GOTO :EOF

:usage
    ::CALL what %~dpnx0
    CALL "%~dp0\what.cmd" %$Source%
    SET $ErrorLevel=1
    EXIT /b 1
GOTO :EOF 
::----------------------------------------------------------------------

:init
    IF /I "--?" equ "%~1"   GOTO usage
    ENDLOCAL
    
    IF NOT DEFINED $NAME SET $NAME=UNDEFINED
    :: Set all temp vars to 0
    FOR %%i IN (_@ _ARGC) DO CALL SET %%i=0

    IF /I "%DEBUG%" GTR "2" %_DEBUG_% ...Remove old flags
        FOR /F "usebackq delims==" %%C IN (`SET @%$NAME% 2^>nul`) DO IF DEFINED %%C SET %%C=
GOTO :EOF

::----------------------------------------------------------------------

:_GetOpt
::    IF "%*!"=="!" (
    IF "%~1!"=="!" (
        %_DEBUG_% ...No arguments. Skipping
        GOTO :EOF
    ) ELSE (
        %_DEBUG_% ...Arguments [%*]
        REM Dummy for %_DEBUG_
    )

    %_DEBUG_% - Parsing 
    FOR %%A IN (%*) DO (
        %_DEBUG_% .. current @[%%A]
        CALL :_parse %%A
    )

    %_DEBUG_% .. parsing done
    :: Remove all temp vars
    FOR %%i IN (_@ _ARGC) DO CALL SET %%i=

    
GOTO :EOF

::---------------------------------------------------------------------

:_parse
   SET $ARG=%~1
   %_DEBUG_% ... Parsing(%0) "-" IN [%$ARG%]
    IF "-" equ "%$ARG:~0,1%" (
        CALL :__parse
    ) ELSE (
        CALL :_NoFlag "%$ARG%
    )

GOTO :EOF

::---------------------------------------------------------------------

:_NoFlag
    SET /A _ARGC+=1
    SET @%$NAME%.%_ARGC%=%~1
GOTO :EOF

::---------------------------------------------------------------------
:__parse

    %_DEBUG_% .... Parsing(%0): %$ARG:~1,256%
    FOR /F "usebackq tokens=1-2 delims=:" %%C IN (`ECHO %$ARG:~1,256%`) DO (
        IF /I "" NEQ "%%D" (
            %_DEBUG_% ...Simple argument: [%%C][%%D]
            SET @%$NAME%.%%C=%%D
            %_DEBUG_% ...Setting [@%$NAME%.%%C]=[%%D]
            REM
        ) else (
            %_DEBUG_% ...Argument with value: [%%C][%%D]
            SET @%$NAME%.%$ARG:~1,256%=1
            %_DEBUG_% ...Setting [@%$NAME%.%$ARG:~1,256%]=[1]
        )
    )
GOTO :EOF

::*** END Of File ******************************************************
