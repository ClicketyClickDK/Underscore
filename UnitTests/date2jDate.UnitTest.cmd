::----------------------------------------------------------------------
::@ECHO OFF
:_UnitTest_Date2jDate
SETLOCAL

    SHIFT
    SET _ReferenceFile=%_UnitTestDir%\date0.reference.csv
    ECHO:Reference file: "%_ReferenceFile%"
    
    :: Create ref
    (
        ECHO:OK
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    CALL :test_jDate2Date
    
    :: Dump data
    (
        IF "0"=="%_Error%" (
            ECHO:OK
        ) ELSE (
            ECHO:FAIL 1
        )
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_Date2jDate ***

:test_jDate2Date
SET _Error=0
SET _Unknown=-

FOR /F "tokens=1,5 delims=;" %%a IN ('TYPE "%_ReferenceFile%"') DO (
    CALL _IsNumeric "%%b"
    IF ERRORLEVEL 1 (
        ECHO:%%b
    ) ELSE (
        CALL :Test_date "%%a" "%%b"
    )
)
ECHO Errors: [%_Error%]
EXIT /B %_error%
GOTO :EOF

:test_date
    CALL FormatStr "{20}:[{10}][{10}][{10}][{10}][{-4}]"  "CSV" "%~1" "%_Unknown%" "%~2" "%_Unknown%" "%_Unknown%"
    
    :: GregorianDate 2 JulianDate
    CALL Date2jDate _j2d %~1
    IF "%~2"=="%_j2d%" ( SET _RESULT=OK ) ELSE ( SET _RESULT=FAIL&SET /A _Error+=1 )
    CALL FormatStr "{20}:[{10}][{10}][{10}][{10}][{-4}]" "date2jdate" "%~1" "!_j2d!" "%~2" "%_Unknown%" "!_RESULT!"
    
    :: julianDate 2 gregorianDate
    CALL jDate2Date "%~2" _YYYY _MM _DD
    IF [!_YYYY!-!_MM!-!_DD!]==[%~1] ( SET _RESULT=OK ) ELSE ( SET _RESULT=FAIL&SET /A _Error+=1 )
    CALL FormatStr "{20}:[{10}][{10}][{10}][{10}][{-4}]" "jDate2Date" "%~1" "%_Unknown%" "%~2" "!_YYYY!-!_MM!-!_DD!" "!_RESULT!"
GOTO :EOF

::----------------------------------------------------------------------