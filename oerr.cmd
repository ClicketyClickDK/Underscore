@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Extracts Error messaged from script files using uniq ErrorID
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
::@(#)  %$Name% script ErrorID
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  This function outputs a formatted string with an enhanced message
::@(#)  from within the script itself. The messages are stored in an
::@(#)  "Additional Help"-table.
::@(#)
::@(#)  See the source code of this script for details.
::@(#)
::@(#)ADDITIONAL HELP
::@(#)  Attempting to mimic the oerr help message utility extracting help from a table
::@(#)  at the end of the script. All lines matching the prefix "::#ERRORID" will be displayed.
::@(#)    
::@(#)    ::**********************************************************************
::@(#)    ::* Error messages (like Oracle oerr)
::@(#)    ::**********************************************************************
::@(#)    ::^#Error.000 Error.000 -- Template
::@(#)    ::^#Error.000 // *Cause: 
::@(#)    ::^#Error.000 // *Action: 
::@(#)    ::-----------------------------------------------------------------------------------.......
::@(#)    ::^#Error.001 Error.001 - first error - Non fatal
::@(#)    ::^#Error.001 // *Cause: Some error has occured (Continuing)
::@(#)    ::^#Error.001 // *Action: What to do to prevent this error 
::@(#)    ::^#Error.001 // OR what action to take to clean up the mess
::@(#)    ::
::@(#)    ::^#Error.002 Error.002 - Second error - Non fatal w emailFatal
::@(#)    ::^#Error.002 // *Cause: Non fatal error - but sending email to Sysadm (Continuing)
::@(#)    ::^#Error.002 // *Action: What to do to prevent this error OR what action to take to 
::@(#)    ::^#Error.002 // clean up the mess when script has aborted
::@(#)    ::
::@(#)    ::^#Error.003 Error.003 - Second error - Fatal
::@(#)    ::^#Error.003 // *Cause: Forced fatal error (Aborting)
::@(#)    ::^#Error.003 // *Action: What to do to prevent this error OR what action to take to 
::@(#)    ::^#Error.003 // clean up the mess when script has aborted.
::@(#)    ::^#Error.003 // Email send to Sysadm
::@(#)    ::
::@(#)    ::**********************************************************************
::       NOTE! The "::^#" is an escaped sequence to hide the error from the script selv
::@(#)    
::@(#)  Additional help should be placed at the end of the main script
::@(#)    
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  Oerr oerr "ERROR.001" "Default message/description"
::@(#)  
::@(#)  Will display:
::@(#)     
::@(#)     Error.001 - first error - Non fatal
::@(#)     // *Cause: Some error has occured (Continuing)
::@(#)     // *Action: What to do to prevent this error
::@(#)     // OR what action to take to clean up the mess
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
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  _GetOpt.cmd     Parse command line options and create environment vars
::@(#) 
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#)  _ErrorHandler
::@(#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@(#)  :$reference http://www.dostips.com/forum/viewtopic.php?t=369
::@(#)  :$created 20080512 :$changed 20080512
::@(#)  :$source http://www.dostips.com
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init Description [xx.xxx]
::SET $VERSION=2011-06-06&SET $REVISION=15:05:00&SET $COMMENT=Initial [01.000]
::SET $VERSION=2011-10-12&SET $REVISION=14:52:00&SET $COMMENT=Addional examples [01.001]
::SET $VERSION=2015-01-29&SET $REVISION=10:18:00&SET $COMMENT=Simplyfied adressing source file [^%~f1] [01.002]
::SET $VERSION=2015-02-19&SET $REVISION=03:08:00&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::EndLocal

:oerr
    :: Initiating global environment
::    CALL "%~dp0\_PreScript" %* || (CALL "%~dp0\_PostScript" & EXIT /B 1 )
    ECHO:
    Set _Lines=0
    IF EXIST "%~f1" (
        FOR /F "tokens=1*" %%A IN ('"Findstr /I /R /C:"^::#%~2[ ]" "%~f1""') DO (
            ECHO %%B
            CALL SET /A _lines+=1
        )
        :: Write dummy
        IF "0"=="!_lines!" (
            ECHO Error message not defined [%~1] [%~2]
            IF NOT "!"=="!%~3" ECHO %~3
        )
    ) ELSE (
        ECHO: Sorry! Script [%~1.*] not found in either %CD% or %~xp0
        ECHO: Syntax: %~n0 Name ErrorID
        ECHO: Like: %~n0 oerr Error.001
        IF NOT "!"=="!%~3" ECHO %~3
    )

    ECHO:
GOTO :EOF :oerr

:AdditionalHelp

::**********************************************************************
::* Error messages (like Oracle oerr)
::**********************************************************************
::#Error.000 Error.000 -- Nothing is wrong
::#Error.000 // *Cause: You caused it
::#Error.000 // *Action: Don't do it again
::-----------------------------------------------------------------------------------.......
::#Error.001 Error.001 - first error - Non fatal
::#Error.001 // *Cause: Some error has occured (Continuing)
::#Error.001 // *Action: What to do to prevent this error
::#Error.001 // OR what action to take to clean up the mess
::
::#Error.002 Error.002 - Second error - Non fatal w emailFatal
::#Error.002 // *Cause: Non fatal error - but sending email to Sysadm (Continuing)
::#Error.002 // *Action: What to do to prevent this error OR what action to take to 
::#Error.002 // clean up the mess when script has aborted
::
::#Error.003 Error.003 - Second error - Fatal
::#Error.003 // *Cause: Forced fatal error (Aborting)
::#Error.003 // *Action: What to do to prevent this error OR what action to take to 
::#Error.003 // clean up the mess when script has aborted.
::#Error.003 // Email send to Sysadm
::-----------------------------------------------------------------------------------.......
::#Error.xxx Error.xxx -- Template
::#Error.xxx // *Cause: 
::#Error.xxx // *Action: 
::-----------------------------------------------------------------------------------.......
::#Error.999 Error.999 -- *** ALARM^! ***
::#Error.999 // *Cause:  General System Failure
::#Error.999 // *Action: Abandon ship^!
::
::**********************************************************************

::*** End of File ******************************************************