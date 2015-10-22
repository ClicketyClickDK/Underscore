@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Download an update from ClicketyClick.dk
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
::@(#)  %$Name% [Arguments]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Read a version indicator on the source website, download the related versioned package and unpack it.
::@(#)
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  CALL %$NAME 
::@(#)  
::@(#) 
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)
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
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  _GetOpt.cmd     Parse command line options and create environment vars
::@(#)  wget    A non-interactive network downloader
::@(#)  unzip   Unzip an existing ZIP archive
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init Description [xx.xxx]
::SET $VERSION=2010-10-20&SET $REVISION=00:00:00&SET $COMMENT=Initial [01.000]
::SET $VERSION=2010-11-12&SET $REVISION=16:23:00&SET $COMMENT=Adding exact path to _prescript/ErikBachmann [01.010]
::SET $VERSION=2015-02-19&SET $REVISION=03:15:13&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

:MAIN
    CALL :init %*
    CALL :process
    CALL :Finalize
GOTO :EOF

::---------------------------------------------------------------------

:init
    ECHO:%$NAME% -- %$DESCRIPTION%
    ECHO:v. %$VERSION% r. %$REVISION%
    ECHO:

    SET _URLstub=http://clicketyclick.dk/development/dos/_/
    SET _CurrentVersion=?
    SET _versionFile=%~dp0\.archive\current
    SET _archiveFile=%~dp0\.archive\current.zip
    SET _result=0
GOTO :EOF :init

::---------------------------------------------------------------------

:process
    CALL _ACTION "Getting current"
    ::CALL cscript //nologo c:\_\wget.vbs "%_URLstub%current"  "%_VersionFile%"
    CALL "%~dp0\wget.bat" "%_URLstub%current"  "%_VersionFile%"
    IF ERRORLEVEL 1 SET /A _result&=2
    type "%_VersionFile%"
    IF ERRORLEVEL 1 SET /A _result&=4

    FOR /F "Delims=;" %%a IN ('TYPE "%_VersionFile%"') DO (
        ECHO Downloading [%%~a]
        rem CALL cscript //nologo c:\_\wget.vbs "%_URLstub%%%~a"  "%_archiveFile%"
        CALL "%~dp0\wget.bat" "%_URLstub%%%~a"  "%_archiveFile%"
        IF ERRORLEVEL 1 SET /A _result&=8
    )

    CALL _Action "Unpacking"
    CALL _Status "%CD%\.ARCHIVE\"

    CALL _Action "Archive"
    IF NOT EXIST "%CD%\.ARCHIVE" (
        CALL _Status "Created"
        MKDIR "%CD%\.ARCHIVE"
        IF ERRORLEVEL 1 SET /A _result&=16
    ) ELSE CALL _Status "Found"

    CALL _Action "Unzipping"
    CALL _Status "%CD%\.ARCHIVE\"

    ::echo cscript //nologo unzipw "%_archiveFile%" "%CD%\.ARCHIVE\"
    echo CALL "%~dp0\unzip.bat" "%_archiveFile%" "%CD%\.ARCHIVE\"
    IF ERRORLEVEL 1 SET /A _result&=32
GOTO :EOF :Process

::---------------------------------------------------------------------

:Finalize
::dir "%CD%\.ARCHIVE\"

:: packing
::cscript //nologo zip.vbs xx.zip yy.txt


:: unpacking
::cscript //nologo unzip.vbs C:\_\dev\xx.zip "C:\tmp\"
    EXIT /b %_result%
GOTO :EOF :Finalize

::*** End Of File *****************************************************