
::----------------------------------------------------------------------

:_UnitTest__toLowerCase
    SETLOCAL
    SHIFT

::      CALL _toLower _ "MixCaseString"
::      ECHO %_%
    1>"%TEMP%\%0.ref" ECHO _tl=mixedcasestring
:: 
::  Will produce:
::      mixedcasestring

    >>"%TEMP%\%0.trc" 2>&1 CALL _toLowerCase _tl "MiXedCaseString"
    >"%TEMP%\%0.dump" 2>>"%TEMP%\%0.trc" set _tl

    ::COPY "%TEMP%\%0.hex" "%TEMP%\%0.dump" >nul 
    ENDLOCAL
GOTO :EOF *** _ToLowerCase ***

::----------------------------------------------------------------------