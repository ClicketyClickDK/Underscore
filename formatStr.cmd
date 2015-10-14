@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=outputs columns of strings right or left aligned
SET $AUTHOR=http://www.dostips.com
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)      %$NAME% [Format] strX strY....
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Writes formatted string to the standard output. 
::@(#)  The argument are formatted under control of the format string.
::@(#)  The format string holds the operands to be replaced with the 
::@(#)  stings subsequently following the format string.
::@(#)  The operand is a length surrounded by curled parentheses like {10}.
::@(#)  If the length is less than zero, the string inserted will be aligned
::@(#)  to the right.
::@(#)  
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      CALL %$NAME% "{20}[{10}]" "Label" "Hello world"
::@(#)  Will show
::@(#)      Label               [Hello worl]
::@(#) 
::@(#)  formatStr "[{10}][{-10}][{10}]" a spacy example
::@(#)  [a         ][     spacy][example   ]
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
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  
::@ (#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@(#)  URL: http://www.dostips.com/{QUEST}t=Function.Format
::@(#) 
::@(#)  Please note: 
::@(#)  This function has the following differences from the DosTips "Format":
::@(#)  1) Name changed to FormatStr due to similarity to the DOS format 
::@(#)      [You do NOT want to confuse these commands].
::@(#)  2) "ECHO." changed to "ECHO:" since the "." sometimes fails under Windows 7+
::@(#)  2) Tags are changed from [] to {} since [] are useful in formatted strings
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
::SET $VERSION=2015-02-19&SET $REVISION=16:00:00&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

:Format fmt str1 str2 ... -- outputs columns of strings right or left aligned
::                        -- fmt [in] - format string specifying column width and alignment, i.e. "[-10][10][10]"
:$created 20060101 :$changed 20091130 :$categories Echo
:$source http://www.dostips.com
    SETLOCAL
    SET "fmt=%~1"
    SET "line="
    SET "spac=                                                     "
    SET "i=1"
    FOR /F "tokens=1,2 delims={" %%a IN ('"ECHO:.%fmt:}=&echo:.%"') DO (
        SET /A i+=1
        CALL CALL SET "subst=%%%%~%%i%%%spac%%%%%~%%i%%"
        IF %%b0 GEQ 0 (CALL SET "subst=%%subst:~0,%%b%%"
        ) ELSE        (CALL SET "subst=%%subst:~%%b%%")
        CALL SET "const=%%a"
        CALL SET "line=%%line%%%%const:~1%%%%subst%%"
    )
    ECHO:%line%
GOTO :EOF

::*** End of File *****************************************************