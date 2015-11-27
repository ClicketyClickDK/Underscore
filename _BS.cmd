@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Set environment variable _BS to contain a backspace
SET $AUTHOR=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $Source=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)      %$NAME%
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Set an environment variable to hold a backspace character. 
::@(#)  Used in text manipulation on screen
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      CALL %$NAME%
::@(#)      SET /P "_=a-{EXCL}_BS{EXCL}z"<nul
::@(#)  Will display:      
::@(#)      az
::@(#)
::@(#)  Looping wheel to show activity  
::@(#)      CALL %$NAME%
::@(#)      SET /P _=Looping 1:%_max%: {LT}<nul
::@(#)      FOR /L %%a IN (1,1,%_max%) DO (
::@(#)         CALL :Loop %%a
::@(#)       PING -w 1 -n 1 1.1.1.1>nul
::@(#)      )
::@(#)      ECHO Done!
::@(#)      GOTO :EOF
::@(#)
::@(#)      :LOOP 
::@(#)          SET /A _=%~1 %% 4
::@(#)          IF "0" == "{EXCL}_{EXCL}" SET /P "_=^{PIPE}{EXCL}_BS{EXCL}"{LT}NUL
::@(#)          IF "1" == "{EXCL}_{EXCL}" SET /P "_=/{EXCL}_BS{EXCL}"{LT}NUL
::@(#)          IF "2" == "{EXCL}_{EXCL}" SET /P "_=-{EXCL}_BS{EXCL}"{LT}NUL
::@(#)          IF "3" == "{EXCL}_{EXCL}" SET /P "_=\{EXCL}_BS{EXCL}"{LT}NUL
::@(#)      GOTO :EOF
::@(#)  
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)
::@(#)ENVIRONMENT
::@(-)  Variables affected
::@(#)  _BS     Holds the backspace character
::@(#)
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
::@(#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#)  _cr.cmd     Carriage return  
::@(#)  _LF.cmd     Line Feed  
::@(#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@(#)  Author: Ed Dyreen
::@(#)  URL: http://www.dostips.com/forum/viewtopic.php?f=3{AMP}t=2124
::@(#)
::@(#)SOURCE
::@(-)  Where to find this source
::@(#)  %$Source%
::@(#)
::@ (#)AUTHOR
::@(-)  Who did what
::@ (#)  %$AUTHOR%
::*** HISTORY **********************************************************
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm&SET $COMMENT=Description/init
::SET $VERSION=2015-02-19&SET $REVISION=00:00:00&SET $COMMENT=Initial/ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=16:00:00&SET $COMMENT=GetOpt: Calling usage and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    ::CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
    ECHO:%*| findstr "\<[-/]*selftest\>" >nul 2>&1 & IF NOT ERRORLEVEL 1 CALL :SelfTest & EXIT /b 0 

ENDLOCAL
:: 
@for /f %%a in ('"prompt $H&for %%b in (1) do rem"') do CALL set "_BS=%%a"
