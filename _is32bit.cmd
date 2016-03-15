@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::*********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Detects 32 / 64 architecture
SET $Author=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $Source=%~f0
::----------------------------------------------------------------------
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)  %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(#)  %$NAME%
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Uses the two environment variables $Is32Bit and $Is64Bit to indicate
::@(#)  the architecture. 
::@(#)  If 32 bit $Is32Bit will be set and $Is64Bit removed. And vice versa on 64 bit.
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      CALL %$NAME%
::@(#)      SET $Is
::@(#) 
::@(#)  Will produce:
::@(#)      $Is32Bit=1      On 32 bit architecture
::@(#)  and
::@(#)      $Is64Bit=1      On 64 bit architecture
::@(#) 
::@(#) 
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@(#)  0   32 bit
::@(#)  1   64 bit
::@(#)  2   64 bit assumed
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
::@(#)  _GetOpt.cmd     Parse command line options and create environment vars
::@(#)
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  
::@ (#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@ (#)  URL: http://support.microsoft.com/kb/556009/da
::@(#)  OLD http://windowsitpro.com/article/articleid/82861/jsi-tip-8971-how-can-i-change-the-case-of-string-to-all-upper-case-or-all-lower-case.html
::@(#)
::@(#)SOURCE
::@(-)  Where to find this source
::@(#)  %$Source%
::@(#)
::@ (#)AUTHOR
::@(-)  Who did what
::@ (#)  %$AUTHOR%
::*** HISTORY **********************************************************
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init Description/Initials [xx.xxx]
::SET $VERSION=2010-12-13&SET $REVISION=09:53:00&SET $COMMENT=Initial/ErikBachmann [01.000]
::SET $VERSION=2014-01-07&SET $REVISION=18:12:00&SET $COMMENT=Reading from Registry. Enhanced ID/ErikBachmann [01.020]
::SET $VERSION=2015-02-19&SET $REVISION=09:49:00&SET $COMMENT=Autoupdate / ErikBachmann
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=Calling usage and exit on error / ErikBachmann
::SET $VERSION=2015-10-08&SET $REVISION=16:00:00&SET $COMMENT=GetOpt: Calling usage and exit on error / ErikBachmann
::SET $VERSION=2015-11-23&SET $REVISION=16:30:00&SET $COMMENT=GetOpt replaced _getopt.sub simple call. Reduces runtime to 1/3 / ErikBachmann
  SET $VERSION=2016-03-14&SET $REVISION=10:00:00&SET $COMMENT=Set "%~dp0\ prefix on function calls / ErikBachmann
::**********************************************************************
::@(#)(C)%$Version:~0,4% %$Author%
::**********************************************************************
ENDLOCAL

    CALL "%~dp0\_DEBUG"
    ::CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
    :: Check ONLY for combinations of -h, /h, --help
    CALL "%~dp0\_getopt.sub" %*&IF ERRORLEVEL 1 EXIT /B 1

    CALL "%~dp0\_registry.read_string" "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" "PROCESSOR_ARCHITECTURE"
    
    IF /I "x86"=="%#HKEY_LOCAL_MACHINE.PROCESSOR_ARCHITECTURE%" (
        %_VERBOSE_% %ComputerName% has a 32 Bit Operating system
        SET $Is32Bit=1
        SET $Is64Bit=
        EXIT /B 0
    ) ELSE IF /I "AMD64"=="%#HKEY_LOCAL_MACHINE.PROCESSOR_ARCHITECTURE%" (
        %_VERBOSE_% %ComputerName% has a 64 Bit Operating System (AMD64)
        SET $Is32Bit=
        SET $Is64Bit=1
        EXIT /B 1
    ) ELSE IF /I "x64"=="%#HKEY_LOCAL_MACHINE.PROCESSOR_ARCHITECTURE:~-2%" (
        %_VERBOSE_% %ComputerName% has a 64 Bit Operating System (x64)
        SET $Is32Bit=
        SET $Is64Bit=1
        EXIT /B 1
    ) ELSE IF /I "64"=="%#HKEY_LOCAL_MACHINE.PROCESSOR_ARCHITECTURE:~-2%" (
        %_VERBOSE_% %ComputerName% has a 64 Bit Operating System (Undefined 64 bit)
        SET $Is32Bit=
        SET $Is64Bit=1
        EXIT /B 1
    (
        %_VERBOSE_% %ComputerName% MAY have a 64 Bit Operating System
        SET $Is32Bit=
        SET $Is64Bit=1
        EXIT /B 2
    )
GOTO :EOF

::*** End of File ******************************************************