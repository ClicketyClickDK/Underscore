::---------------------------------------------------------------------

:_UnitTest__isday
    IF NOT EXIST "%_ScriptFile%" ECHO Script not found [%_ScriptFile%]&GOTO :EOF

    SHIFT
::(#)      CALL %$NAME% %%TIME%% 06:00:00 20:00:00
::(#)  Day between 06:00 and 22:00
::(#)  
::(#)EXIT STATUS
::(#)  0   OK  (Daytime)
::(#)  1   Help or manual page 
::(#)  2   Morning
::(#)  3   Evening
::(#)  4+  Error
    
    (
        ECHO Morning [2]=[2]
        ECHO Morning [2]=[2]
        ECHO Day [0]=[0]
        ECHO Day [0]=[0]
        ECHO Evening [3]=[3]
    )>"%TEMP%\%_ScriptFile%.ref"
    
    (
        CALL _isDay "00:00:00"
        ECHO Morning [2]=[!_isDay!]
        CALL _isDay "05:59:59"
        ECHO Morning [2]=[!_isDay!]

        CALL _isDay "07:00:00"
        ECHO Day [0]=[!_isDay!]
        CALL _isDay "22:00:00"
        ECHO Day [0]=[!_isDay!]
    

        CALL _isDay "22:00:01"
        ECHO Evening [3]=[!_isDay!]
    )>"%TEMP%\%_ScriptFile%.dump"
SET ERRORLEVEL=
GOTO :EOF *** :_UnitTest__isday ***

::*** Match strings for testing output --------------------------------
::# Test strings for test matching script.bat
::MATCH::Hello world
::# Next FAIL: world not in beginning
::MATCH::^world
::MATCH::^Hello
::MATCH:v^no.go
::# Next FAIL: not found in output
::MATCH::Good.golly.miss.Molly
::MATCH::All.I.have.to.say
::# A blank line returns an error in matching expected with lines executed
:::MATCH::

::*** End of File *****************************************************