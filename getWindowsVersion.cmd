@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
SET $NAME=%~n0
SET $DESCRIPTION=Reading Windows version info from registry database
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
::@(#)      CALL %$NAME%
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Reads Microsoft Window registry entries for Product Name,
::@(#)  Verision, Build, CSD [Service Pack] and Installation Type
::@(#)  Verbose the full name and set the following env vars:
::@(#)      #HKEY_LOCAL_MACHINE.CSDVersion=Service Pack 1
::@(#)      #HKEY_LOCAL_MACHINE.CurrentBuild=7601
::@(#)      #HKEY_LOCAL_MACHINE.CurrentVersion=6.1
::@(#)      #HKEY_LOCAL_MACHINE.InstallationType=Client
::@(#)      #HKEY_LOCAL_MACHINE.ProductName=Windows 7 Professional
::@(#)
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  CALL WindowsVersion.cmd
::@(#)
::@(#)  Windows 7 Professional, Service Pack 1 [v. 6.1 Build. 7601] Client
::@(#)  
::@(#)  set #
::@(#)  #HKEY_LOCAL_MACHINE.CSDVersion=Service Pack 1
::@(#)  #HKEY_LOCAL_MACHINE.CurrentBuild=7601
::@(#)  #HKEY_LOCAL_MACHINE.CurrentVersion=6.1
::@(#)  #HKEY_LOCAL_MACHINE.InstallationType=Client
::@(#)  #HKEY_LOCAL_MACHINE.ProductName=Windows 7 Professional
::@(#)      
::@(#)LIMITATIONS
::@(#)  The ProcessBarMarker CANNOT be a digit due to redirection rules in 
::@(#)  DOS [Default=@]
::@(#)  Avoid other special characters like ampersand or pipe
::@(#) 
::@(#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@(#)  Exit status is 0 if any matches were found, otherwise 1.
::@(#) 
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
::@ (#)REQUIRES
::@(-)  Dependencies
::@ (#)
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#)  _registry.read_string
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
::SET $VERSION=2008-09-04&SET $REVISION=12:04:16&SET $COMMENT= [01.200]
::SET $VERSION=2010-10-14&SET $REVISION=14:27:00&SET $COMMENT=Initial/ErikBachmann [01.000]
::SET $VERSION=2010-10-20&SET $REVISION=17:15:00&SET $COMMENT=Addding $Source/ErikBachmann [01.001]
::SET $VERSION=2014-01-07&SET $REVISION=17:27:00&SET $COMMENT=Reading from reg/ErikBachmann [01.010]
::SET $VERSION=2015-02-19&SET $REVISION=03:01:53&SET $COMMENT=Autoupdate / ErikBachmann
::SET $VERSION=2015-03-23&SET $REVISION=10:35:00&SET $COMMENT=Fixed return variable: %~n0 / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

ENDLOCAL

:INIT
    ::SETLOCAL
    IF NOT DEFINED $NAME SET $NAME=HKEY_LOCAL_MACHINE

:MAIN

    CALL _GetOpt %*
    CALL _Debug

    SET $WINVERNAME=UNKNOWN
    SET $WINVERNO=UNKNOWN

    SET _R_=_registry.read_string.cmd  "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion"

    CALL %_R_% "ProductName"
    CALL %_R_% "CurrentVersion"
    CALL %_R_% "CurrentBuild"
    CALL %_R_% "CSDVersion"
    CALL %_R_% "InstallationType"

    CALL SET getWindowsVersion=%%#%$NAME%.ProductName%%, !#%$NAME%.CSDVersion! [v. %%#%$NAME%.CurrentVersion%% Build. %%#%$NAME%.CurrentBuild%%] %%#%$NAME%.InstallationType%%
    CALL %_VERBOSE_% %getWindowsVersion%
    ::ENDLOCAL&CALL SET %~n0=%getWindowsVersion%
    ::EndLocal&CALL SET #%$NAME%.ProductName=%%#%$NAME%.ProductName%%
    ::%%#%$NAME%.ProductName%%, !#%$NAME%.CSDVersion! [v. %%#%$NAME%.CurrentVersion%% Build. %%#%$NAME%.CurrentBuild%%] %%#%$NAME%.InstallationType%%
GOTO :EOF

::*** End of File ******************************************************