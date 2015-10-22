@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Checkout updates/install new units
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
::@(#)      %$NAME% [VAR]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Install any newer file from Archive directory.
::@(#) 
::@(#)  WILL overwrite any older file in scriptdirectory WITHOUT warning 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
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
::SET $VERSION=2015-02-19&SET $REVISION=02:54:38&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
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
    SET _FilesCopied=0

:Processing
    FOR %%A IN (.Archive\*.cmd .Archive\*.bat) DO CALL :CheckoutFile "%%~A"

:Finalize
    TITLE %$NAME% done: Tested %_FileCount%. Updates %_FilesCopied% 
    ECHO:
    CALL _Action "Files tested"
    CALL _Status "%_FileCount%"
    CALL _Action "Files installed/updated"
    CALL _Status "%_FilesCopied%"
    ECHO:*** Done ***
GOTO :EOF

::----------------------------------------------------------------------

:CheckOutFile
    SET /A _FileCount+=1
    CALL SET _Source=%~1
    CALL SET _target=%~n1
    CALL SET _target=%_target:~0,-17%%~x1
    TITLE %_target%

    :: Find source time
    CALL SET _FileTime=%%~t1
    CALL SET _FileTime=!_FileTime:~6,4!-!_FileTime:~3,2!-!_FileTime:~0,2!T!_FileTime:~11,5!
    CALL SET _FileTime=!_FileTime::=-!

    CALL _Action "[%_target%] [%_fileTime%]"
    :: IF target does not exist COPY
    IF NOT EXIST "%_target%" (
        CALL _State "Installing"
        
        COPY /V "%_Source%" "%_target%">nul 2>&1
        IF ErrorLevel 1 (
            CALL _Status "Instal FAILED"
        ) ELSE (
            CALL _Status "Installed OK"
            SET /A _FilesCopied+=1
        ) 
        GOTO :EOF
    )
    
    :: ELSE Match date
    ::ECHO Testing date

    :: Find target time
    FOR %%a IN (%_target%) DO CALL SET _TargetTime=%%~ta
    CALL SET _TargetTime=!_TargetTime:~6,4!-!_TargetTime:~3,2!-!_TargetTime:~0,2!T!_TargetTime:~11,5!
    CALL SET _TargetTime=!_TargetTime::=-!
    ::CALL _Action "[%_target%] [%_targetTime%]"
    
    IF /I "%_targetTime%" LSS "%_FileTime%" (
        CALL _State "Updating..."
        TITLE Updating %_target%
        COPY /V "%_Source%" "%_target%">nul 2>&1
        IF ErrorLevel 1 (
            CALL _Status "Update FAILED"
        ) ELSE (
            CALL _Status "Updated OK"
            SET /A _FilesCopied+=1
        )
        TITLE %_target% done
    )
    IF /I "%_targetTime%" GTR "%_FileTime%" CALL _Status Ignore
    IF /I "%_targetTime%" EQU "%_FileTime%" CALL _Status Identical
GOTO :EOF

:ArchiveFile
    ::ECHO  [%~1]
    CALL "%~dp0\_action" "- [%~1]"
    CALL SET _FileTime=%%~t1
    CALL SET _FileTime=!_FileTime:~6,4!-!_FileTime:~3,2!-!_FileTime:~0,2!T!_FileTime:~11,5!
    CALL SET _FileTime=!_FileTime::=-!
    CALL SET _target=%~dp1\.archive\%~n1.%_FileTime%%~x1
    
    IF NOT EXIST "%_target%"  (
        CALL "%~dp0\_status" "%_FileTime%"
        COPY "%~1" "%_target%">nul
        SET /A _FileCount+=1
    ) ELSE CALL "%~dp0\_status" "OK"
GOTO :EOF :ArchiveFile

::*** End of File *****************************************************