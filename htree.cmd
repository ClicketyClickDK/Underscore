@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Graphically displays the folder structure of a drive or path in HTML
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
::@(#)  %$Name% [drive:][path] [/F] [/A] [^>html_tree.html] [2^>ascii_tree.txt]
::@(#) 
::@(#)  /F   Display the names of the files in each folder.
::@(#)  /A   Use ASCII instead of extended characters. (NO HTML)
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Uses the DOS command TREE and convert the tree structure to HTML
::@(#) 
::@(#)OUTPUT
::@(#) STDOUT(1)    HTML version of tree
::@(#) STDERR(2)    TEXT (ASCII/Extended) version
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  hTree {GT}html_tree.html 2{GT}ascii_tree.txt
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
::@ (#)REQUIRES
::@(-)  Dependencies
::@ (#)  
::@ (#)
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init / Description [xx.xxx]
::SET $VERSION=2009-04-17&SET $REVISION=11:01:00&SET $COMMENT=ErikBachmann / Initial [00.000]
::SET $VERSION=2011-10-12&SET $REVISION=14:34:00&SET $COMMENT=ErikBachmann / Initial [01.001]
::SET $VERSION=2015-02-19&SET $REVISION=03:04:07&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1


:HTREE.main
    :: Header
    ECHO ^<pre^>
    SET _Path=%* .
    ::set _Path
    ::IF "\"=="%_Path:~-1%" SET _Path=%_Path:~0,-1%
    SET _Path=%_Path:\ = %
    ECHO _Path=[%_Path%]

    :: Loop tree
    FOR /F "TOKENS=* DELIMS=¤" %%a IN ('TREE %_Path:~0,-1%') DO (
        SET _=%%a
        :: Replace \---
        SET _=!_:ÀÄÄÄ=^&#9492;^&#9472;^&#9472;^&#9472;!
        :: Replace |---
        SET _=!_:ÃÄÄÄ=^&#9500;^&#9472;^&#9472;^&#9472;!
        :: Replace |
        SET _=!_:³=^&#9474;!
        :: Replace blanks
        SET _=!_: =^&nbsp;!

        :: Replace danish lower case letters æøå
        SET _=!_:‘=^&aelig;!
        SET _=!_:›=^&oslash;!
        SET _=!_:†=^&aring;!

        :: Replace danish UPPER case letters ÆØÅ
        SET _=!_:’=^&AElig;!
        SET _=!_:=^&Oslash;!
        SET _=!_:=^&Aring;!

        :: Print ASCII version to STDERR
        >>&2 ECHO %%a
        :: Print HTML version to STDOUT
        ECHO !_!
    )

    :: Footer
    ECHO ^</pre^>
GOTO :EOF

::*** End of File ******************************************************