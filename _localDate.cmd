@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Setting environment variables with local time as strings
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
::@(#)  LocalDate           YYYY-MM-DDThh:mm:ss.iiiii+000   ISO8601 format
::@(#)  LocalDateStamp      YYYYMMDDhhmmdd.iiiii+000        Valid for file stamps / names
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#) CALL %$NAME% & SET LocalDate
::@(#)  
::@(#)  LocalDate=2021-11-10T15:23:36.667000+060
::@(#)  LocalDateStamp=20211110152336.667000+060
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
::@(#)  URL: https://stackoverflow.com/a/50577277
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
  SET $VERSION=2021-11-10&SET $REVISION=15:13:00&SET $COMMENT=Initial/ErikBachmann
::**********************************************************************
::@(#){COPY}%$VERSION:~0,4% %$Author%
::**********************************************************************
::ENDLOCAL

:MAIN
    :: Initiating global environmen
    CALL "%~dp0\_PreScript" %* || (CALL %~dp0\_PostScript & EXIT /B 1 )

    :: Initiating Local environmen
    CALL :Init %*

    ::for /F "tokens=2 delims==." %%I in ('%SystemRoot%\System32\wbem\wmic.exe OS GET LocalDateTime /VALUE') do set "LocalDate=%%I"
    FOR /F "tokens=2-3 delims==." %%I IN ('%SystemRoot%\System32\wbem\wmic.exe OS GET LocalDateTime /VALUE') DO SET "LocalDateStamp=%%I.%%J"
    ::set "LocalDate=%LocalDate:~0,8%"
    SET "LocalDate=%LocalDateStamp:~0,4%-%LocalDateStamp:~4,2%-%LocalDateStamp:~6,2%T%LocalDateStamp:~8,2%:%LocalDateStamp:~10,2%:%LocalDateStamp:~12,2%%LocalDateStamp:~14%"
ENDLOCAL&SET LocalDate=%LocalDate%&SET LocalDateStamp=%LocalDateStamp%

::set LocalDate

::*** End of File ******************************************************