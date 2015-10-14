

::----------------------------------------------------------------------

:_UnitTest__report_robocopy_errorlevel
SETLOCAL

    SHIFT
    
    :: Create ref
    (
        CALL :ref %0
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        ECHO OFF
        FOR /L %%a IN (0,1,18) DO (
            CALL %0 %%a
        )
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest__report_robocopy_errorlevel ***

::----------------------------------------------------------------------

:ref
ECHO:
ECHO:Error.0 - No change - Success
ECHO:// *Cause: No files were copied.
ECHO://    No failure was encountered. No files were mismatched.
ECHO://    The files already exist in the destination directory;
ECHO://    therefore, the copy operation was skipped.
ECHO:
ECHO:
ECHO:Error 1 - Copy OK - Success
ECHO:// *Cause: OKCOPY
ECHO://    All files were copied successfully
ECHO:// *Action: No action needed
ECHO://    No failure was encountered.
ECHO:// *Action: No action needed
ECHO://    No failure was encountered.
ECHO:
ECHO:
ECHO:Error 2 - More files in Source - Non Fatal
ECHO:// *Cause: XTRA
ECHO://    There are some additional files in the destination 
ECHO://    directory that are not present in the source directory. 
ECHO:// *Action: 
ECHO://    No files were copied.
ECHO:
ECHO:
ECHO:Error 3 - Files copied w. extra - Success
ECHO:// *Cause: OKCOPY + XTRA
ECHO:// *Action: Some files were copied. 
ECHO:// Additional files were present. 
ECHO:// No failure was encountered.
ECHO:
ECHO:
ECHO:Error 4 - Mismatch in copy - Non Fatal 
ECHO:// *Cause: MISMATCHES
ECHO://    Some Mismatched files or directories were detected.
ECHO:// *Action: Examine the output log. 
ECHO://    Some housekeeping may be needed.
ECHO:
ECHO:
ECHO:Error 5 - Copy mismatched - Non fatal
ECHO:// *Cause: OKCOPY + MISMATCHES
ECHO:// *Action: Some files were copied. 
ECHO:// Some files were mismatched. 
ECHO:// No failure was encountered
ECHO:
ECHO:
ECHO:Error 6 - Copy failed - Non fatal
ECHO:// *Cause: MISMATCHES + XTRA
ECHO:// *Action: Additional files and mismatched files exist.
ECHO://    No files were copied and no failures were encountered.
ECHO://    This means that the files already exist in the destination directory.
ECHO://    Refer to log file and system log for more details
ECHO://    Refer to log file and system log for more details
ECHO://    Refer to log file and system log for more details
ECHO://    Refer to log file and system log for more details
ECHO:
ECHO:
ECHO:Error.7 - Copy w. mismatch - Non fatal 
ECHO:// *Cause: OKCOPY + MISMATCHES + XTRA
ECHO:// *Action: Files were copied, a file mismatch was present,
ECHO://  and additional files were present
ECHO://    Refer to log file and system log for more details
ECHO:
ECHO:
ECHO:Error.8 - Failures - Fatal
ECHO:// *Cause: FAIL
ECHO://    Some files or directories could not be copied
ECHO://    (copy errors occurred and the retry limit was exceeded).
ECHO:// *Action: Several files did not copy
ECHO://    Check these errors further.
ECHO://    Refer to log file and system log for more details
ECHO:
ECHO:
ECHO:Error.9 - Copy w. failure - Fatal
ECHO:// *Cause: OKCOPY + FAIL
ECHO://    Some files were copied. 
ECHO://    Several files did not copy
ECHO:// *Action: 
ECHO://    Refer to log file and system log for more details
ECHO:
ECHO:
ECHO:Error.10 - Copy w. failure - Fatal
ECHO:// *Cause: FAIL + XTRA
ECHO://    Several files did not copy
ECHO://    Additional files were present. 
ECHO:// *Action: 
ECHO://    Refer to log file and system log for more details
ECHO:
ECHO:
ECHO:Error.11 - Copy w. failure - Fatal
ECHO:// *Cause: OKCOPY + FAIL + XTRA
ECHO://    Some files were copied. 
ECHO://    Several files did not copy
ECHO://    Additional files were present. 
ECHO:// *Action:
ECHO://    Refer to log file and system log for more details
ECHO:
ECHO:
ECHO:Error.12 - Copy w. failure - Non Fatal
ECHO:// *Cause: FAIL + MISMATCHES
ECHO://    Several files did not copy
ECHO://    Some files were mismatched. 
ECHO:// *Action: 
ECHO://    Refer to log file and system log for more details
ECHO:
ECHO:
ECHO:Error.13 - Copy w. failure - Non Fatal
ECHO:// *Cause: OKCOPY + FAIL + MISMATCHES
ECHO://    Some files were copied. 
ECHO://    Several files did not copy
ECHO://    Some files were mismatched. 
ECHO:// *Action: 
ECHO://    Refer to log file and system log for more details
ECHO:
ECHO:
ECHO:Error 14 - Backup not valid - Non Fatal
ECHO:// *Cause: FAIL + MISMATCHES + XTRA
ECHO://    Several files did not copy
ECHO://    Some files were mismatched. 
ECHO://    Additional files were present. 
ECHO:// *Action: 
ECHO://    Refer to log file and system log for more details
ECHO:
ECHO:
ECHO:Error.15 - Backup not valid - Non Fatal
ECHO:// *Cause: OKCOPY + FAIL + MISMATCHES + XTRA
ECHO://    Some files were copied
ECHO://    Several files did not copy
ECHO://    Some files were mismatched. 
ECHO://    Additional files were present. 
ECHO:// *Action: 
ECHO://    Refer to log file and system log for more details
ECHO:
ECHO:
ECHO:Error.16 - Backup has failed - Fatal
ECHO:// *Cause: FATAL ERROR. Robocopy did not copy any files
ECHO:// *Action: Either a usage error or an error due to insufficient 
ECHO://    access privileges on the source or destination directories.
ECHO://    Refer to log file and system log for more details
ECHO:
ECHO:
ECHO:Error message not defined [%_scriptDir%%~1] [Error.17]
ECHO:
ECHO:
ECHO:Error message not defined [%_scriptDir%%~1] [Error.18]
ECHO:
GOTO :EOF