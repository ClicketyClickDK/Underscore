@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Setting environment variables with UTC time as strings
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
::@ (#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@ (#)  -h      Help page
::@ (#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Sets the environment variables
::@(#)  UTC           YYYY-MM-DDThh:mm:ss.Z     ISO8601 format
::@(#)  UTCStamp      YYYYMMDDhhmmss            Valid for file stamps / names
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#) CALL %$NAME% & SET UTC
::@(#)
::@(#)      UTC=2021-11-10T14:17:05.Z
::@(#)      UTCSTAMP=20211110141705
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
::@ (#)REQUIRES
::@(-)  Dependecies
::@ (#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@ (#)  _GetOpt.cmd     Parse command line options and create environment vars
::@ (#) _Prescript.cmd
::@ (#) _PostScript.cmd
::@ (#) 
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  
::@ (#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@(#)  URL: https://stackoverflow.com/a/65542963
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Description/init
  SET $VERSION=2021-11-10&SET $REVISION=15:22:00&SET $COMMENT=Initial/ErikBachmann
::**********************************************************************
::@(#){COPY}%$VERSION:~0,4% %$Author%
::**********************************************************************
::ENDLOCAL

:MAIN
    CALL "%~dp0\_DEBUG"
    ::CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
    :: Check ONLY for combinations of -h, /h, --help
    CALL "%~dp0\_getopt.sub" %*&IF ERRORLEVEL 1 EXIT /B 1

    :: Initiating Local environment
    ::CALL :Init %*

    CALL :getUTC
    ENDLOCAL& SET UTC=%UTC%&SET UTCSTAMP=%UTCSTAMP%
GOTO :EOF



:getUTC
    SETLOCAL
    REM get UTC times:
    for /f %%a in ('wmic Path Win32_UTCTime get Year^,Month^,Day^,Hour^,Minute^,Second /Format:List ^| findstr "="') do (set %%a)
    
    Set Second=0%Second%
    Set Second=%Second:~-2%
    Set Minute=0%Minute%
    Set Minute=%Minute:~-2%
    Set Hour=0%Hour%
    Set Hour=%Hour:~-2%
    Set Day=0%Day%
    Set Day=%Day:~-2%
    Set Month=0%Month%
    Set Month=%Month:~-2%
    
    ::set UTCTIME=%Hour%:%Minute%:%Second%
    ::set UTCDATE=%Year%%Month%%Day%
    SET UTC_STAMP=%Year%%Month%%Day%%Hour%%Minute%%Second%
    SET UTC=%Year%-%Month%-%Day%T%Hour%:%Minute%:%Second%.Z
    ENDLOCAL& SET UTC=%UTC%&SET UTCSTAMP=%UTC_STAMP%
GOTO :EOF

::*** End of File ******************************************************