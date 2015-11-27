@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Backup with progressbar using RoboCopy
SET $AUTHOR=bluesxman
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)  %$Name% [Arguments]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)
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
::@ (#)  URL: http://ss64.org/viewtopic.php?pid=4176
::@(#)  
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
::SET $VERSION=2010-10-20&SET $REVISION=00:00:00&SET $COMMENT=Initial [01.000]
::SET $VERSION=2015-02-19&SET $REVISION=03:11:23&SET $COMMENT=Autoupdate / ErikBachmann
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
  SET $VERSION=2015-11-10&SET $REVISION=22:16:00&SET $COMMENT=/ZB requires admin rights / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

:MAIN
    CALL :Init %*
    CALL :Process
    CALL :Finalize
GOTO :EOF

::---------------------------------------------------------------------

:init
::    SET "source=C:\tmp\testdir"
::    SET "target=C:\tmp\newdir"

    ECHO %$NAME% v. %$VERSION% - %$DESCRIPTION%

    SET "source=%~1 "
    SET "target=%~2"

    IF NOT DEFINED Target (
        ECHO %0 source target
        EXIT /b 1
    )
    IF NOT EXIST "%source%" (
        ECHO Source does not exist [%Source%]
        EXIT /b 2
    )

    SET "rc=robocopy.exe"
    SET "rc.command=%rc% "%source%." "%target%." /s"

    SET "_timestamp=%date%T%time:~0,8%"
    SET "_timestamp=%_timestamp::=-%"
    SET "_timestamp=%_timestamp: =0%"

    SET "rc.logFile=%TMP%\%rc%.%_timestamp%.log.txt"
    SET "rc.TraceFile=%TMP%\%rc%.%_timestamp%.trace.txt"
    >"%rc.TraceFile%" ECHO Starting %Date% %Time%
    SET "_fileFlag=File"

    ::                 /Z :: copy files in resume mode in case network connection is lost
    ::                 /E :: Copy directory recursively
    ::           /COPYALL :: copy all file information (, equivalent to /COPY:DATSOU, D=Data, A=Attributes, T=Timestamps,
    ::               /R:0 :: do not retry locked files
    ::           /DCOPY:T :: preserve original directories' Timestamps
    ::                /ZB :: use restartable mode; if access denied use Backup mode.
    ::                /NP :: No Progress - don't display percentage copied.
    ::                /XJ :: eXclude Junction points. (normally included by default).
    ::                /SL :: copy symbolic links versus the target.
    SET _RobocopyArg=/COPY:DAT /E /R:0 /DCOPY:T /ZB /NP /SL /XJ
    SET _RobocopyArg=/COPY:DAT /E /R:0 /DCOPY:T /NP /SL /XJ

    ::                 /X :: Reports all extra files, not just those that are selected.
    ::                 /V :: Produces verbose output, and shows all skipped files.
    ::                /TS :: Includes source file time stamps in the output.
    ::                /FP :: Includes the full path names of the files in the output.
    ::             /BYTES :: Prints sizes, as bytes.
    SET _RobocopyLog=/X /V /TS /LOG:%rc.logFile%

    :: /L   List
    :: /NJH :: Specifies that there is no job header.
    :: /NFL :: Specifies that file names are not to be logged.
    :: /NDL :: Specifies that directory names are not to be logged.
    :: /W:1 /R:0 Don't wait and don't try again
    SET "_rc.statusArg=/l /njh /nfl /ndl /W:0 /R:0"

    ::Define CR variable containing a carriage return (0x0D)
    FOR /F %%a IN ('COPY /Z "%~dpf0" NUL') DO SET "CR=%%a"

    ::define a Line Feed (newline) string (normally only used as !LF!)
    SET LF=^

    ::Above 2 blank lines are required - do not remove


    REM make the bar as wide as possible
    ::for /f "usebackq tokens=2" %%a in (`mode con ^| find "Columns:"`) do set /a bar.width=%%a - 3
    ::for /f "usebackq tokens=2" %%a in (`mode con ^| find "ol"`) do set /a bar.width=%%a - 3

    REM or you can force the width on the next line (no sanity checking is done on this value)
    REM set "bar.width=40"
    SET bar.width=50

    :: Dots
    set "bar.char=þ"
    set "bar.backchar=ú"
    
    :: Semigraphic squares
    ::set "bar.char=Û"
    ::set "bar.backchar=°"
    
    :: Underscor / #
    ::SET "bar.char=#"
    ::SET "bar.backchar=_"
    SET "bar.size=0"
    SET "bar.back="
    SET "bar.del="
    SET "bar.position=0"
    SET "bar.position.modifier=0"
    SET "bar.check=0"
    SET "loop.delay=1"

    SET "done=0"
    SET "total=-1"
    SET "abort="
    SET >>"%rc.TraceFile%"
GOTO :EOF :init

::---------------------------------------------------------------------

:Process
    SET "window.title=%rc%_%date%_%time: =0%"

    ECHO:START [%source%]-^>[%target%]
    
    SET /P "out=Counting files..!CR!" <NUL
    REM spawn the robocopy command with a (hopefully) unique window title that we'll need later
    ::start /min "%window.title%" %rc.command% /LOG:%rc.logFile% /NP %_RobocopyArg% %_RobocopyLog%
    START /min "%window.title%" %rc.command% %_RobocopyArg% %_RobocopyLog%

    REM find the total number of files, so we can shrink the bar to fit the total, if necessary
    FOR /F "usebackq tokens=3,4,5 delims= " %%a in (`%rc.command% %_rc.statusArg% ^| find "%_fileFlag%"`) do (
        set /a "total=%%a,done=%%c"
    )

    set /a "bar.check=bar.width / total" 2>nul
    set /a "bar.check=%bar.width% / %total%" 2>nul

    if %bar.check% EQU 1 set /a bar.width=total

    REM draw the empty bar 
    for /l %%a in (1,1,%bar.width%) do (call set "bar.back=%%bar.back%%%bar.backchar%")
    call set "bar.del=%%bar.back:%bar.backchar%=%%"
    set /p "out=[%bar.back%]%bar.del%!CR!" <nul

    set /a loop.delay+=1

    title Please stand by

    call :loop
GOTO :EOF :: :process

::---------------------------------------------------------------------

:Finalize
    echo:
    if defined abort (
        echo:ABORT
        start notepad "%rc.logfile%"
    ) ELSE (
        title - Checking logfile..
        rem CALL :Wait
        echo: DONE - Checking logfile
        ECHO: [%rc.logFile%]
        CALL :tail "%rc.logFile%" 10
        
        ECHO:
        CHOICE /T 10 /C ny /D n /M "Want to see the log file?"
        IF ERRORLEVEL 2 (
            if exist "%~dp0\Notepad-eof.vbs" (
                start Cscript //NoLogo "%~dp0\Notepad-eof.vbs" "%rc.logFile%"
            ) ELSE (
                start notepad "%rc.logFile%"
            )
        )
    )
    TITLE %$NAME% - Done
    :: Delay without waiting for keypress
    rem CALL :Wait
goto :EOF :Finalize

::---------------------------------------------------------------------

:wait
    ping 1.1.1.1 -n %loop.delay% -w 1000 >nul
GOTO :EOF :WAIT

::---------------------------------------------------------------------

:loop
    set bar=
    REM if all the files have been copied, draw a full bar (in case it didn't get filled
    REM on the previous iteration) and exit
    if %done% GEQ %total% (
        title %done% / %total%
        for /l %%a in (1,1,%bar.width%) do call set "bar=%bar.char%%%bar%%"
        call set /p "out=[%%bar%%]  %done% / %total%!CR!" <nul
        CALL set abort=
        goto :EOF
    )

    REM if the robocopy child process wasn't running on the previous iteration and there
    REM are still files left uncopied then we assume that robocopy died unexpectedly
    IF DEFINED abort GOTO :EOF

    REM check for the robocopy child process (using out "unique" window title)
    ::tasklist /fi "imagename eq robocopy.exe" /fi "windowtitle eq %window.title%" /fo csv /nh 2>nul | findstr "." >nul
    tasklist /fi "imagename eq robocopy.exe" /fi "windowtitle eq %window.title%" /fo csv /nh 2>nul | findstr "Console" >nul

    REM if it's not found, set a flag (it'll be dealt with on the next interation)
    if errorlevel 1 set abort=1 & set loop.delay=1

    REM run a duplicate robocopy process with the "/L" switch to so we can extract
    REM the total number of files and those that have been copied from the output
    ::for /f "usebackq tokens=3,4,5 delims= " %%a in (`%rc.command% /l /njh /nfl /ndl ^| find "Files"`) do (
    ::%rc.command% /l /njh /nfl /ndl
    :: | find "%_fileFlag%"
    for /f "usebackq tokens=3,4,5 delims= " %%a in (`%rc.command% %_rc.statusArg% ^| find "%_fileFlag%"`) do (
        REM set /a "remain=%%b,done=%%c"
        set /a "remain=%%a,done=%%b"
    )

    REM figure out (roughly) how many files need to be copied to increase the progress
    REM bar by one step
    set /a bar.step=(total / bar.width) - 1

    REM in case its less than one...
    if %bar.step% LEQ 0 set bar.step=1

    REM calculate the bar modifier, which takes effect if the total number of files
    REM is significantly lower than the bar width.
    set /a bar.position.modifier=bar.width / total

    if %bar.position.modifier% LEQ 0 set /a bar.position.modifier=1

    REM calculate the position using the number of copied files and the step value
    set /a bar.position=(done / bar.step) * bar.position.modifier

    REM if for some reason the position is greater than the width, fix it
    REM (this would occur if the number of files is not much more than
    REM the defined bar width)
    if %bar.position% GTR %bar.width% set /a bar.position=bar.width

    REM draw the bar (we're redrawing the whole thing on each interation)
    for /l %%a in (1,1,%bar.position%) do call set "bar=%bar.char%%%bar%%"
    for /l %%a in (%bar.position%,1,%bar.width%) do call set "bar=%%bar%%%bar.backchar%"

    set /p "out=[%bar:~0,-1%] %done% / %total%!CR!" <nul 

    title %done% / %total%

    REM delay before interating so that the script doesn't thrash the system
    CALL :WAIT
goto :loop

::---------------------------------------------------------------------

:Tail
    SETLOCAL
::@ (#)Tail.cmd
::@ (#)  Print the last n lines of a file to STDOUT
::@ (#) 
::@ (#)  tail [File] [n]
::@ (#) 
::@ (#)  n = Number of lines to print, default=10
::@ (#) 
::@ (#) URL=http://ss64.org/viewtopic.php?id=506
::*********************************************************************
    Set tmpFile=%temp%\~tail.txt
    IF EXIST %tmpFile% DEL %tmpFile%
    Set _lines_wanted=%~2

    If [%_lines_wanted%]==[] SET /A _lines_wanted=10
    FindStr /r .* "%~1" >%tmpFile%
    For /F "tokens=1 delims=:" %%G in ('findstr /nr ".*" %tmpFile%') Do (Set _num_lines=%%G)

    ECHO:
    ECHO:Line : %skip% - %_num_lines%
    ECHO:

    Set /A skip=_num_lines-_lines_wanted
    If /I %skip% LEQ 0 Set skip=0

    MORE /E +%skip% %tmpFile%
    Del %tmpFile%
GOTO :EOF :Tail

::*** End of File *****************************************************