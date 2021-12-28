@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Examples for module json_edit.bat
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
::@(#)      %$NAME%
::@(#) 
::@ (#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@ (#)  -h      Help page
::@ (#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Examples for how to edit various parts of a JSON 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@ (#) 
::@ (#) 
::@ (#) 
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
::@(#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@(#) All values will be treated as strings
::@(#)
::@(#)REQUIRES
::@(-)  Dependecies
::@(#) 
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#) json_compress.cmd, json_prettyprint.cmd, json_parse.cmd  
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
::SET $VERSION=2015-02-19&SET $REVISION=00:00:00&SET $COMMENT=Initial/ErikBachmann
  SET $VERSION=2016-03-14&SET $REVISION=10:00:00&SET $COMMENT=Set "%~dp0\ prefix on function calls / ErikBachmann
::**********************************************************************
::@(#){COPY}%$VERSION:~0,4% %$Author%
::**********************************************************************
::ENDLOCAL

ECHO:%$NAME% v. %$VERSION%&ECHO:%$description%&ECHO:

:: Set data file
SET JSON="%~dp0\testdata\normal.json"
:: Set edit script
SET JSON_edit="%~dp0\..\json_edit.bat"

ECHO Calling: %JSON_edit% %json%

ECHO:Normal JSON:
type %JSON%
::{ "solo": "Solo value", "level1": { "name": "Name1", "version": "04.21", "level2": { "name": "Name2", "code": "da" } }, "single": "Single value" }
ECHO:
ECHO:Edit: solo=simple solo
CALL %JSON_edit% %JSON% solo "simple solo"
::{"solo":"simple solo","level1":{"name":"Name1","version":"04.21","level2":{"name":"Name2","code":"da"}},"single":"Single value"}
ECHO:         ^^^^^^^^^^^^^^^^^^^^^^
::ECHO:
ECHO:Edit: level1.name=name of level1
CALL %JSON_edit% %JSON% level1.name "name of level1"
::{"solo":"Solo value","level1":{"name":"name of level1","version":"04.21","level2":{"name":"Name2","code":"da"}},"single":"Single value"}
ECHO:                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
::ECHO:
ECHO:Edit: level1.level2.name=name of level 2
CALL %JSON_edit% %JSON% level1.level2.name "name of level 2"
::{"solo":"Solo value","level1":{"name":"Name1","version":"04.21","level2":{"name":"name of level 2","code":"da"}},"single":"Single value"}
ECHO:                                                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
