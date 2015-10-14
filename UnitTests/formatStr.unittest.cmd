
::---------------------------------------------------------------------

:_UnitTest_formatStr
    SHIFT
    SETLOCAL
    
    (
        ECHO:01234567890123456789012345678901234
        ECHO:  column1 . column2   . column3   .
        ECHO:column1   .   column2 . column3   .
        ECHO:column1   . column2   .   column3 .
        ECHO:  column1 .   column2 .   column3 .
        ECHO:     col1 .      col2 .      col3 .
        ECHO:column1co . n2column2 . n3column3 .
        ECHO:column1     column2     column3   .
        REM :: Test with sharp parentheses
        ECHO:[column1     ][column2     ][column3  ]
    )>>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump test data
    (
        REM :unittest.formatStr
        REM :$created 20080219 :$changed 20080219
        REM :$source http://www.dostips.com
        echo.01234567890123456789012345678901234
        call "%0" "{-9} . {9} . {9} ." column1 column2 column3
        call %0 "{9} . {-9} . {9} ." column1 column2 column3
        call %0 "{9} . {9} . {-9} ." column1 column2 column3
        call %0 "{-9} . {-9} . {-9} ." column1 column2 column3
        call %0 "{-9} . {-9} . {-9} ." col1 col2 col3
        call %0 "{9} . {-9} . {-9} ." column1column1 column2column2 column3column3
        call %0 "{12}{12}{9} ." column1 column2 column3
        REM :: Test with sharp parentheses
        call %0 "[{12}][{12}][{9}]" column1 column2 column3

    )>"%TEMP%\%0.dump" 2>>"%TEMP%\%0.trc"
    ENDLOCAL
GOTO :EOF *** :_UnitTest_formatStr ***

::---------------------------------------------------------------------
