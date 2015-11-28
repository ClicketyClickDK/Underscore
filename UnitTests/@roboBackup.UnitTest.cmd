

::----------------------------------------------------------------------

:_UnitTest_RoboBackup
SETLOCAL

    SHIFT
    IF EXIST "%Temp%\.Archive\" RMDIR /Q /S "%Temp%\.Archive\" >>"%TEMP%\%0.trc" 2>&1
    CALL RoboBackup "%_ScriptDir%\.Archive\" "%Temp%\.Archive\" >>"%TEMP%\%0.trc" 2>&1

    :: Create ref
    (
        DIR /A:-D "%_ScriptDir%\.Archive\"|findstr ":"|findstr /V "\\"
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        DIR /A:-D "%Temp%\.Archive\"|findstr ":"|findstr /V "\\"
    )>"%TEMP%\%0.dump"

    :: List copied files in trace
    DIR /S "%Temp%\.Archive\" >>"%TEMP%\%0.trc"
    :: Remove backup to avoid conflict with other files
    RMDIR /S/Q "%Temp%\.Archive\"
    
GOTO :EOF *** :_UnitTest_RoboBackup ***

::----------------------------------------------------------------------