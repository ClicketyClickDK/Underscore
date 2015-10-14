
::----------------------------------------------------------------------

:_UnitTest__is32bit
    SHIFT

    CALL _Is32bit=0
    >>"%TEMP%\%0.trc" ECHO:%0

    :: Create ref
    >>"%TEMP%\%0.trc" ECHO :: Create ref
    (
        REM ECHO:[1]
        ECHO:$Is64Bit=1
    )>"%TEMP%\%0.ref" 2>nul
    
    >>"%TEMP%\%0.trc" ECHO :: Create dump
    CALL %0  1>>"%TEMP%\%0.dump" 2>&1
    SET $is 1>>"%TEMP%\%0.dump" 2>&1
    SET ErrorLevel=
    ::FOR %%A IN ($Is32Bit $Is64Bit) DO (
    FOR %%A IN ($Is32Bit) DO (
        FIND "%%A"<"%TEMP%\%0.dump">NUL 2>&1
        SET /A _Is32bit+=!ErrorLevel!
    )
    ::ECHO:[%_Is32bit%]>"%TEMP%\%0.hex"
    EXIT /B 0
GOTO :EOF *** :_UnitTest__is32bit ***

::----------------------------------------------------------------------