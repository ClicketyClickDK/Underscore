
::----------------------------------------------------------------------

:_UnitTest_duration
SETLOCAL

    SHIFT

    :: No ref - only matchTest
    :: Create ref
    ::(
    ::    ECHO:0template is a template. No functional test
    ::)>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    set _starttime=
    :: Dump data = ShortDate for the function file (DIR duration.cmd)
    (
        
        CALL %0 "dir /s" "dir /S/B" 2>&1
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_duration ***

::----------------------------------------------------------------------
::*** Match strings for testing output --------------------------------
::# Test strings for test matching script.bat
::     YYYY-MM-DDThh:mm
::
:: Start                                        [20151126082100.431000+060       ]
::                  Y    Y    Y    Y    M    M    D    D    H    H    m    m    s    s      mi   mi   mi   mi   mi   mi     z    z    z
::MATCH::^Start *\[[1-2][0,9][0-9][0-9][0-1][0-9][0-3][0-9][0-2][0-9][0-5][0-9][0-5][0-9]\.[0-9][0-9][0-9][0-9][0-9][0-9]\+[0-9][0-9][0-9] *\]
::
:: End                                          [20151126082101.121000+060       ]
::                  Y    Y    Y    Y    M    M    D    D    H    H    m    m    s    s      mi   mi   mi   mi   mi   mi     z    z    z
::MATCH::^End   *\[[1-2][0,9][0-9][0-9][0-1][0-9][0-3][0-9][0-2][0-9][0-5][0-9][0-5][0-9]\.[0-9][0-9][0-9][0-9][0-9][0-9]\+[0-9][0-9][0-9] *\]
::
:: Milliseconds                                 [690                             ]
::MATCH::^Milliseconds *\[[0-9]* *\]
::
:: Duration                                     [00:00:00.690                    ]
::                     H    H      m    m      s    s      mi   mi   mi
::MATCH::^Duration *\[[0-9][0-9]\:[0-5][0-9]\:[0-5][0-9]\.[0-9][0-9][0-9]* *\]
::
:: Loop                                        [20151126082100.431000+060       ]
::                      Y    Y    Y    Y    M    M    D    D    H    H    m    m    s    s      mi   mi   mi   mi   mi   mi     z    z    z
::MATCH::^_loop[2 ] *\[[1-2][0,9][0-9][0-9][0-1][0-9][0-3][0-9][0-2][0-9][0-5][0-9][0-5][0-9]\.[0-9][0-9][0-9][0-9][0-9][0-9]\+[0-9][0-9][0-9] *\]
