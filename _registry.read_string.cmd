@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::*********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Read an entry from the registration database
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
::@(#)  %$NAME% "Path" "key"
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Reads the entries found in the key given as first argument
::@(#) 
::@(#)      CALL %$Name% ^
::@(#)      "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion" ^
::@(#)      "ProgramFilesDir"
::@(#) 
::@(#)  Will read the key and value from the registration database
::@(#)  and create an environment variable: 
::@(#)    #%%$Name%%.ProgramFilesDir
::@(#) 
::@(#)  This environment variable will contain the simple data value
::@(#)  from the registration database
::@(#)  
::@(#)  Note: Patterns are case insensitive
::@(#)
::@(#) 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#) 
::@(#) 
::@(#) 
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@(#)  Exit status is 0 if any matches were found, otherwise 1.
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
::@(#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#)  _registry.delete_string.cmd     _registry.delete_key.cmd
::@(#)  _registry.list.cmd             _registry.write_string.cmd
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
::SET $VERSION=2009-04-17&SET $REVISION=11:01:00&SET $COMMENT=Initial/ErikBachmann [01.000]
::SET $VERSION=2010-10-09&SET $REVISION=13:10:00&SET $COMMENT=Update header and variables/ErikBachmann [01.010]
::SET $VERSION=2010-10-11&SET $REVISION=20:10:00&SET $COMMENT=Update header and variables/ErikBachmann [01.012]
::SET $VERSION=2010-10-20&SET $REVISION=17:15:00&SET $COMMENT=Addding $Source/ErikBachmann [01.013]
::SET $VERSION=2014-01-03&SET $REVISION=09:21:00&SET $COMMENT=Exact path to reg.exe/ErikBachmann [01.002]
::SET $VERSION=2015-02-19&SET $REVISION=03:34:10&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
ENDLOCAL

::    CALL _Debug

    FOR /F "usebackq skip=2 tokens=1,2*" %%C IN (`%WinDir%\system32\REG.exe query "%~1" /v "%~2"`) DO (
        ::%_DEBUG_% --#%$NAME%.%%C=%%E
        CALL SET "#%$NAME%.%%C=%%E"
    )

::*** End of File *****************************************************