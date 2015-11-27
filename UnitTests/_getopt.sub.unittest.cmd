::********************************************************************** 
::
::SET $DESCRIPTION=Parse command line options and create environment vars 
::
::----------------------------------------------------------------------
::History 
::SET $VERSION=2015-11-10&SET $REVISION=10:48:00&SET $COMMENT=No connecting ":" in "-flag file" / ErikBachmann 
::********************************************************************** 

:_UnitTest__getopt.sub
SETLOCAL

    SHIFT
    
    REM :: Create ref
    REM (
        REM ::ECHO:@UnitTest.1=file
        REM ::No connecting ":" in "-flag file"
        REM ECHO:@UnitTest.file=1
        REM ECHO:@UnitTest.flag=1
        REM ECHO:@UnitTest.y=z
        REM ECHO:@UnitTest.z="hello world"
    REM )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        SET $NAME=UnitTest
        SET $SOURCE=%~f0
::@(#)%$Source% - test test output
        CALL %0 -h
        set errorlevel=0
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest__getopt.sub ***

::----------------------------------------------------------------------
::*** Match strings for testing output --------------------------------
::# Test strings for test matching script.bat
::MATCH::^NAME
::MATCH::^SYNOPSIS
::MATCH::^DESCRIPTION
::MATCH::^REQUIRES

::*** End of File *****************************************************