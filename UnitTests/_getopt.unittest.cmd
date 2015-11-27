::********************************************************************** 
::
::SET $DESCRIPTION=Parse command line options and create environment vars 
::
::----------------------------------------------------------------------
::History 
::SET $VERSION=2015-11-10&SET $REVISION=10:48:00&SET $COMMENT=No connecting ":" in "-flag file" / ErikBachmann 
::********************************************************************** 

:_UnitTest__getopt
SETLOCAL

    SHIFT
    
    :: Create ref
    (
        ::ECHO:@UnitTest.1=file
        ::No connecting ":" in "-flag file"
        ECHO:@UnitTest.file=1
        ECHO:@UnitTest.flag=1
        ECHO:@UnitTest.y=z
        ECHO:@UnitTest.z="hello world"
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        SET $NAME=UnitTest
        CALL _getopt  -y:z -flag file -z:"hello world"
        SET @UnitTest
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_0template ***

::----------------------------------------------------------------------
