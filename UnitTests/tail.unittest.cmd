
::----------------------------------------------------------------------

:_UnitTest_tail
    SETLOCAL
    SHIFT

    (
    ECHO MORE /E +%%skip%% %%tmpFile%%
    ECHO Del %%tmpFile%%
    ECHO:
    ECHO ::*** End of File *****************************************************
    )1>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"
    
    ::>"%TEMP%\%0.hex" 2>&1 CALL tail.cmd "%~dp0\tail.cmd" 4
    ::COPY "%TEMP%\%0.hex" "%TEMP%\%0.dump" >nul 
    >"%TEMP%\%0.dump" 2>&1 CALL tail.cmd "%~dp0\tail.cmd" 4
    ENDLOCAL
GOTO :EOF *** :_UnitTest_tail ***

::----------------------------------------------------------------------
