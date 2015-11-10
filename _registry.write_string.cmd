@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::*********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Write an entry to the registration database
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
::@(#)  %$NAME% "Path" "key" "value"
::@(#) 
::@#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  %$NAME% writes a new key with the given value to the registration database:
::@(#) 
::@(#)      CALL %$NAME% "HKEY_LOCAL_MACHINE\SOFTWARE\ClicketyClick.dk\%$NAME%" "Status" "OK"
::@(#) 
::@(#)  Note: Patterns are case insensitive
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
::@(#)  _registry.delete_string.cmd     _registry.delete_key.cmd
::@(#)  _registry.read_string.cmd       _registry.list.cmd
::@(#)
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init Description/Initials [xx.xxx]
::SET $VERSION=2010-07-26&SET $REVISION=11:01:00&SET $COMMENT=Initial/ErikBachmann [01.000]
::SET $VERSION=2010-10-20&SET $REVISION=17:15:00&SET $COMMENT=Addding $Source/ErikBachmann [01.001]
::SET $VERSION=2014-01-03&SET $REVISION=09:21:00&SET $COMMENT=Exact path to reg.exe/ErikBachmann [01.002]
::SET $VERSION=2015-02-19&SET $REVISION=03:34:42&SET $COMMENT=Autoupdate / ErikBachmann
::SET $VERSION=2015-10-08&SET $REVISION=09:00:00&SET $COMMENT=Doc: Requires write access to registry [admin rights] / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
ENDLOCAL

:: %DEBUG% Writting status as running (-1)
:: CALL _registry.write_string "HKEY_LOCAL_MACHINE\SOFTWARE\DBC\DBCDrift\%$NAME%" "LatestStart" "%UTC%"

:: CALL _registry.write_string "HKEY_LOCAL_MACHINE\SOFTWARE\ClicketyClick.dk\%$NAME%" "Status" "-1"
:: CALL _registry.read_string  "HKEY_LOCAL_MACHINE\SOFTWARE\ClicketyClick.dk\%$NAME%" "Status"

"%WinDir%\system32\REG.exe" ADD "%~1" /f /v "%~2" /t REG_EXPAND_SZ /d "%~3" >nul 2>&1

::*** End of File ******************************************************