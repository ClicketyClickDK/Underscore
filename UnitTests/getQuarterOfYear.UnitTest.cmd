

::----------------------------------------------------------------------

:_UnitTest_getQuarterOfYear
SETLOCAL

    SHIFT
    
    :: Create ref
    (
rem        ECHO:0template is a template. No functional test
        ECHO:M=01   QuarterOfYear=1
        ECHO:M=02   QuarterOfYear=1
        ECHO:M=03   QuarterOfYear=1
        ECHO:M=04   QuarterOfYear=2
        ECHO:M=05   QuarterOfYear=2
        ECHO:M=06   QuarterOfYear=2
        ECHO:M=07   QuarterOfYear=3
        ECHO:M=08   QuarterOfYear=3
        ECHO:M=09   QuarterOfYear=3
        ECHO:M=10   QuarterOfYear=4
        ECHO:M=11   QuarterOfYear=4
        ECHO:M=12   QuarterOfYear=4
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        ::FOR /L %%M IN ( 7,1,9 ) DO CALL :t 0%%M
        FOR /L %%M IN ( 1,1,12 ) DO CALL :t 0%%M
    )>"%TEMP%\%0.dump"
GOTO :EOF *** :_UnitTest_0template ***

:t
    ::Set /A M=10%~1 %% 100
    ::ECHO M=0%M%
    SET M=%~1
    SET M=%M:~-2%
    SET /P M=M=%M%   <NUL
    CALL getquarterOfYear 2000-%M:~-2%-01
    )
GOTO :EOF
::----------------------------------------------------------------------