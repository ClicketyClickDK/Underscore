@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
    ECHO %0 - start %Date% %time%
    SET $Source=%~f0
    SET _testSuite= date2jdate jdate2date getDayOfWeek GetDayOfYear GetWeekOfYear
    SET _dumpFile=date.dump.csv
    SET _Errors=0
    
    SET _SourceFile=date.reference.csv
    rem SET _RefFile=date.reference.csv

    IF DEFINED _Test (
        SET _testSuite= GetWeekOfYear
        SET _SourceFile=date1.reference.csv
        rem SET _RefFile=date1.reference.csv
        SET _dumpFile=date1.dump.csv
    )
    IF EXIST "%temp%\%_dumpFile%" DEL "%temp%\%_dumpFile%"
    
    CALL _ACTION "Source"
    CALL _STATUS "%_SourceFile%"
    CALL _ACTION "Output"
    CALL _STATUS "%_dumpFile%"
    
    1>&2 ECHO:- Build dump
    (
        rem ::ECHO: Test
        rem ::ECHO:                                                                     #ISO; YYYY;  MM;   DD;   JD;   DOY;  DOW0; WeekNo formel
        FOR /F "SKIP=2 Tokens=1-9 delims=;" %%a IN ('TYPE %_SourceFile%') DO CALL :d2j2 "%%a" "%%b" "%%c" "%%d" "%%e" "%%f" "%%i" "%%g"
    )

    CALL _ACTION "Errors"
    CALL _STATUS "%_Error%"

GOTO :EOF

:d2j2
    TITLE %0/dump %~1 [%_Errors%]
    SET _Error=0
    SET _YYYY=
    SET _JD=
    ::ECHO:#ISO[%~1]; YYYY[%~2];  MM[%~3];   DD[%~4];   JD[%~5];   DOY[%~6];   DOW0[%~7] WeekNo formel[%~8]
    Echo:%_testSuite%| findstr /C:"date2jdate">nul      &&  CALL :test_date2jdate "%~1" "%~2" "%~3" "%~4" "%~5" "%~6" "%~7" "%~8"
    Echo:%_testSuite%| findstr /C:"jdate2date">nul      && CALL :test_jdate2date  "%~1" "%~2" "%~3" "%~4" "%~5" "%~6" "%~7" "%~8"
    Echo:%_testSuite%| findstr /C:"getDayOfWeek">nul    && CALL :test_getDayOfWeek "%~1" "%~2" "%~3" "%~4" "%~5" "%~6" "%~7" "%~8"
    Echo:%_testSuite%| findstr /C:"GetDayOfYear">nul    && CALL :test_GetDayOfYear "%~1" "%~2" "%~3" "%~4" "%~5" "%~6" "%~7" "%~8"
    Echo:%_testSuite%| findstr /C:"GetWeekOfYear">nul   && CALL :test_GetWeekOfYear "%~1" "%~2" "%~3" "%~4" "%~5" "%~6" "%~7" "%~8"
    
    ::SET ErrorLevel=%_Error%
    ::IF NOT "0"=="%_Error%" 
    CALL ECHO:%~1;%_YYYY%;%_MM%;%_DD%;%_jd%;%_DayOfYear%;%_DayOfWeek%;%_WeekOfYear%;Error=%_Error%;%ErrorLevel% >>"%temp%\%_dumpFile%"
    ::ERRORLEVEL 1
    ::pause
    CALL SET /A _Errors+=%_Error%
GOTO :EOF


:test_date2jdate
    CALL date2jdate.cmd _jd "%~1"
    ::SET _JD
    IF NOT "%_JD%"=="%~5" ( SET _JD=[%~5/%_jd%]&SET /A _Error+=1 ) ELSE SET _JD=%~5/%_jd%
GOTO :EOF

:test_jdate2date
    CALL jdate2date.cmd "%_jd%" _YYYY _MM _DD
    ::1>&2 ECHO 33 %_YYYY% %_MM% %_DD%
    IF NOT "%_yyyy%"=="%~2" ( SET _YYYY=[%~2/%_YYYY%]&SET /A _Error+=1 ) ELSE SET _YYYY=%~2/%_YYYY%
    
    ::SET /A _MM+=0
    ::SET /A _DD+=0
    :: The Octal value bug 08 and 09 > 0
    SET /A _MM=100%_MM% %% 100
    SET /A _DD=100%_DD% %% 100

    IF NOT "%_mm%"=="%~3" SET _JD=[%~3/%_mm%]&CALL SET /A _Error+=1
    IF NOT "%_dd%"=="%~4" SET _JD=[%~4/%_dd%]&CALL SET /A _Error+=1
GOTO :EOF

:test_getDayOfWeek
        CALL getDayOfWeek _DayOfWeek "%~1"
        
        IF NOT "!_DayOfWeek!"=="%~7" (
            SET _DayOfWeek=[%~7/!_DayOfWeek!] 
            CALL SET /A _Error+=1
        ) ELSE (
            SET _DayOfWeek=%~7/!_DayOfWeek!
        )
GOTO :EOF

:test_GetDayOfYear
        CALL GetDayOfYear _DayOfYear "%~1"
        IF NOT "!_DayOfYear!"=="%~6" ( SET _DayOfYear=[%~6/!_DayOfYear!]&CALL SET /A _Error+=1 ) ELSE SET _DayOfYear=%~6/!_DayOfYear!
GOTO :EOF

:test_GetWeekOfYear
        CALL GetWeekOfYear _WeekOfYear "%~1"
        IF NOT "!_WeekOfYear!"=="%~8" ( SET _WeekOfYear=[%~8/!_WeekOfYear!]&CALL SET /A _Error+=1 ) ELSE SET _WeekOfYear=%~8/!_WeekOfYear!

GOTO :EOF
GOTO :EOF


:xxd2j
    TITLE %0/dump %~1
    CALL date2jdate.cmd _jd "%~1"
    SET _JD

    CALL jdate2date.cmd "%_jd%" _YYYY _MM _DD
    ::1>&2 ECHO 33 %_YYYY% %_MM% %_DD%

    ::SET /A _MM+=0
    ::SET /A _DD+=0
    :: The Octal value bug 08 and 09 > 0
    SET /A _MM=100%_MM% %% 100
    SET /A _DD=100%_DD% %% 100
    ::1>&2 ECHO 38 %_YYYY% %_MM% %_DD%
    
    CALL getDayOfWeek _DayOfWeek "%~1"
    CALL GetDayOfYear _DayOfYear "%~1"
    CALL GetWeekOfYear _WeekOfYear "%~1"
    ::1>&2 ECHO 40 %_YYYY% %_MM% %_DD%

    CALL ECHO:%~1;%_YYYY%;%_MM%;%_DD%;%_jd%;%_DayOfYear%;%_DayOfWeek%;%_WeekOfYear%
GOTO :EOF

