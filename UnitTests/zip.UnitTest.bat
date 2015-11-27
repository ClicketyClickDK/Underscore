

::----------------------------------------------------------------------

:_UnitTest_zip
SETLOCAL

    SHIFT
    IF EXIST "%TEMP%\%0.*" DEL "%TEMP%\%0.*"

    :: Create tmp
    (
        ECHO:Hello world
    )>"%TEMP%\%0.tmp" 2>>"%TEMP%\%0.trc"
    ::CALL cscript //nologo zip.vbs "%TEMP%\%0.zip" "%TEMP%\%0.tmp"
    CALL zip.bat "%TEMP%\%0.zip" "%TEMP%\%0.tmp"
    
    :: Create ref
    (
        ECHO:[%TEMP%%0.zip][133]
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        FOR %%a IN ("%TEMP%\%0.zip") DO ECHO [%%~fa][%%~za]
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_zip ***

::----------------------------------------------------------------------