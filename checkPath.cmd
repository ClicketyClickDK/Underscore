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
::@(#)  %$NAME% -check:"dir"
::@(#)  %$NAME% -add:"dir"
::@(#)  %$NAME% -del:"dir"
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -check:"dir"    The dir that should be tested in PATH
::@(#)  -add:"dir"      The dir that should be appended to PATH if not found
::@(#)  -del:"dir"      The dir that should be removed from PATH if found
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
::@(#)  :: Check a specific dir in path
::@(#)  CALL %$NAME% -check:"C:\Windows"
::@(#)  
::@(#)      "C:\Windows" exists in PATH
::@(#)  
::@(#)  :: Adding an existing dir to path
::@(#)  CALL %$NAME% -add:"C:\Windows"
::@(#)  
::@(#)      "C:\Windows" exists in PATH
::@(#)  
::@(#)  :: Adding an new dir to path
::@(#)  CALL %$NAME% -add:"C:\msdos\"
::@(#)  
::@(#)      Appending [C:\msdos\]
::@(#)  
::@(#)  :: Removing and existing dir from path
::@(#)  CALL %$NAME% -del:"C:\msdos\"
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
  SET $VERSION=2017-01-11&SET $REVISION=10:00:00&SET $COMMENT=Adding delete / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************
CALL "%~dp0\_debug"
CALL "%~dp0\_getopt" %*

:Init
    SET _EXISTS=
    SET _STATUS=0
    :: Get single name
    IF DEFINED @%$NAME%.1 SET _DIR=!@%$NAME%.1!!
    :: Get name to add
    IF DEFINED @%$NAME%.check SET _DIR=!@%$NAME%.check!!
    ::&SET _APPEND=!@%$NAME%.add!!
    IF DEFINED @%$NAME%.add SET _DIR=!@%$NAME%.add!!&SET _APPEND=!@%$NAME%.add!!
    IF DEFINED @%$NAME%.del SET _DIR=!@%$NAME%.del!!&SET _DELETE=!@%$NAME%.del!!
    :: Remove quotes
    IF DEFINED _DIR SET _DIR=%_DIR:"=%

:Process
    IF DEFINED _DIR (    REM If argument
        REM :: Check for match in path
        @FOR %%P IN ("%path:;=";"%") DO (   REM For each element
            @IF /i %%P=="%_DIR%" (          REM If matching new dir
                ECHO %%P EXISTS IN PATH
                CALL SET "_EXISTS=1"
            )
        )

        IF NOT DEFINED _EXISTS (            REM If dir is not in path
            %_DEBUG_% NOT EXISTING
            IF DEFINED _APPEND (            REM AND append flag
                ECHO Appending [%_DIR%] to PATH
                rem ENDLOCAL&
                CALL SET "PATH=%PATH%;%_DIR%;"
            ) ELSE (
                ECHO Not found [%_DIR%] in PATH
                SET _Status=1
            )
        ) ELSE (
            %_DEBUG_% EXISTING
            IF DEFINED _DELETE (            REM AND append flag
                ECHO Deleting [%_DIR%] from PATH
                :: remove from path - trailing \ is optional
                CALL SET "PATH=!PATH:%_DIR%\;=!"
                CALL SET "PATH=!PATH:%_DIR%;=!"
                rem ENDLOCAL&CALL SET "PATH=%PATH%;%_DIR%;"
                rem ENDLOCAL&CALL SET "PATH=!PATH!"
            )
        )
    ) ELSE (    REM :: Listing elements in PATH
        FOR %%P IN ("%PATH:;=";"%") DO IF NOT "!"=="!%%~P" ECHO %%P
    )
ENDLOCAL&CALL SET "PATH=%PATH%"
SET PATH=%PATH:;;=;%
%_DEBUG_% %PATH%
EXIT /B %_STATUS%
::*** End of File *****************************************************