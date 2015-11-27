
::----------------------------------------------------------------------

::Unit Test for UnitTest.cmd: Testing skip function test

:_UnitTest_UnitTest
SETLOCAL

    SHIFT
    :: Dummy test - testing skip function test. No functional test
    ECHO:Skipped:Internal selftest=no test>"%TEMP%\%0.skip" & GOTO :EOF
    
GOTO :EOF *** :_UnitTest_UnitTest ***

::----------------------------------------------------------------------