
::----------------------------------------------------------------------

:_UnitTest_Julian2utc
SETLOCAL
    SHIFT
    
    :: Create ref
    (
        ECHO:2455217
    )>"%TEMP%\%0.hexdump" 2>>"%TEMP%\%0.trc"

    :: Simple dump
    CALL %0 #JD "2010-01-20"
    1>"%TEMP%\%0.dump" 2>&1 SET #JD
   
GOTO :EOF *** :_UnitTest_Julian2utc ***

::----------------------------------------------------------------------