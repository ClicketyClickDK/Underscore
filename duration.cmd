@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Get duration between to time stamps
SET $AUTHOR=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
::**********************************************************************
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)      %$NAME%
::@(#)      %$NAME% [envvar]
::@(#)      %$NAME% [flags]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h          Help page
::@(#)  --selftest  Internal self test (see example below)
::@(#)  envvar      Name of variable to store time stamp
::@(#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Shows the duration in milliseconds between to calls
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  %$NAME% _ST
::@(#)  ECHO: [ do something else ]
::@(#)  %$NAME% _ST
::@(#)    
::@(#)  Will return:
::@(#)  _ST                                          [20151126132254.457000+060       ]
::@(#)  [ do something else ]
::@(#)  Start                                        [20151126132254.457000+060       ]
::@(#)  End                                          [20151126132258.533000+060       ]
::@(#)  Milliseconds                                 [4076                            ]
::@(#)  Duration                                     [00:00:04.076                    ]
::@(#)    
::@ (#)
::@(#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@(#)  errorlevel is 0 if OK, otherwise 1+.
::@(#)
::@ (#)ENVIRONMENT
::@(-)  Variables affected
::@ (#)
::@(#)FILES, 
::@(-)  Files used, required, affected
::@(#)  Test suite in unittest\ directory
::@(#)
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
::@(#)  compareDuration.cmd Compare duration of two operations
::@(#)  Times.cmd           Get duration of a command
::@ (#)  
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
::SET $VERSION=2015-11-26&SET $REVISION=11:37:00&SET $COMMENT=EB / Init
  SET $VERSION=2016-03-14&SET $REVISION=10:00:00&SET $COMMENT=Set "%~dp0\ prefix on function calls / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************
::endlocal
    CALL "%~dp0\_DEBUG"
    ::CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
    ECHO:%*| findstr "\<[-/]*selftest\>" >nul 2>&1 & IF NOT ERRORLEVEL 1 CALL :SelfTest & EXIT /b 0 



    REM c:\_>duration -start:_st
    REM [_start] [20151118133403.680000+060]
    REM C:\_>duration _st
    REM End  [20151118150436.575000+060]
    REM Start[20151118123403.680000+060]
    REM eDiff[15032895]
    REM iDiff[04:10:32.895]

:main

    IF NOT DEFINED %~1  CALL :start %~1
    IF DEFINED %1  CALL :end "!%~1!" "_end"
    
    ::IF DEFINED @%$NAME%.start CALL :start _start
    ::IF NOT DEFINED @%$NAME%.start CALL :end "!%~1!" "_end"

    IF NOT DEFINED %~1 ENDLOCAL&set %~1=%_start%
GOTO :EOF

::---------------------------------------------------------------------

:start
    CALL :setTime _start
    CALL "%~dp0\_Action" "%~1"
    CALL "%~dp0\_Status" "!_Start!"
    ::SET start.out=!@%$NAME%.start!
GOTO :EOF

::---------------------------------------------------------------------

:end
    SETLOCAL
    SET _start=%~1
    SET _end=%~2

    CALL :setTime %2
    call :iso2epoc %_start% _epocStart
    call :iso2epoc %_end% _epocend
    SET /A _epocDiff=%_epocend% - %_epocStart%

    1>&2 CALL "%~dp0\_Action" Start
    1>&2 CALL "%~dp0\_Status" "%_start%"
    1>&2 CALL "%~dp0\_Action" End
    1>&2 CALL "%~dp0\_Status" "%_end%"
    1>&2 CALL "%~dp0\_Action" Milliseconds
    1>&2 CALL "%~dp0\_Status" "%_epocDiff%"

    call :calc.date dDiff %_start:~0,4%-%_start:~4,2%-%_start:~6,2% %_end:~0,4%-%_end:~4,2%-%_end:~6,2% 
        
    CALL :epoc2iso _iso %_epocDiff% %dDiff%
    1>&2 CALL "%~dp0\_Action" Duration
    1>&2 CALL "%~dp0\_Status" "%_iso%"
    
    ECHO:
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
    
:next
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