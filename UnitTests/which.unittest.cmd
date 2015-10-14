
::----------------------------------------------------------------------

:_UnitTest_Which
    SHIFT

    >>"%TEMP%\%0.trc" ECHO %0

    :: Create ref
    >>"%TEMP%\%0.trc" ECHO :: Create ref
    (
        IF EXIST "%SystemRoot%\System32\where.exe" (
            ECHO:%~f0 is deprecated - use "%SystemRoot%\System32\where.exe"
        ) 
        ECHO:C:\Windows\System32\reg.exe
        )>"%TEMP%\%0.ref"
    
    >>"%TEMP%\%0.trc" ECHO :: Create dump
    CALL %0 "reg.exe" 1>>"%TEMP%\%0.dump" 2>&1
    
GOTO :EOF *** :_UnitTest_Which ***

::----------------------------------------------------------------------
