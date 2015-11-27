@ECHO OFF
::@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Get previous month in ISO form YYYY-MM
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
::@(#)      %$NAME% [VAR] {YYYY-MM}
::@(#) 
::@(#)  Will set VAR=YYYY-MM 
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#) 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#) 
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
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm&::Init Description
::SET $VERSION=2010-01-05&SET $REVISION=16:37:00&SET $COMENT=Initial
::SET $VERSION=2015-02-03&SET $REVISION=15:51:00&SET $COMENT=Initial
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
  SET $VERSION=2015-11-23&SET $REVISION=16:30:00&SET $COMMENT=GetOpt replaced _getopt.sub simple call. Reduces runtime to 1/3 / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    ::CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
    :: Check ONLY for combinations of -h, /h, --help
    CALL _getopt.sub %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

:MAIN
::    CALL _PreFunction %* || ( EXIT /B 1 )
    CALL :_PreviousMonth.Init %*

    CALL :_PreviousMonth.Main %*
::ENDLOCAL&SET $PreviousMonth=%_PreviousMonth%
ENDLOCAL&SET %~1=%$pYear%-%$pMonth:~-2%
GOTO :EOF

::----------------------------------------------------------------------

:_PreviousMonth.init
    IF "#"=="#%~2" CALL "%~dp0\_utc" >nul
    IF NOT "#"=="#%~2" CALL SET UTC=%~2
    ::SET UTC
    CALL SET $year=%UTC:~0,4%
    CALL SET $month=%UTC:~5,2%
    CALL SET $day=%UTC:~8,2%
    SET /a $pMonth=%$month%-1
    SET $pYear=%$year%
GOTO :EOF

::----------------------------------------------------------------------

:_PreviousMonth.Main

   IF %$pMonth% EQU  0 (SET $pMonth=12)
   IF %$pMonth% EQU 12 (SET /a $pYear=%$pYear%-1)
   SET $pMonth=00%$pMonth%

GOTO :EOF

::*** End of File *****************************************************