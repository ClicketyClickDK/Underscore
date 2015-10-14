

::----------------------------------------------------------------------

:_UnitTest_mapLookup
SETLOCAL

    SHIFT
    IF EXIST "%TEMP%\%0.*" DEL "%TEMP%\%0.*"

    :: Create tmp
    ::(
    ::    ECHO:Hello world
    ::)>"%TEMP%\%0.tmp" 2>>"%TEMP%\%0.trc"
    ::CALL cscript //nologo zip.vbs "%TEMP%\%0.zip" "%TEMP%\%0.tmp"
    
    :: Create ref
    (
        ECHO:05
        ECHO:12
        ECHO:
        ECHO:01
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    SET v=Mai
    SET map=Jan-01;Feb-02;Mar-03;Apr-04;Mai-05;Jun-06;Jul-07;Aug-08;Sep-09;Oct-10;Nov-11;Dec-12

    :: Dump data
    (
        CALL mapLookup "%map%" "Mai" _new&ECHO.!_new!
        CALL mapLookup "%map%" "Dec" _new&ECHO.!_new!
        CALL mapLookup "%map%" "xxx" _new&ECHO.!_new!
        CALL mapLookup "%map%" "Jan" _new&ECHO.!_new!
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_mapLookup ***

::----------------------------------------------------------------------
