@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Echos a formatted error message w. filename, line no, errorID and additional help
SET $Author=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $Source=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)  %$Name% file uniqueStr {formatter} {offset}
::@(#) 
::@(#)   
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  uniqueStr [in]     - a unique string to identify the line
::@(#)  formatter [in,opt] - a string using __FILE__ and/or __LINE__ to be substituted and echoed
::@(#)  offset    [in,opt] - offset to be added to the line number
::@(#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  This function outputs a formatted string with
::@(#)    Full file name
::@(#)    Line number
::@(#)    Error ID
::@(#)    Error message
::@(#)    Extended error message
::@(#)    Additional help
::@(#)     
::@(#)  Displayed in a syntax like
::@(#)     FileName(LineNr)[ErrorID]: Error message  Extended error message
::@(#)     
::@(#)     Additional help
::@(#)
::@(#)EXTENDED ERROR MESSAGE
::@(#)  Is stored in environment variables like
::@(#)
::@(#)    SET @Error.001=First error
::@(#)    SET @Error.002=Second error
::@(#)    SET @Error.003=Third error
::@(#)
::@(#)   Variables are set on initiating the main script
::@(#)
::@(#)ADDITIONAL HELP
::@(#)  Attempting to mimic the oerr help message utility extracting help from a table
::@(#)  at the end of the script. All lines matching the prefix "::#ERRORID" will be displayed.
::@(#)    
::@(#)    ::**********************************************************************
::@(#)    ::* Error messages (like Oracle oerr)
::@(#)    ::**********************************************************************
::@(#)    ::#Error.000 Error.000 -- Template
::@(#)    ::#Error.000 // *Cause: 
::@(#)    ::#Error.000 // *Action: 
::@(#)    ::----------------------------------------------------------------.......
::@(#)    ::#Error.001 Error.001 - first error - Non fatal
::@(#)    ::#Error.001 // *Cause: Some error has occured (Continuing)
::@(#)    ::#Error.001 // *Action: What to do to prevent this error 
::@(#)    ::#Error.001 // OR what action to take to clean up the mess
::@(#)    ::
::@(#)    ::#Error.002 Error.002 - Second error - Non fatal w emailFatal
::@(#)    ::#Error.002 // *Cause: Non fatal error - but sending email to Sysadm (Continuing)
::@(#)    ::#Error.002 // *Action: What to do to prevent this error OR what action to take to 
::@(#)    ::#Error.002 // clean up the mess when script has aborted
::@(#)    ::
::@(#)    ::#Error.003 Error.003 - Second error - Fatal
::@(#)    ::#Error.003 // *Cause: Forced fatal error (Aborting)
::@(#)    ::#Error.003 // *Action: What to do to prevent this error OR what action to take to 
::@(#)    ::#Error.003 // clean up the mess when script has aborted.
::@(#)    ::#Error.003 // Email send to Sysadm
::@(#)    ::
::@(#)    ::**********************************************************************
::@(#)    
::@(#)  Additional help should be placed at the end of the main script
::@(#)    
::@(#)GLOBAL VARIABLES
::@(#)  $ErrorMsg        Short errormessage
::@(#)  $ErrorDesc       Descriptive errormessage incl. addtional help
::@(#)
::@(#)  {CrLf} masks CrLf in $ErrorDesc.
::@(#)
::@(#)
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  SET _Error_=CALL "%%~dp0\_ErrorHandler" "%%$Source%%"
::@(#)  %%_Error_%% "ERROR.001" "Testing error 1" -1 Continue
::@(#)  
::@(#)  Will display:
::@(#)     C:\Users\xxx\test.bat(23)[ERROR.001]: Testing error 1 First error
::@(#)     
::@(#)     Error.001 - first error - Non fatal
::@(#)     // *Cause: Some error has occured (Continuing)
::@(#)     // *Action: What to do to prevent this error
::@(#)     // OR what action to take to clean up the mess
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
::@(#)
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#)  oerr
::@ (#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@ (#)  URL: http://en.wikipedia.org/wiki/Man_page
::@(#)  http://clicketyclick.dk/development/dos/
::@(#)  :$reference http://www.dostips.com/forum/viewtopic.php?t=369
::@(#)  :$created 20080512 :$changed 20080512
::@(#)  :$source http://www.dostips.com
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
::SET $VERSION=2011-06-06&SET $REVISION=15:05:00&SET $COMMENT=Initial [01.000]
::SET $VERSION=2015-01-03&SET $REVISION=10:02:00&SET $COMMENT=General update
::SET $VERSION=2015-02-18&SET $REVISION=15:54:00&SET $COMMENT=ECHO^. to ECHO:
::SET $VERSION=2015-02-19&SET $REVISION=03:23:25&SET $COMMENT=Autoupdate / ErikBachmann½
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
  SET $VERSION=2015-11-23&SET $REVISION=16:30:00&SET $COMMENT=GetOpt replaced _getopt.sub simple call. Reduces runtime to 1/3 / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    ::CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
    :: Check ONLY for combinations of -h, /h, --help
    CALL _getopt.sub %*&IF ERRORLEVEL 1 EXIT /B 1


EndLocal

Setlocal Disabledelayedexpansion

:Init
    IF NOT DEFINED _DEBUG_ CALL "%~dp0\_debug"
    %_DEBUG_% --- start Errorhandler
    SET "_File=%~1"
    SET "_Error=%~2"
    SET "_Msg=%~3"
    SET "_lineNr=%~4"
    SET "_Continue=%~5"
    SET "_AddHelp="


    Set "Fmt=__FILE__(__LINE__)[__ERROR__]: %_Msg%"
    If Not Defined Fmt Set "Fmt=__FILE__(__LINE__): ERROR"

:Main
    For /F "Delims=:" %%A In ('"Findstr /N "%_Error%" "%_File%""') Do Set /A "lineNr=%%A+%_LineNr%0/10"

    %_DEBUG_% linenr=%LineNr%
    Call Set "Fmt=%%Fmt:__ERROR__=%_Error%%%"
    Call Set "Fmt=%%Fmt:__LINE__=%lineNr%%%"
    Call Set "Fmt=%%Fmt:__FILE__=%_File%%%
    CALL ECHO:

    Setlocal Enabledelayedexpansion
    CALL ECHO:%Fmt% !@%_Error%!
    EndLocal
:AdditionalHelp
    For /F "tokens=1*" %%A In ('"Findstr /I "^::#%_Error%" "%_File%""') Do ECHO %%B
    For /F "tokens=1*" %%A In ('"Findstr /I "^::#%_Error%" "%_File%""') Do CALL :AddHelp "%%B"

    ECHO ////
    ECHO [%_AddHelp%]
    ECHO ////

    CALL ECHO:

    %_DEBUG_% ---- endErrorhandler

:PostProcessing
    SET _MsgBody=%$Name%@%ComputerName% %$NAME% - %Fmt% !@%_Error%! [%ErrorLevel%]{CrLf}%_AddHelp%
    ENDLOCAL&SET $ErrorMsg="%$Name%@%ComputerName% %$NAME% - %Fmt% !@%_Error%!"&SET $ErrorDesc="%_MsgBody%"
GOTO :EOF

    IF /I "%_Continue%!" == "FATAL!" (
        ECHO Aborting!
        ECHO Mail to Sysadm
        CALL "%~dp0\Mail_Sysadm.cmd" ^
            "%$Name%@%ComputerName% %$NAME% - %Fmt% !@%_Error%!" ^
            "%$Name%@%ComputerName% %$NAME% - %Fmt% !@%_Error%! [%ErrorLevel%]"
        FOR /l %%a in (5,-1,1) do (TITLE %_Error% -- closing in %%a sec.&ping -n 2 -w 1 127.0.0.1>NUL)
        TITLE Closing...&ECHO:
        EXIT 1
    ) ELSE IF /I "%_Continue%!" == "SYSMAIL!" ( 
        ECHO Mail to Sysadm
        CALL "%~dp0\Mail_Sysadm.cmd" ^
            "%$Name%@%ComputerName% %$NAME% - %Fmt% !@%_Error%!" ^
            "%_MsgBody%"
    ) ELSE (
        ECHO Continue
    )

    ENDLOCAL&SET $ErrorMsg="%$Name%@%ComputerName% %$NAME% - %Fmt% !@%_Error%!"&SET $ErrorDesc="%_MsgBody%"
GOTO :EOF

:AddHelp
    :: Using {CrLf} as CRLF
    SET _AddHelp=%_AddHelp%{CrLf}%~1
GOTO :EOF

::*** End of File ******************************************************