
::----------------------------------------------------------------------

:_UnitTest_cmdize
SETLOCAL
    SET _Str=Hello World
    SHIFT
    ECHO:WScript.Echo "%_str%">"%Temp%\%0.vbs"
    CALL %0 "%Temp%\%0.vbs"
    
    :: Create ref
    (
        ECHO:%_str%
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        REM ECHO:cmdize is a template. No functional test
        CALL "%Temp%\%0.bat"
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_cmdize ***

::----------------------------------------------------------------------