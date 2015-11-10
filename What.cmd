@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Search file for pattern "@(#)" and print remainder of string
SET $Author=Erik Bachmann, ClicketyClick.dk (E_Bachmann@ClicketyClick.dk)
SET $Source=%~dpnx0
::----------------------------------------------------------------------
::@(#)NAME
::@(#)  %$Name% -- %$Description%
::@(#) 
::@(#)SYNOPSIS
::@(#)  %$Name% filename [pattern] {Options}
::@(#) 
::@(#)DESCRIPTION
::@(#)  Reads each file name and searches for sequences of the form 
::@(#)  "@(#)", as inserted by the source code control system (SCCS)
::@(#)  It prints the remainder of the string following this marker, 
::@(#)  up to a null character, newline, double quote, or ">" character.
::@(#) 
::@(#)  A pattern may be given to replace the x in (x) like:
::@(#) 
::@(#)     %$Name% file pattern
::@(#) 
::@(#)  Will print alle lines the sequence: "@(pattern)"
::@(#)  Note: Patterns are case insensitive
::@(#)
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::
::EXIT STATUS
::
::     The following exit values are returned:
::     0   Any matches were found.
::     1   No matches found.
::
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  _GetOpt.cmd     Parse command line options and create environment vars
::@(#) 
::@(#)SOURCE
::@(#)  %$Source%
::@(#) 
::----------------------------------------------------------------------
:: History
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm:ss&SET $COMMENT=Init / Description
::SET $VERSION=00.000&SET $REVISION=2009-04-17T11:01:00&SET $COMMENT=ebp / Initial
::SET $VERSION=01.001&SET $REVISION=2009-06-09T18:01:00&SET $COMMENT=EBP / Updating comments, adding version/ebp
::SET $VERSION=01.010&SET $REVISION=2010-10-11T20:01:00&SET $COMMENT=EBP / $COMMENT=Updating comments, adding version, hiding patterns/ebp
::SET $VERSION=01.020&SET $REVISION=2010-10-12T16:25:00&SET $COMMENT=EBP / Masking lines NOT starting with 'Set $'
::SET $VERSION=01.030&SET $REVISION=2010-10-12T21:50:00&SET $COMMENT=EBP / -history implemented
::SET $VERSION=01.040&SET $REVISION=2010-10-12T23:03:00&SET $COMMENT=EBP / -html implemented
::SET $VERSION=01.041&SET $REVISION=2010-10-20T17:15:00&SET $Comment=Addding $Source/EBP
::SET $VERSION=01.050&SET $REVISION=2011-10-13T18:41:00&SET $Comment=Masking VERY special characters/EBP
::SET $VERSION=2015-10-22&SET $REVISION=06:00:00&SET $COMMENT=Update usage / ErikBachmann
  SET $VERSION=2015-11-10&SET $REVISION=08:23:00&SET $COMMENT=Path to Debug, expanded $NAME / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

:init
    CALL "%~dp0\_DEBUG"
    SET _fileName=%~1
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1 
    :: Hide pattern for this very script ;-)
    SET _PATTERN=SET ^$
    IF DEFINED @what.html SET @what.html=html

:Processing
    :: Expand environment variables from target file
    FOR /F "TOKENS=1*" %%a IN ('find /i "%_PATTERN%" ^<"%_FileName%"') DO (
            IF /I "SET"=="%%a" (
                %_DEBUG_%  ---[%%a] [%%b] [%%c]
                CALL :SETENV "%%a %%b"
            ) ELSE (
                %_DEBUG_%  skipping [%%a %%b]
            )
    )

    SET $NAME=%~n1
    SET $SOURCE=%~f1

    "%windir%\System32\cscript.exe" //nologo  "%~dpn0.inc.vbs" "%_FileName%" "@\(#\)" %@what.html%
    ::ECHO  [%@what.html%]
    ::ECHO [%_filename%] [%$NAME%]
GOTO :EOF

::----------------------------------------------------------------------

:: Setting environment variables from sub script
:SETENV
:: NOTE $Source must be handled separately, since the $source referes to %~f0
:: which will be expanded in What's scope
    ECHO:"%~1" | FINDSTR /I " $source="  1>NUL 2>&1

    SET _result=%ErrorLevel%

    IF "0"=="%_result%" (
        %_DEBUG_% Match SET $SOURCE=%_SourceName%
        CALL SET $SOURCE=%_SourceName%
    ) ELSE (
        %_DEBUG_% No match %_result% %~1
        CALL %~1
        %_DEBUG_% subdefine: %~1
    )

GOTO :EOF

::----------------------------------------------------------------------
