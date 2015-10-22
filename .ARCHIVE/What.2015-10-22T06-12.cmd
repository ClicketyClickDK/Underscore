@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Search file for pattern "@^(#^)" and print remainder of string
SET $Author=Erik Bachmann, ClicketyClick.dk (E_Bachmann@ClicketyClick.dk)
SET $Source=%~dpnx0
::----------------------------------------------------------------------
::@(#)NAME
::@(#)  %$Name% -- %$Description%
::@(#) 
::@(#)SYNOPSIS
::@(#)  %$Name% filename [pattern]
::@(#) 
::@(#)DESCRIPTION
::@(#)  Reads each file name and searches for sequences of the form 
::@(#)  "@(#)", as inserted by the source code control system (SCCS)
::@(#)  It prints the remainder of the string following this marker, 
::@(#)  up to a null character, newline, double quote, or ">" character.
::@(#) 
::@(#)  So masking the VERY special characters is needed:
::@ (#)  ¤  {curren {rCurlPar} Currency
::@ (#)  {amp}  {lCurlPar}amp{rCurlPar}    Ampersant
::@ (#)  {caret}  {lCurlPar} caret {rCurlPar}  Caret
::@ (#)  {GT}  {lCurlPar}GT{rCurlPar}     Greater than
::@ (#)  {LT}  {lCurlPar}LT{rCurlPar}     Less than 
::@ (#)  {pipe}  {lCurlPar}pipe{rCurlPar}   Pipe or vertical bar
::@ (#)  {copy} {lCurlPar}copy{rCurlPar}   Copyright
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
  SET $VERSION=2015-10-22&SET $REVISION=06:00:00&SET $COMMENT=Update usage / ErikBachmann
::**********************************************************************
::@(#)(c)%$Revision:~0,4% %$Author%
::**********************************************************************

CALL _Debug
CALL _GetOpt %*

:what
    SET _SUBNAME=%~n1
    SET _SourceName=%~f1
    SET _FileName=!@%$name%.1!
    SET _History=!@%$name%.history!
    SET _OrgName=%$name%
    SET _HTML=!@%$name%.html!

    :: No arguments = what on what
    IF "!@%$name%.1!" == "!" (
        CALL "%~dpnx0" "%~dpnx0" 
        GOTO :EOF
    )

    :: Set pattern
    IF NOT "!@%$name%.pattern!" == "!" (
        %_DEBUG_% User pattern: [@^(!@%$name%.pattern!^)]
        SET _WHAT=@^(!@%$name%.pattern!^)
    ) ELSE (
        :: Set default pattern
        SET _WHAT=@^(#^)
    )

    FOR /F %%a IN ("!@%$name%.1!") DO CALL SET _SUBNAME=%%~na
    %_DEBUG_% _SUBNAME=[%_SUBNAME%]

    :: Hide pattern for this very script ;-)
    SET _PATTERN=SET ^$
    ::FOR /F "TOKENS=1*" %%a IN ('find /i "%_PATTERN%" ^<"%_FileName%"') DO ECHO --[%%a][%%b]
    FOR /F "TOKENS=1*" %%a IN ('find /i "%_PATTERN%" ^<"%_FileName%"') DO (
            IF /I "SET"=="%%a" (
                %_DEBUG_%  ---[%%a] [%%b] [%%c]
                CALL :SETENV "%%a %%b"
            ) ELSE (
                %_DEBUG_%  skipping [%%a %%b]
            )
    )

    :: Print file header
    SET $NAME=%_SUBNAME%
    
    IF DEFINED $NAME (
        IF DEFINED _HTML (
            ECHO ^<link rel="stylesheet" href="what.css" type="text/css" /^>
            ECHO ^<h2^>[%$NAME%] v.[%$VERSION%] rev.[%$Revision%] ^</h2^>
        ) ELSE (
            ECHO [%$NAME%] v.[%$VERSION%] rev.[%$Revision%] 
            ECHO\
        )
    )

    FOR /F "tokens=1* delims=)" %%a IN ('find /i "%_WHAT%" ^< "%_FileName%"') DO (
        CALL :ExpandEnv "%%b"
    )

    SET _PATTERN=SET ^$VERSION
    IF DEFINED _History (
        ECHO\
        IF DEFINED _HTML (
            ECHO ^<h3^>HISTORY^</h3^>
            ECHO ^<table border="1"^>
            ECHO ^<tr^>^<th^>Version^</th^>^<th^>Revision^</th^>^<th width="100%%"^>Description^</th^>^</tr^>
        ) ELSE (
            ECHO HISTORY
        )
        FOR /F "TOKENS=*" %%a IN ('find /i "%_PATTERN%" ^<"!@%_OrgName%.1!"') DO (
            FOR /F "TOKENS=1-2* Delims=^&" %%b IN ("%%a") DO (
                    CALL :SETENVhist "%%b" "%%c" "%%d"
            )
        )
        IF DEFINED _HTML (
            ECHO ^</table^>
        )
    )
    IF DEFINED _HTML (
        ECHO ^<hr^>
    )
    
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

:: Expanding variables inside what strings
:ExpandEnv
    SETLOCAL ENABLEDELAYEDEXPANSION
    SET _=%*
    SET _=%_:~1,-1% 
::    SET _=%_:(={%
::    SET _=%_:)={%
    SET _=%_:(={lPar}%
    SET _=%_:)={rPar}%
    SET _=%_:&={amp}%
::    SET _=%_:^^={caret}%
::    SET _=%_:|={pipe}%
    SET _=%_:"='%
    SET _=%_:^^=x%
::    SET _=%_:}LT}=®%
::    SET _=%_:}GT}=¯%
::    SET _=%_:}PIPE}=^^^|%

::    CALL SET _=%_:}LT}=^^^^^^^<%
::    CALL SET _=!_:}GT}=^^^>!

::ECHO ON
    IF DEFINED _HTML (
        IF "{"=="%_:~0,1%" (
			:: Sub paragraph (Deprecated!)
            ECHO:^<h4^>%_: =^&nbsp;%^</h4^>
        ) ELSE IF " "=="%_:~0,1%" (
		    :: Ordinary text
			CALL SET "_=%_:{curren}=&curren;%"
			CALL SET "_=!_:{LT}=&lt;!"
			CALL SET "_=!_:{GT}=&gt;!"

			CALL SET "_=!_:{lPar}=(!"
			CALL SET "_=!_:{rPar}=)!"
			CALL SET "_=!_:{lCurlPar}={!"
			CALL SET "_=!_:{rCurlPar}=}!"
			CALL SET "_=!_:{pipe}=|!"
			CALL SET "_=!_:{copy}=&copy;!"
			CALL SET "_=!_: =!"
			CALL SET "_=!_: =&nbsp;!"
			CALL SET "_=!_:	=&#09;&#09;!"
			CALL SET "_=!_:	=&#09;&#09;!"
				
			CALL SET "_=!_:{amp}=&amp;!"
			CALL SET "_=!_:{caret}=&#94;!"

			ECHO:^<tt^>!_!^</tt^>^<br^>
        ) ELSE (
			:: Headlines
			CALL SET "_=!_:{copy}=&copy;!"
			CALL SET "_=!_:{lPar}=(!"
			CALL SET "_=!_:{rPar}=)!"
			CALL SET "_=!_:{lCurlPar}={!"
			CALL SET "_=!_:{rCurlPar}=}!"
            ECHO:^<h3^>!_!^</h3^>
        )
    ) ELSE (
        CALL SET "_=!_:{LT}=>!"
        CALL SET "_=!_:{GT}=>!"
        CALL SET "_=!_:{lPar}=(!"
        CALL SET "_=!_:{rPar}=)!"
        CALL SET "_=!_:{pipe}=|!"
        CALL SET "_=!_:{amp}=&!"
        CALL SET "_=!_:{copy}=(c)!"
        CALL SET "_=!_: =!"
        CALL SET "_=!_:{lCurlPar}={!"
        CALL SET "_=!_:{rCurlPar}=}!"
        CALL SET "_=!_:{caret}=^!"
        CALL SET "_=!_:{excl}=!!"
        CALL SET "_=!_:{PCT}=%%%%%!"
        ::CALL SET "_=%_:{curren}=¤"
        ECHO:!_!
    )

GOTO :EOF

::----------------------------------------------------------------------

:: Setting environment variables from sub script
:SETENVhist
    SETLOCAL
    FOR /F "TOKENS=2* Delims==" %%a IN ("%~1") DO (
        SET _$Version=%%a
    )
    FOR /F "TOKENS=2* Delims==" %%a IN ("%~2") DO (
        SET _$Revision=%%a
    )
    
    FOR /F "TOKENS=2* Delims==" %%a IN ("%~3") DO (
        SET _$Comment=%%a
    )
    IF DEFINED _HTML (
        ECHO ^<tr^>^<td^>^<tt^>v.%_$VERSION%^</tt^>^</td^>^
        ^<td^>^<tt^>r.%_$Revision%^</tt^>^</td^>^
        ^<td^>^<tt^>%_$Comment%^</tt^>^</td^>^</tr^>
    ) ELSE (
        ECHO v.%_$VERSION% r.%_$Revision% [%_$Comment%]
    )
    ENDLOCAL
GOTO :EOF

:Self
    SET _=%1
    IF DEFINED @%$name%.history SET _=%_% -history
    IF DEFINED @%$name%.html SET _=%_% -html
    %_DEBUG_% Self called: %_% %1
    CALL %_% %1
    
GOTO :EOF

::*** End of File *****************************************************