@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Make an archive version of batch jobs
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
::@(#)      %$Name%
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Copy any new files in the script directory to archive directory.
::@(#)  Insert file data and time in filename
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  ECHO:Hello>dummy.cmd
::@(#)  CALL %$NAME%
::@(#)  
::@(#)  Will create a copy of dummy.cmd in .ARCHIVE\dummy.yyyy-mm-ddThh-mm.cmd
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
::@(#) 
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#) checkOutArchive.cmd
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init Description [xx.xxx]
::SET $VERSION=2010-10-20&SET $REVISION=00:00:00&SET $COMMENT=Initial [01.000]
::SET $VERSION=2010-11-12&SET $REVISION=16:23:00&SET $COMMENT=Adding exact path to _prescript/ErikBachmann [01.010]
::SET $VERSION=2015-02-19&SET $REVISION=02:54:07&SET $COMMENT=Autoupdate / ErikBachmann
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
  SET $VERSION=2015-11-12&SET $REVISION=15:32:00&SET $COMMENT=Adding Debug info / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

ECHO:%$NAME% -- %$DESCRIPTION%
ECHO:v. %$VERSION% r. %$REVISION%
ECHO:

:Init
    IF NOT EXIST .ARCHIVE MKDIR .ARCHIVE
    SET _FileCount=0

:Processing
    FOR %%A IN (*.cmd *.bat) DO CALL :ArchiveFile "%%~A"

:Finalize
    ECHO:
    CALL _Action "Files archived"
    CALL _Status "%_FileCount%"
    ECHO:*** Done ***
GOTO :EOF

::----------------------------------------------------------------------

:ArchiveFile
    %_DEBUG_% %0 [%~1]
    CALL "%~dp0\_action" "- [%~1]"
    CALL SET _FileTime=%%~t1
    CALL SET _FileTime=!_FileTime:~6,4!-!_FileTime:~3,2!-!_FileTime:~0,2!T!_FileTime:~11,5!
    CALL SET _FileTime=!_FileTime::=-!
    %_DEBUG_% FileTime[%_FileTime%]

    CALL SET _target=%~dp1\.archive\%~n1.%_FileTime%%~x1
    %_DEBUG_% Target[%_target%]

    IF NOT EXIST "%_target%"  (
        CALL "%~dp0\_status" "%_FileTime%"
        %_DEBUG_% Target not found: Installing [%_target%]
        COPY "%~1" "%_target%">nul
        SET /A _FileCount+=1
    ) ELSE CALL "%~dp0\_status" "OK"
GOTO :EOF :ArchiveFile

::*** End of File *****************************************************