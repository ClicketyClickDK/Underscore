
::----------------------------------------------------------------------

:_UnitTest_getWeekOfYear
SETLOCAL

    SHIFT
    SET _ReferenceFile=%_UnitTestDir%\date0.reference.csv
    ECHO:Reference file: "%_ReferenceFile%"
    
    :: Create ref
    (
        REM 1    2    3  4  5  6           7
        rem #ISO;YYYY;MM;DD;JD;DOY:365.dk:;WN:365.dk:;DOW1;DOW0;DayName;poy:365.dk:;Excel:DOY;Excel:DOW;Excel:Uge.nr;WeekNo formel;;Dato;;;
        FOR /F "tokens=1,7 delims=;" %%a IN ('TYPE "%_ReferenceFile%"') DO (
            CALL _IsNumeric "%%b"
            IF ERRORLEVEL 1 (
                ECHO:%%b
            ) ELSE (
                ECHO:%%a;%%b
            )
        )
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        REM 1    2    3  4  5  6           7
        rem #ISO;YYYY;MM;DD;JD;DOY:365.dk:;WN:365.dk:;DOW1;DOW0;DayName;poy:365.dk:;Excel:DOY;Excel:DOW;Excel:Uge.nr;WeekNo formel;;Dato;;;
        FOR /F "tokens=1,7 delims=;" %%a IN ('TYPE "%_ReferenceFile%"') DO (
            CALL _IsNumeric "%%b"
            IF ERRORLEVEL 1 (
                ECHO:%%b
            ) ELSE (
                CALL GetWeekOfYear WeekOfYear %%a >nul
                ECHO:%%a;!WeekOfYear!
            )
        )
    )>"%TEMP%\%0.dump"
GOTO :EOF *** :_UnitTest_getWeekOfYear ***

::----------------------------------------------------------------------