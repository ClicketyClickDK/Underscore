@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Activate Windows inputbox for getting text string
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
::@(#)      %$NAME% [VAR]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#) 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#) 
::@(#) :: This file MUST be stored in the local Code Page
::@(#) ::             VAR  Default            Title       text     Return default
::@(#) CALL inputbox "ReturnVar" "Hvad vil du vide" "Sp›rgsm†l" "Vil du svare p† dette?{CrLf}HUSK: Danske tegn skal v‘re gemt i CP-865" "-"
::@(#) ECHO Svaret er=[%ReturnVar%]
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
  SET $VERSION=2021-11-10&SET $REVISION=15:49:20&SET $COMMENT=Initial/ErikBachmann
::**********************************************************************
::@(#){COPY}%$VERSION:~0,4% %$Author%
::**********************************************************************
::ENDLOCAL

:MAIN
    CALL "%~dp0\_DEBUG"
    ::CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
    :: Check ONLY for combinations of -h, /h, --help
    CALL "%~dp0\_getopt.sub" %*&IF ERRORLEVEL 1 EXIT /B 1

    :: Initiating Local environmen
    ::CALL :Init %*

:inputBox
    ::SETLOCAL
    :: Return variable
    SET _RETURN=%~1
    IF NOT DEFINED _RETURN SET _RETURN=$RETURN
    :: Input text
    SET _INPUT=%~2
    IF NOT DEFINED _INPUT SET _INPUT=?input?
    ::Window title
    SET _TITLE=%~3
    IF NOT DEFINED _TITLE SET _TITLE=?title?
    :: Body
    SET _MSG=%~4
    IF NOT DEFINED _MSG SET _MSG=?What?
    :: Default to return on error / cancel
    SET _DEFAULT=%~5
    IF NOT DEFINED _DEFAULT SET _DEFAULT=XXX
    ::ECHO "%_DEFAULT%"
    SET _CMD=CALL _inputBox "%_TITLE%" "%_MSG%" "%_INPUT%" "%_DEFAULT%"
    FOR /F "tokens=* delims=" %%a IN ('CALL %_CMD%') DO SET _VAR=%%a
    :: Return default on cancel
    IF NOT DEFINED _VAR SET _VAR=%_DEFAULT%
    :: Returning input
    ENDLOCAL&SET %_RETURN%=%_VAR%
GOTO :EOF

::*** End of File ******************************************************