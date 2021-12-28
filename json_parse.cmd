@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Parsing a JSON and convert to DOS environment variables
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
::@(#)      %$NAME% input
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#) Convert JSON keys and values to __ prefixed DOS enviroment variables
::@(#) Can nest multilevel values using KEY_ prefix so "{ key1:{ key2:value .. will have the key: "__key1_key2"
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  If the file normal.json contains:
::@(#)      {"solo":"Solo value","system":{"name":"ByteMARC","version":"04.21","favicon":"./images/favicon.ico","language":{"name":"Danish","code":"da"}},"cluster":{"name":"Default","path":".databases/"},"database":{"name":"Erik III","file":"ebp3.db","path":".databases/"},"single":"Single value"}
::@(#) 
::@(#)  Calling
::@(#)      ECHO :: Parse JSON
::@(#)      CALL json_parse "normal.json"
::@(#)      ECHO :: Parsed JSON
::@(#)      set __
::@(#) 
::@(#)  Will produce:
::@(#)      
::@(#)      :: Parsed JSON
::@(#)      __cluster_name=Default
::@(#)      __cluster_path=.databases/
::@(#)      __database_file=ebp3.db
::@(#)      __database_name=Erik III
::@(#)      __database_path=.databases/
::@(#)      __single=Single value
::@(#)      __solo=Solo value
::@(#)      __system language_code=da
::@(#)      __system language_name=Danish
::@(#)      __system_favicon=./images/favicon.ico
::@(#)      __system_name=ByteMARC
::@(#)      __system_version=04.21
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
  SET $VERSION=2021-12-26&SET $REVISION=22:44:27&SET $COMMENT=Initial/ErikBachmann
::**********************************************************************
::@(#){COPY}%$VERSION:~0,4% %$Author%
::**********************************************************************
ENDLOCAL

:MAIN
    CALL "%~dp0\_debug"
    :: Initiating global environment
    ::CALL "%~dp0\_PreScript" %* || (CALL %~dp0\_PostScript & EXIT /B 1 )
    ::CALL "%~dp0\_prefunction" %* || ECHO AUCH

REM ENDLOCAL
::SET _DEBUG_=ECHO:%~n0 

:json_parse
    %_DEBUG_% :json_parse
    SET $PREFIX=
    %_DEBUG_% :: Read JSON file line by line: "%~1"
    for /F "usebackq delims=" %%L in ( "%~1" ) do (
        REM :: Store current line string:
        set "LINE=%%L"
        setlocal EnableDelayedExpansion
        REM :: Replace key/value separator `": "` by `":"` (remove space):
        set "LINE=!LINE:": "=":"!"
        REM :: BUGFIX: replace separator on numeric values: x: 123
        set "LINE=!LINE:": =":!"
        REM :: BUGFIX: replace separator on numeric values: x: 123
        set "LINE=!LINE:{={ !"
        set "LINE=!LINE:}= } !"

        %_DEBUG_%  "line!LINE!"
        REM :: Trim off opening and closing braces `{`/`}`:
        if defined LINE if "!LINE:~,1!"=="{" set "LINE=!LINE:~1!"
        REM ::echo "line!LINE!"
        if defined LINE if "!LINE:~-1!"=="}" set "LINE=!LINE:~,-1!"
        %_DEBUG_%  "line!LINE!"
        REM :: Iterate through key/value pairs (separated by `, `):
        for %%P in (!LINE!) do (
            endlocal
            %_DEBUG_%  P:[%%P]
            %_DEBUG_%  
            REM :: Split key/value pair:
            for /F "tokens=1* delims=: eol=:" %%Q in ("%%P") do (
                %_DEBUG_% P[%%P]     Q[%%Q]R[%%R]
                IF "." == ".%%~R" (
                    IF ".}" EQU ".%%~Q" (
                        CALL List_POP $PREFIX DUMMY
                        %_DEBUG_%  PREFIX END[!$PREFIX!]
                    )
                ) ELSE (
                    IF ".{" EQU ".%%~R" (
                        %_DEBUG_%  start paragraph [%%~Q]
                        CALL List_push $PREFIX "%%~Q"
                        REM ::CALL List_push $PREFIX "!Q!"
                        %_DEBUG_%  PREFIX START[!$PREFIX!]
                    ) ELSE (
                        %_DEBUG_%  "[%%~Q]=[%%~R]"
                        REM :: Trim Left - Trim spaces from the beginning of a string via "FOR" command
                        FOR /f "tokens=* delims= " %%a IN ("!$PREFIX!") DO CALL SET $PREFIX=%%a
                        
                        IF "." == ".!$PREFIX!" (
                            ENDLOCAL
                            CALL SET __%%~Q=%%~R
                            SETLOCAL EnableDelayedExpansion
                        ) ELSE (
                            ENDLOCAL
                            CALL SET __!$PREFIX!_%%~Q=%%~R
                            SETLOCAL EnableDelayedExpansion
                        )

                    )
                )
                REM SET __
            )
            REM ::setlocal EnableDelayedExpansion
        )
        REM ::endlocal
    )
GOTO :EOF

::*** End of File ******************************************************
