@echo off
setlocal DisableDelayedExpansion
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Merge two file column by column
SET $AUTHOR=foxidrive
SET $SOURCE=%~f0 
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)      %$NAME% [InputFile1] [InputFile2] [OutputFile]
::@(#) 
::@ (#)OPTIONS
::@ (-)  Flags, parameters, arguments (NOT the Monty Python way)
::@ (#)  -h      Help page
::@ (#) n   Number of lines to print, default=10 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Merging to files line by line 
::@(#) 
::@ (#)EXAMPLES
::@ (-)  Some examples of common usage.
::@(#)  Given the two files 1.txt and 2.txt: 
::@(#)  
::@(#)  1.txt
::@(#)  1
::@(#)  2
::@(#)  3
::@(#)  4
::@(#)  
::@(#)  2.txt
::@(#)  a
::@(#)  b
::@(#)  c
::@(#)  d
::@(#)  
::@(#)  Merging using the command: %$NAME% 1.txt 2.txt output
::@(#)  Will merge the two files into:
::@(#)  
::@(#)  output.txt
::@(#)  1 a
::@(#)  2 b
::@(#)  3 c
::@(#)  4 d
::@(#)  
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
::@ (#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@ (#)
::@ (#)
::@(#)REQUIRES
::@(-)  Dependecies
::@ (#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@ (#)  _GetOpt.cmd     Parse command line options and create environment vars
::@(#)  "%~dp0\Geotag.config.cmd"
::@(#)  "%~dp0\_\merge.cmd"
::@(#)  
::@ (#)SEE ALSO
::@ (-)  A list of related commands or functions.
::@ (#)
::@ (#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author: http://www.dostips.com/forum/viewtopic.php?t=4650
::@ (#)  URL: foxidrive
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
  SET $VERSION=2016-03-23&SET $REVISION=08:30:00&SET $COMMENT=init / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::********************************************************************** 

REM :MAIN

< "%~2" (
    FOR /F "delims=" %%a IN ('TYPE "%~1"') DO (
        :: Clear env var
        SET file2Line=
        :: Read line from stdin (File 2)
        SET /P file2Line=
        :: Read line from file 1
        SET "file1Line=%%a"
        SETLOCAL EnableDelayedExpansion   
            ECHO:!file1Line! !file2Line!
        ENDLOCAL
    )
) >%~3

GOTO :EOF

::*** End of File *****************************************************