@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Error handler for Robocopy
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
::@(#)      %$NAME% [errorlevel]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Display an error message, description of the cause and proposed action
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#) 
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
::@ (#)  
::@ (#)  
::@ (#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@ (#)  URL: http://ss64.com/nt/robocopy-exit.html
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
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm&SET $COMMENT=Description/init
::SET $VERSION=2015-02-19&SET $REVISION=00:00:00&SET $COMMENT=Initial/ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

:REPORT_ROBOCOPY_ERRORLEVEL

:: Don't mess with the internal Errorlevel OR the env.var
:: See: http://blogs.msdn.com/b/oldnewthing/archive/2008/09/26/8965755.aspx
    CALL SET _ErrorLevel=%~1
    CALL SET _Error=??
    CALL SET _ErrorMsg=*** Error code not defined [%~1] Unknown state ***

    CALL oerr "%~f0" "Error.%_errorlevel%"
GOTO :EOF
    ::GOTO :REPORT_ROBOCOPY_ERRORLEVEL.%_ErrorLevel%
::------------------------------------------------------------------
:: http://ss64.com/nt/robocopy-exit.html
:: 
:: The return code from Robocopy is a bit map, defined as follows:
:: 
::     Hex   Decimal  Meaning if set
::     0×10  16       Serious error. Robocopy did not copy any files.
::                    Either a usage error or an error due to insufficient access privileges
::                    on the source or destination directories.
:: 
::     0×08   8       Some files or directories could not be copied
::                    (copy errors occurred and the retry limit was exceeded).
::                    Check these errors further.
:: 
::     0×04   4       Some Mismatched files or directories were detected.
::                    Examine the output log. Some housekeeping may be needed.
:: 
::     0×02   2       Some Extra files or directories were detected.
::                    Examine the output log for details. 
:: 
::     0×01   1       One or more files were copied successfully (that is, new files have arrived).
:: 
::     0×00   0       No errors occurred, and no copying was done.
::                    The source and destination directory trees are completely synchronized. 
:: 

::**********************************************************************
::* Error messages (like Oracle oerr)
::**********************************************************************
::#Error.000 Error.000 -- Template
::#Error.000 // *Cause: 
::#Error.000 // *Action: 
::---------------------------------------------------------------------
::#Error.16 Error.16 - Backup has failed - Fatal
::#Error.16 // *Cause: FATAL ERROR. Robocopy did not copy any files
::#Error.16 // *Action: Either a usage error or an error due to insufficient 
::#Error.16 //    access privileges on the source or destination directories.
::#Error.16 //    Refer to log file and system log for more details
::---------------------------------------------------------------------
::#Error.15 Error.15 - Backup not valid - Non Fatal
::#Error.15 // *Cause: OKCOPY + FAIL + MISMATCHES + XTRA
::#Error.15 //    Some files were copied
::#Error.15 //    Several files did not copy
::#Error.15 //    Some files were mismatched. 
::#Error.15 //    Additional files were present. 
::#Error.15 // *Action: 
::#Error.15 //    Refer to log file and system log for more details
::---------------------------------------------------------------------
::#Error.14 Error 14 - Backup not valid - Non Fatal
::#Error.14 // *Cause: FAIL + MISMATCHES + XTRA
::#Error.14 //    Several files did not copy
::#Error.14 //    Some files were mismatched. 
::#Error.14 //    Additional files were present. 
::#Error.14 // *Action: 
::#Error.14 //    Refer to log file and system log for more details
::---------------------------------------------------------------------
::#Error.13 Error.13 - Copy w. failure - Non Fatal
::#Error.13 // *Cause: OKCOPY + FAIL + MISMATCHES
::#Error.13 //    Some files were copied. 
::#Error.13 //    Several files did not copy
::#Error.13 //    Some files were mismatched. 
::#Error.13 // *Action: 
::#Error.13 //    Refer to log file and system log for more details
::---------------------------------------------------------------------
::#Error.12 Error.12 - Copy w. failure - Non Fatal
::#Error.12 // *Cause: FAIL + MISMATCHES
::#Error.12 //    Several files did not copy
::#Error.12 //    Some files were mismatched. 
::#Error.12 // *Action: 
::#Error.12 //    Refer to log file and system log for more details
::---------------------------------------------------------------------
::#Error.11 Error.11 - Copy w. failure - Fatal
::#Error.11 // *Cause: OKCOPY + FAIL + XTRA
::#Error.11 //    Some files were copied. 
::#Error.11 //    Several files did not copy
::#Error.11 //    Additional files were present. 
::#Error.11 // *Action:
::#Error.11 //    Refer to log file and system log for more details
::---------------------------------------------------------------------
::#Error.10 Error.10 - Copy w. failure - Fatal
::#Error.10 // *Cause: FAIL + XTRA
::#Error.10 //    Several files did not copy
::#Error.10 //    Additional files were present. 
::#Error.10 // *Action: 
::#Error.10 //    Refer to log file and system log for more details
::---------------------------------------------------------------------
::#Error.9 Error.9 - Copy w. failure - Fatal
::#Error.9 // *Cause: OKCOPY + FAIL
::#Error.9 //    Some files were copied. 
::#Error.9 //    Several files did not copy
::#Error.9 // *Action: 
::#Error.9 //    Refer to log file and system log for more details
::---------------------------------------------------------------------
::#Error.8 Error.8 - Failures - Fatal
::#Error.8 // *Cause: FAIL
::#Error.8 //    Some files or directories could not be copied
::#Error.8 //    (copy errors occurred and the retry limit was exceeded).
::#Error.8 // *Action: Several files did not copy
::#Error.8 //    Check these errors further.
::#Error.8 //    Refer to log file and system log for more details
::---------------------------------------------------------------------
::#Error.7 Error.7 - Copy w. mismatch - Non fatal 
::#Error.7 // *Cause: OKCOPY + MISMATCHES + XTRA
::#Error.7 // *Action: Files were copied, a file mismatch was present,
::#Error.7 //  and additional files were present
::#Error.7 //    Refer to log file and system log for more details
::---------------------------------------------------------------------
::#Error.6 Error 6 - Copy failed - Non fatal
::#Error.6 // *Cause: MISMATCHES + XTRA
::#Error.6 // *Action: Additional files and mismatched files exist.
::#Error.6 //    No files were copied and no failures were encountered.
::#Error.6 //    This means that the files already exist in the destination directory.
::#Error.6 //    Refer to log file and system log for more details
::---------------------------------------------------------------------
::#Error.5 Error 5 - Copy mismatched - Non fatal
::#Error.5 // *Cause: OKCOPY + MISMATCHES
::#Error.5 // *Action: Some files were copied. 
::#Error.5 // Some files were mismatched. 
::#Error.5 // No failure was encountered
::#Error.6 //    Refer to log file and system log for more details
::---------------------------------------------------------------------
::#Error.4 Error 4 - Mismatch in copy - Non Fatal 
::#Error.4 // *Cause: MISMATCHES
::#Error.4 //    Some Mismatched files or directories were detected.
::#Error.4 // *Action: Examine the output log. 
::#Error.4 //    Some housekeeping may be needed.
::#Error.6 //    Refer to log file and system log for more details
::---------------------------------------------------------------------
::#Error.3 Error 3 - Files copied w. extra - Success
::#Error.3 // *Cause: OKCOPY + XTRA
::#Error.3 // *Action: Some files were copied. 
::#Error.3 // Additional files were present. 
::#Error.3 // No failure was encountered.
::---------------------------------------------------------------------
::#Error.2 Error 2 - More files in Source - Non Fatal
::#Error.2 // *Cause: XTRA
::#Error.2 //    There are some additional files in the destination 
::#Error.2 //    directory that are not present in the source directory. 
::#Error.2 // *Action: 
::#Error.2 //    No files were copied.
::#Error.6 //    Refer to log file and system log for more details
::---------------------------------------------------------------------
::#Error.1 Error 1 - Copy OK - Success
::#Error.1 // *Cause: OKCOPY
::#Error.1 //    All files were copied successfully
::#Error.1 // *Action: No action needed
::#Error.1 //    No failure was encountered.
::---------------------------------------------------------------------
::#Error.0 Error.0 - No change - Success
::#Error.0 // *Cause: No files were copied.
::#Error.0 //    No failure was encountered. No files were mismatched.
::#Error.0 //    The files already exist in the destination directory;
::#Error.0 //    therefore, the copy operation was skipped.
::#Error.1 // *Action: No action needed
::#Error.1 //    No failure was encountered.
::---------------------------------------------------------------------

::*** End of File ******************************************************