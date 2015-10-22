@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Spinner to indicate process
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
::@(#)      %$NAME% [type]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)      Sequence "-\|/" [Default]
::@(#)  o   Sequence "_.oO" 
::@(#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  A textual spinner to indicate that a process is running
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      SET _last_line=10
::@(#)      SET _Spinner=
::@(#)      FOR /L %%x IN (1,1,%_last_line%) DO (
::@(#)          CALL spinner
::@(#)          timeout 1 >nul
::@(#)      )
::@(#) 
::@(#) Or shorter
::@(#)      FOR /L %%x IN (1,1,10) DO @CALL spinner&timeout 1 >nul
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
::@ (#)  URL: http://stackoverflow.com/questions/368041/how-to-code-a-spinner-for-waiting-processes-in-a-batch-file
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
::SET $VERSION=2015-03-31&SET $REVISION=16:06:32&SET $COMMENT=Initial/ErikBachmann
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
  SET $VERSION=2015-10-22&SET $REVISION=06:00:00&SET $COMMENT=Update usage / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

ENDLOCAL

:Spinner
    SETLOCAL
        ::SET "__SPIN=-\|/"
        SET "__SPIN=Ä\³/"
        IF /I "o"=="%~1" SET "__Spin=_.oO"
        
        IF NOT DEFINED _BS CALL _BS
        IF NOT DEFINED _Spinner SET _SPINNER=0
        
        CALL SET "_Token=%%__spin:~%_spinner%,1%%"
        SET /P _=%_token%%_BS%<nul
        SET /A _Spinner+=1
        IF /I "3" LSS "%_spinner%" SET _Spinner=0
    ENDLOCAL&  SET "_Spinner=%_Spinner%"
GOTO :EOF

::*** End of File ******************************************************