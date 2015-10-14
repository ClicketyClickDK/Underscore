

::----------------------------------------------------------------------

:_UnitTest_checkOutArchive
SETLOCAL

    SHIFT
    pushd "%_ScriptDir%"
    CALL checkInArchive2 >>"%TEMP%\%0.trc" 2>&1
    
    (
        ECHO:@ECHO OFF
        ECHO:SETLOCAL ENABLEDELAYEDEXPANSION^&::^(Don't pollute the global environment with the following^)
        ECHO:::**********************************************************************
        ECHO:SET $NAME=^%~n0
        ECHO:SET $DESCRIPTION=Input routine for batch using VBScript to provide input box
        ECHO:SET $Author=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
        ECHO:SET $Source=^%~dpnx0
        ECHO::: History
        ECHO:::SET $VERSION=xx.xxx^&SET $REVISION=YYYY-MM-DDThh:mm:ss^&SET $COMMENT=Init / Description
        ECHO:::SET $VERSION=01.000^&SET $REVISION=2010-10-13T15:36:00^&SET $COMMENT=ebp / Initial: FindInPath
        ECHO:  SET $VERSION=01.002^&SET $REVISION=2014-01-11T10:59:00^&SET $Comment=Update doc + example/EBP
    )>"dummy.cmd"

    IF EXIST "%TEMP%\%0.tmp" DEL "%TEMP%\%0.tmp"
    :: Create ref
    (
        DIR  /S /B "%TEMP%\%0.tmp" 2>&1
        DIR  /S /B "dummy.cmd" 2>&1
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        CALL checkInArchive >>"%TEMP%\%0.trc" 2>&1
        DEL "dummy.cmd" 2>&1
        DIR  /S /B "dummy.cmd" 2>&1
        CALL checkOutArchive >>"%TEMP%\%0.trc" 2>&1
        DIR  /S /B "dummy.cmd" 2>&1
    )>"%TEMP%\%0.dump"
    POPD
GOTO :EOF *** :_UnitTest_checkOutArchive ***

::----------------------------------------------------------------------