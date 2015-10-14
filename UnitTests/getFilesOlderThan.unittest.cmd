::----------------------------------------------------------------------

:_UnitTest_getFilesOlderThan
    SETLOCAL
    CALL SET _Unit=%0
    SET _Unit=%_Unit:~11%
    SET _UnitFile=%_Unit%%~x0

    SHIFT
    FOR %%a IN ( %0 setFileDate.bat date2jDate.cmd shortDate2Iso.cmd ) DO (
        IF NOT EXIST "%~dp0\%%a" ( ECHO:%%a MISSING &EXIT /B 1 )
    )

    (
        ECHO %0
        :: Create ref
        ECHO :: Create ref
    )>"%TEMP%\%0.stamp"
    
    CALL date2jDate _jdate "1999-12-31"
    :: _jdate=2451544
    SET _jdate>>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"
    CALL date2jDate _jdate "2010-10-20"
    :: _jdate=2455490
    SET _jdate>>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"
    
    :: Dump test data
    (
        REM :: CALL cscript //nologo %~dp0\setFileDate.vbs "%TEMP%\%0.trc" "1999-12-31" >nul
        CALL setFileDate.bat "%TEMP%\%0.stamp" "1999-12-31" >nul
        FOR %%A IN ("%TEMP%\%0.stamp") DO (
            CALL shortDate2Iso.cmd _ISO "%%~tA"
            CALL date2jDate _jdate "!_ISO!"
        )
        SET _jdate

        CALL setFileDate.bat "%TEMP%\%0.stamp" "2010-10-20" >nul
        FOR %%A IN ("%TEMP%\%0.stamp") DO (
            CALL shortDate2Iso.cmd _ISO "%%~tA"
            CALL date2jDate _jdate "!_ISO!"
        )
        SET _jdate
    )>"%TEMP%\%0.dump" 2>&1
    ENDLOCAL
GOTO :EOF *** :_UnitTest_getFilesOlderThan ***

::----------------------------------------------------------------------
