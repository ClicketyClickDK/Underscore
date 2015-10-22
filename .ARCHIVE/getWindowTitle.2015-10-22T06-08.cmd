@ECHO OFF
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Return Window title + PID
SET $AUTHOR=Brian Williams
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)      %$Name% TitleVar PidVar
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@ (#)
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  SET _STR=%DATE% %TIME%
::@(#)  title %_STR%
::@(#)  SET _T=
::@(#)  call %$Name% _t _pid
::@(#)      
::@(#)      Instances...1
::@(#)          Command: GetWindowTitle
::@(#)              PID: 22716
::@(#)            Title: 30-03-2015 10:31:12,09 - call  GetWindowTitle _t _pid
::@(#)      DoubleClick: YES
::@(#)      SET _t=30-03-2015 10:31:12,09 - call  GetWindowTitle _t _pid
::@(#)      
::@(#)  echo [%_t%] [%_pid%]
::@(#)      [30-03-2015 10:31:12,09 - call  GetWindowTitle _t _pid] [22716]
::@(#)  
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)  0   OK
::@ (#)  1   Help or manual page 
::@ (#)  1+  Error
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
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@(#)  Author: brian williams
::@(#)  URL: http://www.robvanderwoude.com/files/gettitle_brianwilliams4.txt
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
::SET $VERSION=2010-02-14&SET $REVISION=00:00:00&SET $COMMENT=ErikBachmann / ECHO^. changed to ECHO: [01.000]
::SET $VERSION=2015-02-19&SET $REVISION=03:02:27&SET $COMMENT=Autoupdate / ErikBachmann
::SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
  SET $VERSION=2015-10-22&SET $REVISION=06:00:00&SET $COMMENT=Update usage / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

::1.0 Worked on Vista and 7
::1.1 Fixed IF statement for XP
::1.5 Fixed Prefix getting added to command prompt when run as Administator in UAC environments
::1.6 Attempt at getting to work on other versions of Windows
::1.7 Fix Random number
::1.9 Fix number collisions for finding self
::fix trailing spaces in comparision
::Works on XP, 2003, Vista, 7, Server 2008, Server 2008 R2
::ver 2.1
::http://www.robvanderwoude.com/files/gettitle_brianwilliams4.txt
:: 

::Brian Williams
::SETLOCAL ENABLEEXTENSIONS
::SETLOCAL ENABLEDELAYEDEXPANSION
::Let user note the current title
::PAUSE

::Get the command that initiated this script
SET _CMD=%0

CALL :GET-TITLE %_CMD% _PID _TITLE _DCLICK

::Output CMD, PID, and starting TITLE, pause for verificaiton
ECHO     Command: %_CMD%
ECHO         PID: %_PID%
ECHO       Title: %_TITLE%
ECHO DoubleClick: %_DCLICK%

::We were Doubclicked, pause to allow user to see results
::IF "%_DCLICK%" EQU "YES" PAUSE
ECHO SET %1=%_Title%
@ENDLOCAL&SET %1=%_Title%&SET %2=%_PID%
GOTO :END

:Get-Title
    SET _CMD=%1
    SET _RETURNPID=%2
    SET _RETURNTitle=%3
    SET _RETURNDoubleClick=%4
    SET _COUNT=0
        FOR /F "TOKENS=2 DELIMS=[]." %%A IN ('VER') DO SET _VERSION=%%A
        IF /I "%_VERSION%" EQU "VERSION 6" (
           FSUTIL>NUL
           IF !ERRORLEVEL! EQU 0 SET _UACADMIN=TRUE
           )

    ::Use tasklist to get a list of cmd.exe's and set variables where PIDs equal their titles
    REM FOR /F "TOKENS=2,10 DELIMS=," %%A IN ('TASKLIST /V /FI "IMAGENAME EQ CMD.EXE" /FO CSV /NH') DO SET %%~A=%%~B
        FOR /F "TOKENS=*" %%A IN ('TASKLIST /V /FI "IMAGENAME EQ CMD.EXE" /FO CSV /NH') DO (
           FOR %%B IN (%%A) DO (
              SET /A _POS+=1
              IF !_POS! EQU 2 SET _2=%%~B
              IF !_POS! EQU 9 SET _9=%%~B
              )
           SET _POS=0
           SET !_2!=!_9!
           )
    ::Create a random number and a static title based on that random number
    :DUPEKILLER
            PING -n %_COUNT% 127.0.0.1>nul 2>nul
                SET _COUNT=0
        FOR /F "TOKENS=*" %%A IN ("!TIME!") DO SET _RND=%%A
        SET _RND=%_RND::=%
        SET _RND=%_RND:.=%
        TITLE FIND ME %_RND%
        FOR /F "TOKENS=* DELIMS=," %%A IN ('TASKLIST /V /FI "IMAGENAME EQ CMD.EXE" /FO CSV /NH^|FIND "FIND ME %_RND%" /C') DO SET _COUNT=%%A
    ECHO Instances...%_COUNT% 
        IF %_COUNT% GTR 1 GOTO :DUPEKILLER
    ::Cycle through list of titles until we locate our PID, now we know our PID and we have the original title stored
    ::this means we also know our own title    
    FOR /F "TOKENS=2,8,* DELIMS=," %%A IN ('TASKLIST /V /FI "IMAGENAME EQ CMD.EXE" /FO CSV /NH') DO (
       ECHO %%C|FIND /I "FIND ME %_RND%">NUL && SET _MYPID=%%~A
       )
    SET _MYTITLE=!%_MYPID%!
    ::Get Length of our CMD and our Title, subtract 3 because of the CR LF chars that are in the output.
    ::NOTE* I did not come up with this method to get lengths, this is something I found on the internet in forums.
    FOR /F "TOKENS=1 DELIMS=:" %%A IN ('^(ECHO %_CMD% ^&ECHO:^)^|FINDSTR /O ".*"') DO SET /A _CMDLEN=%%A - 3
    FOR /F "TOKENS=1 DELIMS=:" %%A IN ('^(ECHO %_MYTITLE% ^&ECHO:^)^|FINDSTR /O ".*"') DO SET /A _TITLELEN=%%A - 3
    ::The title may contain our script name or it may not depending on whether it was double clicked or run in a cmd.exe window
    ::Pull out the possible CMD out of the title
    SET _SUFFIX=!_MYTITLE:~-%_CMDLEN%!

    ::Check to see if the chars pulled from the title match our cmd, if they do, get rid of that part
    ::If our command was double-clicked, we already have the TITLE, if we were run at the command prompt, we'll get rid of
    ::our command out of the title leaving what we started with.
    ::I have no idea why, but MYTITLE wouldn't expand in the ELSE section of the IF statement under XP only
    ::Setting to variable to something else allowed it to work, dunno....
    SET _TITLEFORXP=%_MYTITLE%
    SET /A _CMDLEN=%_CMDLEN% + 3
    IF "%_SUFFIX%" EQU "%_CMD%" (
        SET _MYTITLE=!_MYTITLE:~0,-%_CMDLEN%!
        SET /A _TITLELEN=%_TITLELEN% - %_CMDLEN%
        SET _DOUBLECLICK=NO
    ) Else (
        SET _DOUBLECLICK=YES
        SET _MYTITLE=%_TITLEFORXP%
    )
::    IF NOT DEFINED _UACADMIN (
::        TITLE %_MYTITLE%
::        SET %_RETURNPID%=%_MYPID%
::        SET %_RETURNTITLE%=%_MYTITLE%
::        SET %_RETURNDOUBLECLICK%=%_DOUBLECLICK%
::        GOTO :EOF
::    )

:RemAdmin
    ECHO "%_MYTITLE%"|FIND "Administrator: ">NUL && (
        IF "%_MYTITLE:~0,16%" EQU "Administrator:  " (
            SET _MYTITLE=%_MYTITLE:~16%
        ) ELSE (
            IF "%_MYTITLE:~0,15%" EQU "Administrator: " (
                SET _MYTITLE=%_MYTITLE:~15%
            )
        )
    )
    TITLE %_MYTITLE%
    SET %_RETURNPID%=%_MYPID%
    SET %_RETURNTITLE%=%_MYTITLE%
    SET %_RETURNDOUBLECLICK%=%_DOUBLECLICK%
    GOTO :EOF

:END

::*** End of File *****************************************************