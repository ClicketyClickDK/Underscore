@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Parsing a JSON and return a formated, human readable string
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
::@(#)      %$NAME% flags
::@(#)      %$NAME% JSON prefix return {NLtoken}
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)  JSON    Compressed JSON string
::@(#)  prefix  White space string to indent values
::@(#)  return  Variable to hold the pretty print
::@(#)  NLtoken Token to escape new line (Default: ¤)
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
::@(#)      CALL json_prettyprint "normal.json" "    " PP
::@(#)      ECHO :: Parsed JSON
::@(#)      :: Expand embedded New Line (Replace ¤ with new
::@(#)          ::Define LF variable containing a linefeed (0x0A)
::@(#)          SET _LF=^
::@(#)
::@(#)
::@(#)          ::Above 2 blank lines are critical - do not remove
::@(#)      ECHO:%$PP:¤=!_LF!%
::@(#) 
::@(#)  Will produce:
::@(#)      
::@(#)      {
::@(#)          "solo": "Solo value",
::@(#)          "system": {
::@(#)              "name": "ByteMARC",
::@(#)              "version": "04.21",
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
::@(#)          "database": {
::@(#)              "name": "Erik III",
::@(#)              "file": "ebp3.db",
::@(#)              "path": ".databases/"
::@(#)          },
::@(#)          "single": "Single value"
::@(#)      }
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
  SET $VERSION=2021-12-28&SET $REVISION=10:48:10&SET $COMMENT=Initial/ErikBachmann
::**********************************************************************
::@(#){COPY}%$VERSION:~0,4% %$Author%
::**********************************************************************
::ENDLOCAL

:MAIN
    CALL "%~dp0\_debug"
    :: Initiating global environment
    CALL "%~dp0\_PreScript" %* || (CALL %~dp0\_PostScript & EXIT /B 1 )
    ::CALL "%~dp0\_prefunction" %* || ECHO AUCH

REM ENDLOCAL
::SET _DEBUG_=ECHO:%~n0 

:json_prettyprint JSON prefix PrettyPrint {NewLineToken}
    SET "$PREFIX=%~2"
    ::ECHO [%$PREFIX%]
    SET $count=1
    SET $PREV={
    SET $SEP= 
    SET $JSON={
    SET $LF=%~4
    IF NOT DEFINED $LF SET $LF=¤

    %_DEBUG_%  :: Read JSON file line by line: "%~1"
    for /F "usebackq delims=" %%L in ("%~1") do (
        rem :: Store current line string:
        set "LINE=%%L"
        setlocal EnableDelayedExpansion
        rem :: Replace key/value separator `": "` by `":"` (remove space):
        set "LINE=!LINE:": "=":"!"
        :: BUGFIX: replace separator on numeric values: x: 123
        set "LINE=!LINE:": =":!"
        :: BUGFIX: replace separator on numeric values: x: 123
        set "LINE=!LINE:{={ !"
        set "LINE=!LINE:}= } !"

        %_DEBUG_% ::"line!LINE!"
        rem :: Iterate through key/value pairs (separated by `, `):
        for %%P in (!LINE!) do (
            endlocal
            CALL SET $SEP= 

            %_DEBUG_% :: P:[%%P]
            rem :: Split key/value pair:
            for /F "tokens=1* delims=: eol=:" %%Q in ("%%P") do (
                CALL SET $SEP=
                %_DEBUG_% ::  P[%%P] Q[%%Q]  R[%%R]  S[%%S]
                IF /I "{" NEQ "!$PREV!" CALL SET $SEP=,
                IF "." == ".%%~R" (
                    IF ".}" EQU ".%%~Q" (
                        SET /A $count-=1
                        CALL str_repeat "%$PREFIX%" "!$count!"
                        CALL SET "$JSON=!$JSON!%$LF%!str_repeat!}"
                        CALL SET "$PREV=}"
                    )
                ) ELSE (
                    IF ".{" EQU ".%%~R" (
                        %_DEBUG_% :: start paragraph [%%~Q]
                        CALL str_repeat "%$PREFIX%" "!$count!"
                        CALL SET "$JSON=!$JSON!!$SEP!%$LF%!str_repeat!"%%~Q": {"
                        %_DEBUG_% :: PREFIX START[!$PREFIX!] [!$count!]
                        CALL SET "$PREV={"
                        SET /A $count+=1
                    ) ELSE (
                        %_DEBUG_% :: "[%%~Q]=[%%~R]"
                        IF /I "{" NEQ "!$PREV!" CALL SET "$JSON=!$JSON!!$SEP!"
                        IF DEFINED verbose ECHO                             prev[!$PREV!]
                        CALL str_repeat "%$PREFIX%" "!$count!"
                        CALL SET "$JSON=!$JSON!%$LF%!str_repeat!"%%~Q": "%%~R""
                        CALL SET "$PREV=%%~R"
                    )
                )
            )
            setlocal EnableDelayedExpansion
        )
        endlocal
    )
    ::echo:%$json:#=!_LF!%
    REM echo:%~0 191 : %$json:¤=!_LF!%
    ENDLOCAL&CALL SET "%~3=%$json%"
    ::SET "REp=%$LF%=%_LF%"
    ::echo:!$json:%rep%!
GOTO :EOF

::----------------------------------------------------------------------
