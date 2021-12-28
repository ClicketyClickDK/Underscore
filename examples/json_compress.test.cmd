@ECHO OFF
SETLOCAL EnableDelayedExpansion
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Testing module json_compress.cmd
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
  SET $VERSION=2021-12-28&SET $REVISION=09:43:15&SET $COMMENT=Init / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

ECHO:%$NAME% v. %$VERSION%&ECHO:%$description%

:init
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
    CALL :json_compress_a
    CALL :json_compress_b
    CALL :json_compress_c
GOTO :EOF

::----------------------------------------------------------------------

:json_compress_a
    ECHO:::----------------------------------------------------------------------
    :: Set output as function name
    SET output=%~0
    SET output=%output:~1%.json
    
    ECHO :: Compress JSON (save raw) ^>[%output%]
    
    CALL json_compress "%input%" "%output%" JSON RAW
    ECHO:&ECHO json[%JSON%]
    ECHO:&ECHO raw[%RAW%]
    ECHO:
GOTO :EOF

::----------------------------------------------------------------------

:json_compress_b
    ECHO:::----------------------------------------------------------------------
    :: Set output as function name
    SET output=%~0
    SET output=%output:~1%.json
    
    ECHO :: Compress JSON  ^>[%output%]
    SET json=
    SET raw=
    CALL json_compress "%input%" "%output%" JSON
    ECHO:&ECHO json[%JSON%]
    ECHO:&ECHO raw[%RAW%]
    ECHO:
GOTO :EOF

::----------------------------------------------------------------------

:json_compress_c
    ECHO:::----------------------------------------------------------------------
    :: Set output as function name
    SET output=%~0
    SET output=%output:~1%.json

    ECHO :: Compress JSON  ^>[%output%]
    ECHO: (Should fail! due to no return variable)
    SET json=
    CALL json_compress "%input%" "%output%"
    ECHO json[%JSON%]
    ECHO raw[%RAW%]
GOTO :EOF

::*** End of File ******************************************************
