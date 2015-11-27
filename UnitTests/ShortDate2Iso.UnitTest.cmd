
::----------------------------------------------------------------------

:_UnitTest_ShortDate2Iso
SETLOCAL

    SHIFT

    :: No ref - only matchTest
    :: Create ref
    ::(
    ::    ECHO:0template is a template. No functional test
    ::)>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"


    :: Dump data = ShortDate for the function file (DIR ShortDate2Iso.cmd)
    (
        FOR %%i IN (%~f0) DO CALL %~f0 myTime "%%~ti"
        SET myTime
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_ShortDate2Iso ***

::----------------------------------------------------------------------
::*** Match strings for testing output --------------------------------
::# Test strings for test matching script.bat
::     YYYY-MM-DDThh:mm
::org MATCH::^[1-2][0,9][0-3][0-9}-[0-1][0-9]-[0-3][0-9]T[0-2][0-9]:[0-5][0-3]$
::MATCH::^myTime=[1-2][0,9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]T[0-2][0-9]:[0-5][0-9]
::