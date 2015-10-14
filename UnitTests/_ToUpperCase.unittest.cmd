
::----------------------------------------------------------------------

:_UnitTest__toUpperCase
    SETLOCAL
    SHIFT

::          CALL _toLower _ "MixCaseString"
::          ECHO %_%
    1>"%TEMP%\%0.ref" ECHO _tl=MIXEDCASESTRING
::     
::      Will produce:
::          mixedcasestring

    >>"%TEMP%\%0.trc" 2>&1 CALL _toUpperCase _tl "MiXedCaseString"
    >"%TEMP%\%0.dump" 2>>"%TEMP%\%0.trc" set _tl

    ::COPY "%TEMP%\%0.hex" "%TEMP%\%0.dump" >nul 
    ENDLOCAL
GOTO :EOF *** _toUpperCase ***

::----------------------------------------------------------------------