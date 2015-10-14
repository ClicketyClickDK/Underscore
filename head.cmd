@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::*********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Print the first n lines of a file to STDOUT
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
::@(#)  %$NAME% [File] [n]
::@(#) 
::@(#)  n = Number of lines to print, default=10
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  A function like MORE, but stops output after a given number of lines 
::@(#) 
::@ (#)EXAMPLES
::@(-)  Some examples of common usage.
::@ (#) 
::@ (#) 
::@ (#) 
::@(#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@(#)  0   OK
::@(#)  1   File not found
::@(#)
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
::@(#)  tail.cmd    Print the last n lines of a file to STDOUT
::@(#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@ (#)  URL: 
::@(#) 
::@(#)  URL=http://serverfault.com/questions/490841/how-to-display-the-first-n-lines-of-a-command-output-in-windows-the-equivalent
::@(#)  Example by Ryan Ries
:: netstat -an > temp.txt && for /l %l in (1,1,10) do @for /f "tokens=1,2* delims=:" %a in ('findstr /n /r "^" temp.txt ^| findstr /r "^%l:"') do @echo %b
::@(#) 
::----------------------------------------------------------------------
:: History
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init / Description [xx.xxx]
::SET $VERSION=2014-01-16&SET $REVISION=11:57:00&SET $COMMENT=ErikBachmann / Initial [01.000]
::SET $VERSION=2015-02-19&SET $REVISION=03:03:01&SET $COMMENT=Autoupdate / ErikBachmann
::SET $VERSION=2015-03-30&SET $REVISION=11:21:00&SET $COMMENT=References / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1


IF NOT EXIST "%~1" ECHO Error in "%$SOURCE%": [%~1] not found&EXIT /B 1
SET _lines_wanted=%~2

IF [%_lines_wanted%]==[] SET /A _lines_wanted=10

FOR /L %%l IN (1,1,%_lines_wanted%) DO (
    FOR /f "tokens=1,2* delims=:" %%a IN ('findstr /n /r "^" "%~1" ^| findstr /r "^%%l:"') DO (
        ECHO:%%b
    )
)

::*** End of File *****************************************************