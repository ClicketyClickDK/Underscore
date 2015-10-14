
::----------------------------------------------------------------------

:_UnitTest_ftime
    SHIFT
    
    SET _DEBUG_=IF DEFINED DEBUG IF NOT "0"=="%DEBUG%" 2^>^&1 ECHO:[%%0]: 
    SET XX=

    FOR %%a IN ( %0 date2jDate.cmd shortDate2Iso.cmd ) DO (
        IF NOT EXIST "%~dp0\%%a" ( ECHO:%%a MISSING &EXIT /B 1 )
    )

    CALL shortDate2Iso _iso "%~t0"
    CALL date2jdate XX "%_iso%"
    :: Create ref
    (
        SET XX
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc" 

    %_DEBUG_% CALL %0 XX "%0"
    CALL %0 XX "%0"
    ::Dump test data
    (
        SET XX
    )>"%TEMP%\%0.dump" 2>>"%TEMP%\%0.trc"
GOTO :EOF *** ftime ***


::----------------------------------------------------------------------