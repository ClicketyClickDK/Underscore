

::----------------------------------------------------------------------

:_UnitTest_wget
SETLOCAL
:: Please note! This test will fail if no connection to the webservice mentioned in _URLstub 

    SHIFT
    SET _URLstub=http://clicketyclick.dk/development/dos/_/
    SET _CurrentVersion=?
    SET _versionFile=%temp%current
    SET _archiveFile=%temp%current.zip
    
    IF EXIST "%_VersionFile%" DEL "%_VersionFile%"
    :: Dump data
    (
        rem ::CALL cscript //nologo wget.vbs "%_URLstub%current"  "%_VersionFile%"
        CALL wget.bat "%_URLstub%current"  "%_VersionFile%"
        IF ERRORLEVEL 1 CALL :skip %ErrorLevel% >>"%TEMP%\%0.skip" 2>nul
        DIR /b /s "%_VersionFile%"
    )>"%TEMP%\%0.dump"

    :: Create ref
    (
        ECHO:- Get [%_URLstub%current]
        ECHO:- To  [%_versionFile%]
        ECHO:- http state [200]
        ECHO:-- http response = OK
        ECHO:- file retrieved
        ECHO:%_VersionFile%
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    
GOTO :EOF *** :_UnitTest_wget ***

::----------------------------------------------------------------------
:SKIP
    Echo:Check internet connection&EXIT /B %1 
GOTO :EOF