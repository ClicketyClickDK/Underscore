@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Get parent directory to a given directory
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
::@(#)      %$NAME% [VAR] {dir}
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)  VAR     Name of variable to return value in
::@(#)  DIR     A given directory
::@(#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#) 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      CALL %$NAME% XX "C:\Windows\system32\"
::@(#)      SET XX
::@(#)  Will display:
::@(#)      XX=C:\Windows
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
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm&SET $COMMENT=Description/init
::SET $VERSION=2015-02-19&SET $REVISION=00:00:00&SET $COMMENT=Initial/ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
::ENDLOCAL

::setlocal enableextensions,enabledelayedexpansion

:init
:: Arg: VAR dir
    SET CDIR=%~2
    IF NOT DEFINED CDIR SET CDIR=%CD%

    SET CDIR=%CDIR:\=,%
    SET CDIR=%CDIR: =¤%
    SET PRI=
    SET ANAME=
    SET CNAME=
    IF DEFINED DEBUG echo [%cdir%]

:Process    
    FOR %%a IN (%CDIR%) DO CALL :SetCname "%%a"

    ::SET CNAME=%CNAME:_= %
    SET CNAME=%CNAME:¤= %
    SET ANAME=%ANAME:¤= %
    SET CDIR=%CDIR:¤= %

    IF DEFINED DEBUG (
    echo Cur  %CDIR:,=\%
    echo Prev %ANAME%
    echo Diff %CNAME%
    )
    ::set _
    @ENDLOCAL&SET %1=%ANAME%
GOTO :EOF

:SetCname
    IF DEFINED DEBUG ECHO - [%~1]

    IF DEFINED ANAME (
        IF DEFINED CNAME SET "ANAME=%ANAME%\%CNAME%"
        CALL SET "CNAME=%~1"
    ) ELSE (
        SET "ANAME=%~1"
        CALL SET "CNAME="
    )

GOTO :EOF

::*** End of File *****************************************************