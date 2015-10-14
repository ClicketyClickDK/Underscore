
::----------------------------------------------------------------------

:_UnitTest_getLastBootupTime
SETLOCAL

    SHIFT
    
    :: Create ref
::    (
::                 YYYYMMDDhhmmss
::        ECHO:DTS=20150214033423.718167+060
::    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"
IF EXIST "%TEMP%\%0.ref" DEL"%TEMP%\%0.ref"

    :: Dump data
    (
        CALL %0
    )>"%TEMP%\%0.dump"
    type "%TEMP%\%0.dump"
    ECHO:
GOTO :EOF *** :_UnitTest_0template ***
    
::----------------------------------------------------------------------

::*** Match strings for testing output --------------------------------
::# Test strings for test matching getLastBootupTime.cmd
::01 Match prefix + year
::MATCH::^DTS=20[01]
::
::02 Match prefix + date + time
:::           y12y3  y4   m1  m2   d1   d2   h1   h2   m1  m2    s1   s2
::MATCH::^DTS=20[01][0-9][01][1-9][1-3][0-9][0-2][0-9][0-5][0-9][0-5][0-9]\.
::
::03 Match faction of second
::MATCH::\.[0-9][0-9][0-9][0-9][0-9][0-9]\+
::
::04 Match time zone
::MATCH::\+[0-9][0-9][0-9]
:: findStr cannot match this complicated string (sic!)
:::MATCH::^DTS=20[01][0-9][01][1-9][1-3][0-9][0-2][0-9][0-5][0-9][0-5][0-9]\.[0-9][0-9][0-9][0-9][0-9][0-9]\+[0][0-9][0]
