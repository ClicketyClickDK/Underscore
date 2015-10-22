@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Searching for an executable on the path (or other path-like string if necessary)
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
::@(#)  %$Name% filename
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  DEPRICATED - Use: Where.exe [If available]
::@(#)  Used for identifying the location of an excetutable
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      CALL %$Name% reg
::@(#)  Should echo
::@(#)      C:\Windows\System32\reg.exe
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
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@(#)  URL: http://stackoverflow.com/questions/245395/underused-features-of-windows-batch-files#246691
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init / Description [xx.xxx]
::SET $VERSION=2010-10-13&SET $REVISION=15:36:00&SET $COMMENT=ErikBachmann / Initial: FindInPath [01.000]
::SET $VERSION=2010-10-14&SET $REVISION=00:15:00&SET $COMMENT=ErikBachmann / arg as @ [01.010]
::SET $VERSION=2010-10-20&SET $REVISION=17:15:00&SET $COMMENT=Addding $Source/ErikBachmann [01.011]
::SET $VERSION=2014-01-07&SET $REVISION=17:53:00&SET $COMMENT=Update doc + name change to which.cmd/ErikBachmann [01.020]
::SET $VERSION=2015-02-19&SET $REVISION=03:17:26&SET $COMMENT=Autoupdate / ErikBachmann
::SET $VERSION=2015-03-27&SET $REVISION=09:23:00&SET $COMMENT=Deprecated: Use Where / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1


:: Test if Windows own "Where" is available
IF EXIST "%SystemRoot%\System32\where.exe" ECHO:%~f0 is deprecated - use "%SystemRoot%\System32\where.exe"&WHERE %*&GOTO :EOF

CALL _Debug
CALL _GetOpt %*

:which name
    ::FOR %%i IN (%~1) DO @ECHO: %%~$PATH:i
    FOR %%i IN (!@%$NAME%.1!) DO @ECHO: %%~$PATH:i
GOTO :EOF

::*** End of File ******************************************************