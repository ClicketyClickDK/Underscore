

::----------------------------------------------------------------------

:_UnitTest__getopt
SETLOCAL

    SHIFT
    
    :: Create ref
    (
        ECHO:@UnitTest.1=file
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

