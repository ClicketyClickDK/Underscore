@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Get duration of a command
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
::@(#)      %$NAME% [VAR]
::@(#)      %$NAME% [flag]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h          Help
::@(#)  --help      Help
::@(#)  --selftest  Simple selftest testing various combinations of date strings
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Give a command (with parameters) as argument and get a messured duration 
::@(#)  of the runtime after output from the command
::@(#)  
::@(#)  This function mimics the UNIX commands time or times. Since time is
::@(#)  a build in command in Windows, the name times is prefered.
::@(#)  A simple solution of messuring the duration is printing date and 
::@(#)  time before and after calling the command in question.
::@(#)  The precision is pretty low (seconds) and some calculation is required.
::@(#)  Windows CAN actually provide you with a time stamp, that includes milliseconds.
::@(#)  But the overhead in batch scripting makes this a bit irrelevant (sic)
::@(#)  However - this is function does provide a duration of a command - in milliseconds
::@(#)  
::@(#)  This function uses a call to WMIC getting a timestamp including 
::@(#)  milliseconds (6 digits).
::@(#)  Output is duration in hours, minutes, seconds and milliseconds.
::@(#)  If duration lasts more than a day - or from one day to the next
::@(#)  the function indicates this by a no of hours larger than 23 like:
::@(#)      End  [20151120082435.630000+060]
::@(#)      Start[20151119075906.977000+060]
::@(#)      eDiff[1528653]
::@(#)      iDiff[24:25:28.653]
::@(#)  
::@(#)SEE ALSO
::@(#)  duration.cmd
::@(#)  powershell -Command "Measure-Command {echo hi | Out-Default}"
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      times dir /s/b
::@(#)  Produces a list of files followed by timing of runtime:
::@(#)      Start       [20151119161240.177000+060]
::@(#)      End         [20151119161240.585000+060]
::@(#)      Milliseconds[408]
::@(#)      Duration    [00:00:00.408]
::@(#)  
::@(#)  Used in combination with duration:
::@(#)    @ECHO OFF
::@(#)    SETLOCAL
::@(#)        ECHO Show difference between "dir /s" and "dir /s/b
::@(#)        ECHO:: Initial call = start global timer
::@(#)        CALL duration _starttime
::@(#)        ECHO:
::@(#)        ECHO:: Time the DIR command /S /B
::@(#)        CALL times dir /s/b>nul
::@(#)        ECHO:
::@(#)        ECHO:: Show total duration - so far
::@(#)        CALL duration _starttime
::@(#)        ECHO:
::@(#)        ECHO:: Time the DIR command /S
::@(#)        CALL times dir /s>nul
::@(#)        ECHO:
::@(#)        ECHO Total
::@(#)        CALL duration _starttime
::@(#)    ENDLOCAL
::@(#)  
::@(#)  Produces:
::@(#)    Show difference between "dir /s" and "dir /s/b
::@(#)    : Initial call = start global timer
::@(#)    _starttime                               [20151120164109.826000+060       ]
::@(#)    
::@(#)    : Time the DIR command /S /B
::@(#)    Start                                    [20151120164111.085000+060       ]
::@(#)    End                                      [20151120164111.430000+060       ]
::@(#)    Milliseconds                             [345                             ]
::@(#)    Duration                                 [00:00:00.345                    ]
::@(#)    
::@(#)    : Show total duration - so far
::@(#)    Start                                    [20151120164109.826000+060       ]
::@(#)    End                                      [20151120164114.770000+060       ]
::@(#)    Milliseconds                             [4944                            ]
::@(#)    Duration                                 [00:00:04.944                    ]
::@(#)    
::@(#)    
::@(#)    : Time the DIR command /S
::@(#)    Start                                    [20151120164118.438000+060       ]
::@(#)    End                                      [20151120164118.801000+060       ]
::@(#)    Milliseconds                             [363                             ]
::@(#)    Duration                                 [00:00:00.363                    ]
::@(#)    
::@(#)    Total
::@(#)    Start                                    [20151120164109.826000+060       ]
::@(#)    End                                      [20151120164122.191000+060       ]
::@(#)    Milliseconds                             [12365                           ]
::@(#)    Duration                                 [00:00:12.365                    ]
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
::@(#)  _Action.cmd     Action part of _action / _status line 
::@(#)  _Status.cmd     Status part of _action / _status line 
::@(#) 
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#)  Duration.cmd        Get duration between to time stamps
::@(#)  compareDuration.cmd Compare duration of two operations
::@ (#)  
::@ (#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Description/init
  SET $VERSION=2015-11-19&SET $REVISION=16:10:00&SET $COMMENT=Initial/ErikBachmann
::**********************************************************************
::@(#){COPY}%$VERSION:~0,4% %$Author%
::**********************************************************************
::ENDLOCAL

:main
    call "%~dp0\_debug"
    ::call "%~dp0\_getopt" %*
    ::IF DEFINED @%$NAME%.selftest CALL :SelfTest & EXIT /b 2
    ECHO:%*| findstr "\<[-/]*h\> \<[-/]*help\>" >nul 2>&1 & IF NOT ERRORLEVEL 1 CALL what "%$Source%" & EXIT /b 0 
    ECHO:%*| findstr "\<[-/]*selftest\>" >nul 2>&1 & IF NOT ERRORLEVEL 1 CALL :SelfTest & EXIT /b 0 
    
    CALL :setTime _start
    CMD /C %*
    CALL :finalize "%_start%" "_end"
GOTO :EOF

::---------------------------------------------------------------------

:finalize
    SET _start=%~1
    SET _end=%~2

    CALL :setTime %2
    call :iso2epoc %_start% _epocStart
    call :iso2epoc %_end% _epocend
    SET /A _epocDiff=%_epocend% - %_epocStart%

    REM %_VERBOSE_%:Start       [%_start%]
    REM %_VERBOSE_%:End         [%_end%]
    REM %_VERBOSE_%:Milliseconds[%_epocDiff%]
    1>&2 CALL _Action Start
    1>&2 CALL _Status "%_start%"
    1>&2 CALL _Action End
    1>&2 CALL _Status "%_end%"
    1>&2 CALL _Action Milliseconds
    1>&2 CALL _Status "%_epocDiff%"

    CALL :calc.date dDiff %_start:~0,4%-%_start:~4,2%-%_start:~6,2% %_end:~0,4%-%_end:~4,2%-%_end:~6,2%   
    CALL :epoc2iso _iso %_epocDiff% %dDiff%

    REM %_VERBOSE_%:Duration    [%_iso%]
    1>&2 CALL _Action Duration
    1>&2 CALL _Status "%_iso%"
GOTO :EOF

::---------------------------------------------------------------------

:epocDiff _epocDiff _Start _End
    SETLOCAL
        call :iso2epoc %2 _epocStart
        call :iso2epoc %3 _epocend
        SET /A _epocDiff=%_epocend% - %_epocStart%
    ENDLOCAL&SET %~1=%_epocDiff%
GOTO :EOF

::---------------------------------------------------------------------

:setTime
    FOR /f %%a in ('WMIC OS GET LocalDateTime ^| find "."') DO set %~1=%%a
GOTO :EOF

::---------------------------------------------------------------------

:iso2epoc _start _epocStart
SETLOCAL
    SET DTS=%~1
    
    :: Testing input for a valid ISO string syntax
    ::               20151118230958.215000+060
    ::                 Y    Y    Y    Y    M    M    D    D    h    h    m    m    s    s      mi   mi   mi   mi   mi   mi
  ::SET _testPattern=^[1-2][0,9][0-9][0-9][0-1][0-9][0-3][0-9][0-2][0-9][0-5][0-9][0-5][0-9]\.[0-9][0-9][0-9][0-9][0-9][0-9]
    SET _testPattern=^[1-2][0,9][0-9][0-9][0-1][0-9][0-3][0-9][0-2][0-9][0-5][0-9][0-5][0-9]\.[0-9]*
    ECHO:%DTS%|FINDSTR "%_testPattern%" >nul 2>&1
    IF ErrorLevel 1 ECHO:Not a valid ISO time stamp: [%DTS%]&EXIT /B 2
    SET eTime=0

    :: Calc seconds
    ::Seconds
    SET _Sec=%DTS:~12,2%
    SET /a _Sec=(1%_sec% - 100) %% 60
        ::SET _SEC
        ::SET /a eTime+=(1%DTS:~12,2% - 100)
    :: Minutes
    ::SET /a eTime+=((1%DTS:~10,2% -100) * 100)
    SET _Min=%DTS:~10,2%
    SET /A _Min=((1%_min% - 100) * 60)
    :: Hours
        ::SET /a eTime+=((1%DTS:~8,2% -100) * 60 * 100)
    SET _Hour=%DTS:~8,2%
    SET /A _Hour=((1%_hour% - 100) * 60 * 60)
    
    SET /A eTime=%_hour% + %_min% + %_sec%

    :: Milliseconds
    SET _mill=%DTS:~15,3%
    :: remove leading 0 (Octal)
    SET /A _mill=1%_Mill% - 1000
    
    :: Add milliseconds
    SET /a eTime=(%eTime% * 1000) + %_mill%
ENDLOCAL&SET %~2=%eTime%
GOTO :EOF
    
::---------------------------------------------------------------------

:epoc2iso1 _epoc _iso
SETLOCAL
    SET eTime=000%~1
    SET /a _milli=(( 1%eTime:~-4% - <1000 ) %% 1000 ) + 1000

    SET _SEC=%etime:~-8,-3%
    SET /A _SEC=1%_sec% %% 100000
    
    %_DEBUG_%:- _eTime[%eTime%] _sec=%_sec%  _Milli=%_milli% %etime:~0,-3%
    SET /A _hour=100 + (%_sec% / 3600)

    SET /A _min=100 + ((%_sec% %% 3600) / 60)
    
    SET /A _SEC=%_SEC% %% 60
    SET _SEC=100%_sec%
    %_DEBUG_%:- hour[%_hour%] min[%_min%] sec[%_sec%] %_sec:~-2% etime:%etime%
ENDLOCAL&SET %~2=%_hour:~-2%:%_min:~-2%:%_sec:~-2%.%_Milli:~-3%
GOTO :EOF

::---------------------------------------------------------------------

:epoc2iso _epoc _iso
SETLOCAL
    SET jTime=%~2
    SET dDiff=%~3

    IF 0 GTR %jTime% SET /A jTime=86400000 + %jTime%
    SET /A jTime+=(86400000 * %dDiff%)

    ::  =HELTAL((G3/1000)/3600)
    SET /A _Hour=(%jTime% / 1000) / 3600
    
    ::=REST(HELTAL((G3/1000)/60);60)
    SET /A _Min=((%jTime% / 1000) / 60) %% 60

    ::=REST(HELTAL(G3/1000); 60)
    SET /A _Sec=(%jTime% / 1000 ) %% 60

    ::=REST(G3; 1000)
    SET /A _Mill=%jTime% %% 1000

    :: Leading 0
    FOR %%i IN (_min _sec _mill) DO SET %%i=0!%%i!
    FOR %%i IN (_mill) DO SET %%i=0!%%i!
    IF 10 GTR %_hour% SET _hour=0%_hour%

    %_DEBUG_%:- hour[%_hour%] min[%_min%] sec[%_sec%] Mil:%_Mill% - %jTime%
ENDLOCAL&SET %~1=%_hour%:%_min:~-2%:%_sec:~-2%.%_Mill:~-3%
GOTO :EOF

::---------------------------------------------------------------------

:calc.date
SETLOCAL
    SET _sdate=%~2
    SET _edate=%~3

    CALL date2jdate _sjd %_sdate%
    CALL date2jdate _ejd %_edate%

    SET /A _djd=%_ejd% - %_sjd%

ENDLOCAL&SET %~1=%_djd%
GOTO :EOF

::---------------------------------------------------------------------

:: Run one iteration of test
:selfTest.sub
    call :iso2epoc %_start% _epocStart
    call :iso2epoc %_end% _epocend
    
    call :calc.date dDiff %_start:~0,4%-%_start:~4,2%-%_start:~6,2% %_end:~0,4%-%_end:~4,2%-%_end:~6,2% 
    
    SET /A _epocDiff=%_epocend% - %_epocStart%

    %_DEBUG_%:End    [%_end%]
    %_DEBUG_%:Start  [%_start%]
    %_DEBUG_%:eStart [%_epocStart%]
    %_DEBUG_%:eEnd   [%_epocend%]
    %_DEBUG_%:eDiff  [%_epocDiff%]
    
    CALL :epoc2iso _iso %_epocDiff% %dDiff%
    ECHO:+[%_iso%]
    
    ECHO:
GOTO :EOF

::---------------------------------------------------------------------

:selfTest
SETLOCAL
::goto :next
    SET _dDays=0
    ECHO:: 00:01:00.000 sec 
	SET _start=20151118133303.680000+060
	SET   _End=20151118133403.680000+060
	CALL :selfTest.sub

    ECHO:: 00:01:00.001 sec 
	SET _start=20151118133303.680000+060
	SET   _End=20151118133403.681000+060
	CALL :selfTest.sub

    ECHO:: 00:01:00.3 sec   
	SET _start=20151118133303.680000+060
	SET   _End=20151118133404.001000+060
	CALL :selfTest.sub
    

    ECHO:: 00:01:01.3 sec   
	SET _start=20151118133303.680000+060
	SET   _End=20151118133405.001000+060
	CALL :selfTest.sub

    ECHO:: 00:00:11.3 sec   
	SET _start=20151118133403.680000+060
	SET   _End=20151118133415.001000+060
	CALL :selfTest.sub

    ECHO:: 00:01:01.3 sec   
	SET _start=20151118133403.680000+060
	SET   _End=20151118133505.001000+060
	CALL :selfTest.sub
    
    ECHO:: 01:01:01.3 sec   
	SET _start=20151118133403.680000+060
	SET   _End=20151118143505.001000+060
	CALL :selfTest.sub


    ECHO:: 04:03:02.001 sec   
    SET _start=20151118133403.001000+060
    SET   _End=20151118173705.002000+060
    CALL :selfTest.sub

    ECHO:: 244:03:02.001 sec   
    SET _start=20151108133403.001000+060
    SET   _End=20151118173705.002000+060
    CALL :selfTest.sub
    
    SET   _End=20151118230958.215000+060
    SET _Start=20151118123403.680000+060
    CALL :selfTest.sub
    
::    [_loop] [20151119000046.094000+060]
::Ugyldigt tal. Numeriske konstanter er enten decimaltal (17),
::hexadecimaltal (0x11) eller oktaltal (021).
    SET   _End=20151119000051.920000+060
    SET _Start=20151119000046.094000+060
    CALL :selfTest.sub
    
::eDiff[51874]
::iDiff[00:00:51.874]
GOTO :EOF

::*** End of File *****************************************************