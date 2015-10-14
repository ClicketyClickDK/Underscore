
::----------------------------------------------------------------------

:_UnitTest_getPublicIp
SETLOCAL

    SHIFT
    
    :: Create ref
    ::(
    ::    ECHO:getPublicIp is a template. No functional test
    ::)>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        CALL %0
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_getPublicIp ***

::----------------------------------------------------------------------

::1.1.1.1
::MATCH::^[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*
:: At least two digits in
::MATCH::^[0-9][0-9]*\.[0-9]*\.[0-9]*\.[0-9]*
::