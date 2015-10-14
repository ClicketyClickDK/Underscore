@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Print the last n lines of a file to STDOUT
SET $AUTHOR=Simon Sheppard, ss64.org
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)      %$NAME% [File] [n]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) n   Number of lines to print, default=10 
::@(#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  A function like MORE, but displays only the last given number of lines 
::@(#) 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
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
::@ (#)REQUIRES
::@(-)  Dependencies
::@ (#)  
::@ (#)
::@(#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#)  head.cmd        Print the first n lines of a file to STDOUT    
::@(#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@(#)  URL: http://ss64.org/viewtopic.php?id=506
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
::SET $VERSION=2008-10-18&SET $REVISION=17:45:00&SET $COMMENT=init [01.000]
::SET $VERSION=2015-02-19&SET $REVISION=16:00:00&SET $COMMENT=Autoupdate / ErikBachmann
::SET $VERSION=2015-03-30&SET $REVISION=11:21:00&SET $COMMENT=References / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL


Set tmpFile=%temp%\~tail.txt
IF EXIST %tmpFile% DEL %tmpFile%
Set _lines_wanted=%~2

If [%_lines_wanted%]==[] SET /A _lines_wanted=10
FindStr /r .* "%~1" >%tmpFile%
:: Count all lines in file
For /F "tokens=1 delims=:" %%G in ('findstr /nr ".*" %tmpFile%') Do (Set _num_lines=%%G)
Set /A skip=_num_lines-_lines_wanted
If /I %skip% LEQ 0 Set skip=0

MORE /E +%skip% %tmpFile%
Del %tmpFile%

::*** End of File *****************************************************