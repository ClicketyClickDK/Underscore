@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Insert ISO timestamp in filename [name.ISO.ext]
SET $Author=Erik Bachmann, ClicketyClick.dk (E_Bachmann@ClicketyClick.dk)
SET $Source=%~f0
::*** HISTORY **********************************************************
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Description/init
  SET $VERSION=2017-01-14&SET $REVISION=13:00:00&SET $COMMENT=Initial/ErikBachmann
::**********************************************************************
::@(#){COPY}%$VERSION:~0,4% %$Author%
::**********************************************************************

:main
    ECHO:%$NAME% v.%$VERSION% rev.%$REVISION% 
    ECHO:-- %$DESCRIPTION%
    ECHO: / %$Author%
    ECHO:
    CALL :init %*
    CALL :Process %*
GOTO :EOF

::---------------------------------------------------------------------

:init
    REM
GOTO :EOF   :init

::---------------------------------------------------------------------

:Process
    ECHO:- Processing:
    CALL :ArchiveFile %*
GOTO :EOF   :Process

::---------------------------------------------------------------------

:ArchiveFile
    CALL "%~dp0\_action" "- [%~1]"
    CALL SET _FileTime=%%~t1
    CALL SET _FileTime=!_FileTime:~6,4!-!_FileTime:~3,2!-!_FileTime:~0,2!T!_FileTime:~11,5!
    CALL SET _FileTime=!_FileTime::=-!
    CALL SET _target=%~dpn1.%_FileTime%%~x1.

    IF NOT EXIST "%_target%"  (
        CALL "%~dp0\_state" "%_FileTime%"
        COPY "%~1" "%_target%">nul
        SET /A _FileCount+=1
        IF EXIST "%_target%" (
        CALL "%~dp0\_status" "%_FileTime% OK"
        ) ELSE CALL "%~dp0\_status" "%_FileTime% FAILED"
    ) ELSE CALL "%~dp0\_status" "%_FileTime% Found"
GOTO :EOF :ArchiveFile

::*** End of File *****************************************************