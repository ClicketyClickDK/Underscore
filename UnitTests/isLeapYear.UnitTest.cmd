
::----------------------------------------------------------------------

:_UnitTest_isLeapYear
SETLOCAL

    SHIFT
    
    :: Create ref
    (
        ECHO:Year [1999] Leap [0] 
        ECHO:Year [2000] Leap [1] &REM :: Leap
        ECHO:Year [2001] Leap [0] 
        ECHO:Year [2002] Leap [0] 
        ECHO:Year [2003] Leap [0] 
        ECHO:Year [2004] Leap [1] &REM :: Leap
        ECHO:Year [2005] Leap [0] 
        ECHO:Year [2006] Leap [0] 
        ECHO:Year [2007] Leap [0] 
        ECHO:Year [2008] Leap [1] &REM :: Leap
        ECHO:Year [2009] Leap [0] 
        ECHO:Year [2010] Leap [0] 
        ECHO:Year [2011] Leap [0] 
        ECHO:Year [2012] Leap [1] &REM :: Leap
        ECHO:Year [2013] Leap [0] 
        ECHO:Year [2014] Leap [0] 
        ECHO:Year [2015] Leap [0] 
        ECHO:Year [2016] Leap [1] &REM :: Leap
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        FOR /L %%a IN (1999,1,2016) DO (
            CALL isLeapYear LeapYear %%a
            ECHO:Year [%%a] Leap [!LeapYear!] 
        )
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_isLeapYear ***

::----------------------------------------------------------------------