

::----------------------------------------------------------------------

:_UnitTest_getWindowTitle
SETLOCAL

    SHIFT
    
    :: Create ref
    (
        ECHO:[Hello world]
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"
IF EXIST "%TEMP%\%0.ref" DEL "%TEMP%\%0.ref"
    :: Dump data
    (
        TITLE Hello world
        SET _T=
        call "%0" _t _pid >nul
        echo:[!_t!] [!_pid!]
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_0template ***

::----------------------------------------------------------------------

::*** Match strings for testing output --------------------------------
::# Test strings for test matching getLastBootupTime.cmd
::01 Match prefix 
::MATCH::^\[Hello world\]
::
::02 Match prefix + date + time
::MATCH::^\[Hello world\] \[[0-9]*\]
::
