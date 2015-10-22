@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Find and display reference manual information from file
SET $AUTHOR=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)  %$NAME% -- %$DESCRIPTION%
::@(#)
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes.
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)
::@(#)  %$Name% file-name [pattern] {flags}
::@(#)  %$Name% file-name [pattern]
::@(#)
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@ (#)  -h      Help page
::@(#)  -html       Output in HTML format
::@(#)  -history    Display file history
::@(#)
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Reads each file name and searches for sequences of the form
::@(#)  "@(#)", as inserted by the source code control system (SCCS)
::@(#)  It prints the remainder of the string following this marker,
::@(#)  up to a null character, newline, double quote, or "{GT}" character.
::@(#)
::@(#)  So masking the VERY special characters is needed:
::@(#)  {CURREN}	{LCURL}CURREN{RCURL}	Currency
::@(#)  {AMP}	{LCURL}AMP{RCURL}		Ampersand
::@(#)  {CARET}	{LCURL}CARET{RCURL}		Caret
::@(#)  {EXCL}	{LCURL}EXCL{RCURL}		Exclamation mark
::@(#)  {GT}	{LCURL}GT{RCURL}		Greater than
::@(#)  {LT}	{LCURL}LT{RCURL}		Less than
::@(#)  {PIPE}	{LCURL}PIPE{RCURL}		Pipe or vertical bar
::@(#)  {COPY}	{LCURL}COPY{RCURL}		Copyright
::@(#)  {LPAR}	{LCURL}LPAR{RCURL}		Left parentheses
::@(#)  {RPAR}	{LCURL}RPAR{RCURL}		Right parentheses
::@(#)  {LCURL}	{LCURL}LCURL{RCURL}		Left curly parentheses
::@(#)  {RCURL}	{LCURL}RCURL{RCURL}		Right curly parentheses
::@(#)  {PCT}	{LCURL}PCT{RCURL}		Percent
::@(#)  {QUEST}	{LCURL}QUEST{RCURL}		Question mark
::@(#)

::@(#)  A pattern may be given to replace the x in (x) like:
::@(#)
::@(#)     %$Name% file pattern
::@(#)
::@(#)  Will print all lines with the sequence: "@(pattern)"
::@(#)  Note: Patterns are case insensitive
::@(#)
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  %$NAME% what.cmd
::@(#)
::@(#)
::@(#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@(#)     0   Any matches were found.
::@(#)     1   No matches found.
::@(#)
::@ (#)ENVIRONMENT
::@(-)  Variables affected
::@ (#)
::@ (#)
::@ (#)FILES
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
::@ (#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@ (#)  URL:
::@ (#)
::@(#)SOURCE
::@(-)  Where to find this source
::@(#)  %$Source%
::@(#)
::@ (#)AUTHOR
::@(-)  Who did what
::@ (#)  %$AUTHOR%
::*** HISTORY **********************************************************
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init / Description [xx.xxx]
::SET $VERSION=2009-04-17&SET $REVISION=11:01:00&SET $COMMENT=ErikBachmann / Initial [00.000]
::SET $VERSION=2009-06-09&SET $REVISION=18:01:00&SET $COMMENT=ErikBachmann / Updating comments, adding version/ErikBachmann [01.001]
::SET $VERSION=2010-10-11&SET $REVISION=20:01:00&SET $COMMENT=ErikBachmann / $COMMENT=Updating comments, adding version, hiding patterns/ErikBachmann [01.010]
::SET $VERSION=2010-10-12&SET $REVISION=16:25:00&SET $COMMENT=ErikBachmann / Masking lines NOT starting with 'Set $' [01.020]
::SET $VERSION=2010-10-12&SET $REVISION=21:50:00&SET $COMMENT=ErikBachmann / -history implemented [01.030]
::SET $VERSION=2010-10-12&SET $REVISION=23:03:00&SET $COMMENT=ErikBachmann / -html implemented [01.040]
::SET $VERSION=2010-10-20&SET $REVISION=17:15:00&SET $COMMENT=Adding $Source/ErikBachmann [01.041]
::SET $VERSION=2011-10-13&SET $REVISION=18:41:00&SET $COMMENT=Masking VERY special characters/ErikBachmann [01.050]
::SET $VERSION=2014-01-03&SET $REVISION=11:51:00&SET $COMMENT=Bug-fix: LT escaped in DOS/ErikBachmann [01.051]
::SET $VERSION=2014-01-16&SET $REVISION=12:05:00&SET $COMMENT=Add extension to file + history/ErikBachmann [01.060]
::SET $VERSION=2014-02-18&SET $REVISION=21:27:00&SET $COMMENT=Change escape from currency to curly parentheses/ErikBachmann [01.070]
::SET $VERSION=2014-02-18&SET $REVISION=10:58:00&SET $Comment=ErikBachmann / General update
::SET $VERSION=2015-02-13&SET $REVISION=09:08:00&SET $Comment=ErikBachmann / Bugfix for whitespace
::SET $VERSION=2015-02-19&SET $REVISION=00:22:00&SET $Comment=ErikBachmann / Copyright + version
::SET $VERSION=2015-02-19&SET $REVISION=03:16:54&SET $COMMENT=Autoupdate / ErikBachmann
::SET $VERSION=2015-03-27&SET $REVISION=14:18:00&SET $COMMENT=Question mark added / ErikBachmann
  SET $VERSION=2015-03-30&SET $REVISION=12:22:00&SET $COMMENT=Bug fix for cmdized scripts / ErikBachmann
::**********************************************************************
::@(#){COPY}%$VERSION:~0,4% %$Author%
::**********************************************************************

:MAIN
    CALL :what.init %*
    CALL :what.process %*
    ::CALL :what.finalize %*
GOTO :EOF :MAIN

::----------------------------------------------------------------------

:what.init
    CALL "%~dp0\_Debug"
    CALL "%~dp0\_GetOpt" %*
    SET _SUBNAME=%~n1
    SET _FileName=!@%$name%.1!
    SET _History=!@%$name%.history!
    SET _Source=%~f1
    SET _OrgName=%$name%
    SET _HTML=!@%$name%.html!

    :: No arguments = what on what
    IF "!@%$name%.1!" == "!" (
        CALL :what.Self "%~f0"
        GOTO :EOF
    )
GOTO :EOF :what.init

::----------------------------------------------------------------------

:what.process
    :: In case you forget the extention ;-)
    IF NOT EXIST "%_FileName%" (
        FOR %%A IN ( bat cmd ) DO (
            IF EXIST "%_FileName%.%%A" SET _FileName=%_FileName%.%%A
        )
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
    %_DEBUG_% *** _SUBNAME=[%_SUBNAME%]

    :: Hide pattern for this very script ;-)
    SET _PATTERN=SET ^$

    FOR /F "TOKENS=1*" %%a IN ('find /i "%_PATTERN%" ^<"%_FileName%"') DO (
        CALL SET _ARG=%%a
        
        IF /I "SET"=="%%a" (
            %_DEBUG_%  ---[%%a] [%%b] [%%c]
            CALL :what.SETENV "%%a %%b"
         ) ELSE IF /I "SET"=="!_ARG:~4!" (
            :: Bug fix for cmdized scripts
            %_DEBUG_%  ---[%%a] [%%b] [%%c]
            CALL :what.SETENV "!_ARG:~4! %%b"
         ) ELSE (
            CALL SET _ARG=%%a
            CALL SET _ARG=%_ARG:~4%
            %_DEBUG_%  skipping [%%a %%b]
         )
    )

    
    :: Print file header
    SET $NAME=%_SUBNAME%
    SET $SOURCE=%_Source%

    IF DEFINED $NAME (
        IF DEFINED _HTML (
            ECHO ^<link rel="stylesheet" href="../underscore.css" type="text/css" /^>
            ECHO:^<script language="JavaScript" src="what.js" type="text/javascript"^>^</script^>
            rem ECHO ^<h2^>%$NAME% v.%$VERSION% rev.%$Revision% ^</h2^>
            ECHO:^<h1^>%$NAME%^</h1^>
            ECHO:^<p^>v.%$VERSION% rev.%$Revision%^</p^>
        ) ELSE (
            ECHO %$NAME% v.%$VERSION% rev.%$Revision%
            ECHO\
        )
    )

    FOR /F "tokens=1* delims=)" %%a IN ('find /i "%_WHAT%" ^< "%_FileName%"') DO (
        CALL :what.ExpandEnv "%%b"
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

        %_DEBUG_% -- [!@%_OrgName%.1!] [%_FileName%]
        REM FOR /F "TOKENS=*" %%a IN ('find /i "%_PATTERN%" ^<"!@%_OrgName%.1!"') DO (
        FOR /F "TOKENS=*" %%a IN ('CALL find /i "%_PATTERN%" ^<"%_FileName%"') DO (
            FOR /F "TOKENS=1-2* Delims=^&" %%b IN ("%%a") DO (
                    CALL :what.SETENVhist "%%b" "%%c" "%%d"
            )
        )
        IF DEFINED _HTML (
            ECHO ^</table^>
        )
    )
    IF DEFINED _HTML (
        ECHO:^<hr^>
        rem ECHO:. o O o .
    )

GOTO :EOF :what.process

::----------------------------------------------------------------------

:: Setting environment variables from sub script
:what.SETENV
    %~1
    %_DEBUG_% subdefine: %~1
GOTO :EOF :what.SETENV

::----------------------------------------------------------------------

:what.ExpandEnvHtmlHeadline
    SET _line=%~1
    CALL SET "_line=%_line:{COPY}=&copy;%"
    CALL SET "_line=%_line: =&nbsp;%"

    ECHO:^<hr^>!_line!^</hr^>
GOTO :EOF :what.ExpandEnvHtmlHeadline

::----------------------------------------------------------------------

:: Expanding variables inside what strings
:what.ExpandEnv
    SETLOCAL ENABLEDELAYEDEXPANSION
    SET _line=%*
    SET _line=%_line:~1,-1%
    IF NOT DEFINED _line (
        rem IF DEFINED _HTML ( ECHO:^<p^>^&nbsp;^</p^>) ELSE ECHO:
        ECHO:
        GOTO :EOF
    )
    IF DEFINED _HTML CALL SET "_line=!_line:(C)={COPY}!"
    CALL SET _line=%_line:(={LPAR}%
    CALL SET _line=%_line:)={RPAR}%
    CALL SET _line=%_line:&={AMP}%
    CALL SET _line=%_line:"='%

::SET _line 
::pause
    IF DEFINED _HTML (
        IF "{"=="%_line:~0,1%" (
            CALL :what.ExpandEnvHtmlHeadline "%_line%"
        ) ELSE IF " "=="%_line:~0,1%" (
            REM :: Ordinary text
            REM :: Expanding whitespace: Genuine blanks must be expanded first!
            CALL SET "_line=!_line: =!"
            CALL SET "_line=!_line: =&nbsp;!"
            REM :: Expanding whitespace: Expanding TAB
            CALL SET "_line=!_line:	=<span style="white-space: pre;">&#09;</span>!"

            CALL SET "_line=!_line:{QUEST}=&#63!"
            CALL SET "_line=!_line:{EXCL}=&#33;!"
            CALL SET "_line=!_line:{PCT}=&#37;!"
            CALL SET "_line=!_line:{CURREN}=&curren;!"
            CALL SET "_line=!_line:{LT}=&lt;!"
            CALL SET "_line=!_line:{LT}=&lt;!"
            CALL SET "_line=!_line:{GT}=&gt;!"

            CALL SET "_line=!_line:{LPAR}=(!"
            CALL SET "_line=!_line:{RPAR}=)!"
            CALL SET "_line=!_line:{PIPE}=|!"
            CALL SET "_line=!_line:{COPY}=&copy;!"
            CALL SET "_line=!_line:(C)=&copy;!"
            CALL SET "_line=!_line:{AMP}=&amp;!"
            CALL SET "_line=!_line:{CARET}=&#94;!"
            CALL SET "_line=!_line:{LCURL}={!"
            CALL SET "_line=!_line:{RCURL}=}!"

            CALL SET "_line=!_line:{LINKSTART}=<script>linkMe('!"
            CALL SET "_line=!_line:{LINKEND}=')</script>!"

            ECHO:^<tt^>!_line!^</tt^>^<br^>
        ) ELSE (
            REM :: Headlines
            CALL SET "_line=!_line:{COPY}=&copy;!"
            CALL SET "_line=!_line:{LPAR}=(!"
            CALL SET "_line=!_line:{RPAR}=)!"
            ECHO:^<h3^>!_line!^</h3^>
        )
    ) ELSE (
        REM :: Plain text mode
        CALL SET "_line=%_line:{LINKSTART}=%"
        CALL SET "_line=%_line:{LINKEND}=%"

        CALL SET "_line=%_line:{CURREN}=Ï%"
        CALL SET "_line=!_line:{LT}=<!"
        CALL SET "_line=!_line:{GT}=>!"
        CALL SET "_line=!_line:{LPAR}=(!"
        CALL SET "_line=!_line:{RPAR}=)!"
        CALL SET "_line=!_line:{PIPE}=|!"
        CALL SET "_line=!_line:{AMP}=&!"
        CALL SET "_line=!_line:{COPY}=(c)!"
        CALL SET "_line=!_line: =!"
        CALL SET "_line=!_line:{LCURL}={!"
        CALL SET "_line=!_line:{RCURL}=}!"

        CALL SET "_line=!_line:{LINKSTART}=!"
        CALL SET "_line=!_line:{LINKEND}=!"

        CALL SET "_line=!_line:{QUEST}=?!"
        REM CALL SET "_line=!_line:{CARET}=^!"
        REM CALL SET "_line=!_line:{CARET}=^^!"
        REM :: Exclamation is displayed upside down in ASCII text mode
        CALL SET "_line=!_line:{EXCL}=­!"
        CALL SET "_line=!_line:{PCT}=%%%%!"
        REM :: Caret must be the last expansion due to the special ^
        SET "_line=!_line:{CARET}=^!"

        ECHO:!_line!
    )

GOTO :EOF

::----------------------------------------------------------------------

:: Setting environment variables from sub script
:what.SETENVhist
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

::----------------------------------------------------------------------

:: No arguments = what on what
:what.Self

    SET _line=%1
    IF DEFINED @%$name%.history SET _line=%_line% -history
    IF DEFINED @%$name%.html SET _line=%_line% -html
    %_DEBUG_% Self called: %_line% %1
    CALL %_line% %1
GOTO :EOF

::*** End of File ******************************************************