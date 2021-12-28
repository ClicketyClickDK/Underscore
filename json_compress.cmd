@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Compress JSON to one line
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
::@(#)      %$NAME% input output {json_compressed} {json_raw}
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#) Remove line feed, and white space from JSON to save space
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  If the file normal.json contains:
::@(#)      {"solo":"Solo value","system":{"name":"ByteMARC","version":"04.21","favicon":"./images/favicon.ico","language":{"name":"Danish","code":"da"}},"cluster":{"name":"Default","path":".databases/"},"database":{"name":"Erik III","file":"ebp3.db","path":".databases/"},"single":"Single value"}
::@(#) 
::@(#)  Calling
::@(#)      ECHO::: Pretty Print JSON
::@(#)      CALL json_prettyprint "normal.json" "    "
::@(#) 
::@(#)  Will produce:
::@(#)      {
::@(#)          "solo": "Solo value",
::@(#)          "system": {
::@(#)              "name": "ByteMARC",
::@(#)              "favicon": "./images/favicon.ico",
::@(#)              "language": {
::@(#)                  "name": "Danish",
::@(#)                  "code": "da"
::@(#)              }
::@(#)          },
::@(#)          "cluster": {
::@(#)              "name": "Default",
::@(#)              "path": ".databases/"
::@(#)          },
::@(#)          "single": "Single value"
::@(#)      }
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
::@(#) _Prescript.cmd
::@(#) _PostScript.cmd
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Description/init
  SET $VERSION=2021-12-26&SET $REVISION=22:31:03&SET $COMMENT=Initial/ErikBachmann
::**********************************************************************
::@(#){COPY}%$VERSION:~0,4% %$Author%
::**********************************************************************

:MAIN
    :: Initiating global environment
    ::CALL "%~dp0\_PreScript" %* || (CALL %~dp0\_PostScript & EXIT /B 1 )
    CALL "%~dp0\_prefunction" %* || ECHO AUCH


ENDLOCAL
:json_compress input output {json_compressed} {json_raw}
    SETLOCAL EnableDelayedExpansion
    SET JSON=.
    SET JSON_raw=.
    for /f "delims== tokens=*" %%G in (%~1) do (
        :: Trim Left - Trim spaces from the beginning of a string via "FOR" command
        CALL SET "$STR=%%~G"
        CALL SET "json_raw=!json_raw!\n%%~G"
        FOR /f "tokens=* delims= " %%a IN ("!$str!") DO CALL SET $str=%%a

        CALL SET json=!json! !$str!
    )
    SET JSON=%json:~2%

    %_DEBUG_% :::Store compressed JSON in "%~2"
    ECHO %json%>%2

    IF "." NEQ ".%~4" (
        %_DEBUG_% :::Setting variable [%~3] to compressed JSON
        ENDLOCAL&CALL SET "%3=%json%"&CALL SET "%4=%json_raw%"
    ) ELSE (
        IF "." NEQ ".%~3" (
            %_DEBUG_% :::Setting variable [%~3] to compressed JSON
            ENDLOCAL&CALL SET "%3=%json%"
        ) ELSE (
            ECHO ***%~nx0 says: HEY! Where am I gonna put the JSON? No return variable.
        )
    )
GOTO :EOF

::*** End of File ******************************************************
