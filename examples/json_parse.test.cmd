@ECHO OFF
SETLOCAL EnableDelayedExpansion
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Testing module json_parse.cmd
SET $Author=Erik Bachmann, ClicketyClick.dk (ErikBachmann@ClicketyClick.dk)
SET $SOURCE=%~f0
::----------------------------------------------------------------------
::@(#)NAME
::@(#)  %$Name% -- %$Description%
::@(#) 
::@(#)SYNOPSIS
::@(#)      CALL %$Name% %*
::@(#)  
::----------------------------------------------------------------------
::History
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm:ss&SET COMMENT=Init/Description
  SET $VERSION=2021-12-28&SET $REVISION=10:12:00&SET $COMMENT=Init / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

ECHO:%$NAME% v. %$VERSION%&ECHO:%$description%

:init
    ::SET DEBUG=0
    ::SET _DEBUG_=
    :: Get input from Command Line
    SET input=%~1
    SET output=%~2
    :: Set default I/O
    IF NOT DEFINED input    SET input=%~p0\testdata\json_test.prettyprint.json
    ::IF NOT DEFINED output   SET output=%~n0
    :: Path to modules
    SET PATH=\_\;%PATH%
    SET PATH=..\;%PATH%

:: Test input
IF NOT EXIST "%input%" (
    ECHO:ERROR: Input file [%input%] not found
    GOTO :EOF
)

:Tests
    CALL :json_parse
GOTO :EOF

::----------------------------------------------------------------------

:json_parse
    ECHO:::----------------------------------------------------------------------

    ECHO :: Parse JSON to environment
    CALL json_parse "%input%"

    ECHO :: Parsed JSON
    set __
    ECHO:::----------------------------------------------------------------------

GOTO :EOF


::*** End of File ******************************************************
