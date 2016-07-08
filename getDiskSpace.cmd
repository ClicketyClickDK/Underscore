@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=List free space and total disk space on all available drives
SET $AUTHOR=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $SOURCE=%~f0
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)%$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(#)  List free space and total space (in GB) for all available drives
::@(#) 
::@ (#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  List free space and total disk space on all available drives in GB.
::@(#)  List sum of free and total disk space.
::@(#)  
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      CALL %$NAME%
::@(#)  
::@(#)  Drive            Free                Space
::@(#)  C:              22,24 GB /          117,78 GB
::@(#)  D:             618,65 GB /        6.144,00 GB
::@(#)  E:              83,03 GB /          115,66 GB
::@(#)  G:             618,65 GB /        6.144,00 GB
::@(#)  H:             618,65 GB /        6.144,00 GB
::@(#)  I:           1.915,60 GB /        3.072,00 GB
::@(#)  Total        3.876,82 GB /       21.737,43 GB
::@(#)  
::@ (#)EXIT STATUS
::@ (-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)  0   OK  (Daytime)
::@ (#)  1   Help or manual page 
::@ (#)  2   Morning
::@ (#)  3   Evening
::@ (#)  4+  Error
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
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  _getopt.sub     Check ONLY for combinations of -h, /h, --help
::@(#)
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  
::@ (#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@(#)  Author: JosefZ (http://superuser.com/)
::@(#)  URL: http://superuser.com/questions/896764/windows-command-line-get-disk-space-in-gb
::@(#)
::@(#)  Author: dilettante (http://www.tek-tips.com/)
::@(#)  URL: http://www.tek-tips.com/viewthread.cfm?qid=1439206
::@(#)  vbscript: Left justify string
::@(#)
::@(#)SOURCE
::@(-)  Where to find this source
::@(#)  %$Source%
::@(#)
::@ (#)AUTHOR
::@(-)  Who did what
::@ (#)  %$AUTHOR%
::*** HISTORY **********************************************************
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init Description [xx.xxx]
  SET $VERSION=2016-04-21&SET $REVISION=11:10:00&SET $COMMENT=Initial [01.000]
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************
    CALL "%~dp0\_DEBUG"
    ::CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
    :: Check ONLY for combinations of -h, /h, --help
    CALL "%~dp0\_getopt.sub" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL


::http://superuser.com/questions/896764/windows-command-line-get-disk-space-in-gb

:: Right justify string [http://www.tek-tips.com/viewthread.cfm?qid=1439206]
(
    echo:Function Pad^(ByRef Text, ByVal Length^)
    rem:: org left justify
    rem echo:  Pad = Left^(Text ^& Space^(Length^), Length^)
    echo:  Pad = Right^(Space^(Length^) ^&  Text , Length^)
    echo:End Function
    echo:dim len
    echo:dim totalSpace, totalFree
    echo:len = 15
    echo:total = 0
    
    echo wsh.echo "Drive " ^& Pad^( "Free", len^) ^& "      "^&  Pad^("Space", len^)^& " "
)> %temp%\tmp2.vbs

for /f "tokens=1-3" %%a in ('WMIC LOGICALDISK GET FreeSpace^,Name^,Size ^|FINDSTR /I /V "Name"') do (
    @if not "%%c"=="" (
        echo wsh.echo "%%b   " ^& " " ^& Pad^(FormatNumber^(cdbl^(%%a^)/1024/1024/1024, 2^), len^) ^& " GB"^& " / " ^& Pad^(FormatNumber^(cdbl^(%%c^)/1024/1024/1024, 2^), len^)^& " GB"
        echo:totalFree = totalFree + %%a
        echo:totalSpace = totalSpace + %%c
    ) >> %temp%\tmp2.vbs
)

(
    echo wsh.echo "Total" ^& " " ^& Pad^(FormatNumber^(cdbl^(totalFree^)/1024/1024/1024, 2^), len^) ^& " GB"^& " / " ^& Pad^(FormatNumber^(cdbl^(totalSpace^)/1024/1024/1024, 2^), len^)^& " GB"
)>> %temp%\tmp2.vbs

cscript //nologo %temp%\tmp2.vbs
