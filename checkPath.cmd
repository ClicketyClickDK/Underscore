@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::*********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=List or test/add directory to environment PATH
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
::@(#)  %$NAME% 
::@(#)  %$NAME% "dir"
::@(#)  %$NAME% -add:"dir"
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  "dir"       The path that should be tested in PATH
::@(#)  -add:"dir"  The path that should be appended to PATH if not found
::@(#)  
::@(#)DESCRIPTION
::@(#)  The bare command will list each element in PATH
::@(#)  Given an argument, this is tested against PATH - and appended to PATH
::@(#) 
::@(#)EXAMPLES:
::@(#)  ::List current elements
::@(#)  CALL %$NAME%
::@(#)    
::@(#)      "C:\Windows\system32"
::@(#)      "C:\Windows"
::@(#)    
::@(#)  :: Check a specific path
::@(#)  CALL %$NAME% "C:\Windows"
::@(#)  
::@(#)      "C:\Windows" exists in PATH
::@(#)  
::@(#)  :: Adding an existing path
::@(#)  CALL %$NAME% -add:"C:\Windows"
::@(#)  
::@(#)      "C:\Windows" exists in PATH
::@(#)  
::@(#)  :: Adding an new path
::@(#)  CALL %$NAME% -add:"C:\msdos\"
::@(#)  
::@(#)      Appending [C:\msdos\]
::@(#)  
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  
::@ (#)EXIT STATUS
::@ (-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)  0   OK
::@ (#)  1   Usage (or error)
::@ (#)  
::@ (#)ENVIRONMENT
::@ (-)  Variables affected
::@ (#) 
::@ (#)BUGS / KNOWN PROBLEMS
::@ (-)  If any known
::@ (#)  
::@(#)REQUIRES
::@(-)  Dependencies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  _getopt.cmd     Parse command line options and create environment vars
::@(#) 
::@(#)REFERENCES:
::@(#) URL: http://stackoverflow.com/questions/141344/how-to-check-if-directory-exists-in-path
::@(#) Please note that this implementation assumes no semicolons or quotes are present inside a single path item.
::@(#) should even deal with  ++ in the path environment variable (as in Notepad++).
::@(#)  
::@(#)SOURCE
::@(#)  %$Source%
::----------------------------------------------------------------------
::History
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm:ss&SET COMMENT=Init/Description
  SET $VERSION=2016-07-07&SET $REVISION=14:30:00&SET $COMMENT=Initial / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

CALL "%~dp0\_debug"
CALL "%~dp0\_getopt" %*

:Init
    SET _EXISTS=
    :: Get single name
    IF DEFINED @%$NAME%.1 SET _DIR=!@%$NAME%.1!!
    :: Get name to add
    IF DEFINED @%$NAME%.add SET _DIR=!@%$NAME%.add!!&SET _APPEND=!@%$NAME%.add!!
    :: Remove quotes
    IF DEFINED _DIR SET _DIR=%_DIR:"=%

:Process
    IF DEFINED _DIR (    REM If argument
        REM :: Check for match in path
        @for %%P in ("%path:;=";"%") do (   REM For each element
            @if /i %%P=="%_DIR%" (          REM If matching new dir
                echo %%P exists in PATH
                SET _EXISTS=1
            )
        )

        IF NOT DEFINED _EXISTS (            REM If dir is not in path
            IF DEFINED _APPEND (            REM AND append flag
                ECHO Appending [%_DIR%]
                ENDLOCAL&CALL SET "PATH=%PATH%;%_DIR%;"
            )
        )
    ) ELSE (    REM :: Listing elements in PATH
        FOR %%P IN ("%PATH:;=";"%") DO IF NOT "!"=="!%%~P" ECHO %%P
    )

::*** End of File *****************************************************