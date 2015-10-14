@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Template for DOS batch script
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
::@(#)      %$NAME% [Color] "String"
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@(#) Color attributes are specified by TWO hex digits -- the first
::@(#) corresponds to the background; the second the foreground.  Each digit
::@(#) can be any of the following values:
::@(#) 
::@(#)     0 = Black       8 = Gray
::@(#)     1 = Blue        9 = Light Blue
::@(#)     2 = Green       A = Light Green
::@(#)     3 = Aqua        B = Light Aqua
::@(#)     4 = Red         C = Light Red
::@(#)     5 = Purple      D = Light Purple
::@(#)     6 = Yellow      E = Light Yellow
::@(#)     7 = White       F = Bright White
::@(#) 
::@(#)  If the string ends with a punctuation no newline will be added.
::@(#) 
::@(#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  ECHO with color strings. Since WinDOS does not support writing using colors 
::@(#)  on the command line this does the trick.
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)     CALL %$NAME% 0C "Light red on black without new line."
::@(#)     CALL %$NAME% 0E "Light yellow on black"
::@(#)     CALL %$NAME% 0F "Bright White on black"
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
::@(#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@(#)  For some odd reason, there may be a delay of several seconds, 
::@(#)  if you paste a call to %$NAME% into an open CMD session.
::@(#)
::@ (#)
::@(#)REQUIRES
::@(-)  Dependencies
::@(#)  DEBUG.exe
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
::SET $VERSION=2015-02-19&SET $REVISION=00:00:00&SET $COMMENT=Initial/ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL


call :cecho %*

GOTO :EOF

:cecho col txt -- echoes text in a specific color
::            -- col [in]  - color code, append a DOT to omit line break, call 'color /?' for color codes
::            -- txt [in]  - text output
:$created 20060101 :$changed 20080219 :$categories Echo,Color
:$source http://www.dostips.com
SETLOCAL
for /f "tokens=1,*" %%a in ("%*") do (
    set col=%%a
    set txt=%%~b
)
set cr=Y
if "%col:~-1%"=="." (
    set cr=N
    set col=%col:~0,-1%
)
call:getColorCode "%col%" col
set com=%temp%.\color%col%.com
if not exist "%com%" (
    echo:N %COM%
    echo:A 100
    echo:MOV BL,%col%
    echo:MOV BH,0
    echo:MOV SI,0082
    echo:MOV AL,[SI]
    echo:MOV CX,1
    echo:MOV AH,09
    echo:INT 10
    echo:MOV AH,3
    echo:INT 10
    echo:INC DL
    echo:MOV AH,2
    echo:INT 10
    echo:INC SI
    echo:MOV AL,[SI]
    echo:CMP AL,0D
    echo:JNZ 109
    echo:RET
    echo:
    echo:r cx
    echo:22
    echo:w
    echo:q
)|debug.exe>NUL
"%com%" %txt%

rem del "%com%" /q
if "%cr%"=="Y" echo:
EXIT /b

:getColorCode col ret -- converts color text to color code
::                    -- col [in]  - color text BackgroundForeground, i.e.: BlueLYellow for 1E
::                    -- ret [out] - return variable to return color code in
:$created 20060101 :$changed 20080219 :$categories Color,Echo
:$source http://www.dostips.com
SETLOCAL
set col=%~1
set col=%col:Gray=8%
set col=%col:LBlue=9%
set col=%col:LGreen=A%
set col=%col:LAqua=B%
set col=%col:LRed=C%
set col=%col:LPurple=D%
set col=%col:LYellow=E%
set col=%col:LWhite=F%
set col=%col:Black=0%
set col=%col:Blue=1%
set col=%col:Green=2%
set col=%col:Aqua=3%
set col=%col:Red=4%
set col=%col:Purple=5%
set col=%col:Yellow=6%
set col=%col:White=7%
ENDLOCAL & IF "%~2" NEQ "" (SET %~2=%col%) ELSE (echo:%col%)
EXIT /b

::*** End of File *****************************************************