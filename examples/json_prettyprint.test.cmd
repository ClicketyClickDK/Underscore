@ECHO OFF
SETLOCAL EnableDelayedExpansion
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Testing module json_prettyprint.cmd
SET $Author=Erik Bachmann, ClicketyClick.dk (ErikBachmann@ClicketyClick.dk)
SET $SOURCE=%~f0
::----------------------------------------------------------------------
::@(#)NAME
::@(#)  %$Name% -- %$Description%
::@(#) 
::@(#)SYNOPSIS
::@(#)      CALL %$Name% %*
::@(#)  

:: \_\examples\json_prettyprint.test.cmd


::----------------------------------------------------------------------
::History
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm:ss&SET COMMENT=Init/Description
  SET $VERSION=2021-12-28&SET $REVISION=09:43:15&SET $COMMENT=Init / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

ECHO:%$NAME% v. %$VERSION%&ECHO:%$description%

ENDLOCAL

:init
    :: Get input from Command Line
    SET input=%~1
    SET output=%~2
    :: Set default I/O
    IF NOT DEFINED input    SET input=%~p0\testdata\json_test.compressed.json
    ::IF NOT DEFINED output   SET output=%~n0
    :: Path to modules
    SET PATH=\_\;%PATH%
    SET PATH=..\;%PATH%
    ::Define LF variable containing a linefeed (0x0A)
    SET _LF=^


    ::Above 2 blank lines are critical - do not remove

    :: Test input
    IF NOT EXIST "%input%" (
        ECHO:ERROR: Input file [%input%] not found
        GOTO :EOF
    )

::----------------------------------------------------------------------

:Tests
    ECHO::: Pretty Print JSON

    :: Set EnableDelayedExpansion to enable nested variables
    SETLOCAL EnableDelayedExpansion
    
    CALL SET "LFtoken=¤"
    CALL json_prettyprint "%input%" "    " "$PP" "%LFtoken%"

    :: Expand embedded New Line
    ECHO:%~n0[65] %$PP:¤=!_LF!%
    ::ECHO:%~n0[66] %$PP:!LFtoken!=!_LF!%

    :: Should only list $PP in One Line format
    SET $
GOTO :EOF

::*** End of File ******************************************************
