
::----------------------------------------------------------------------

:_UnitTest_getDiskSpace
SETLOCAL

    SHIFT
    
    :: Create ref
::    (
    IF EXIST "%TEMP%\%0.ref" DEL"%TEMP%\%0.ref"

    :: Dump data
    (
        CALL %0
    )>"%TEMP%\%0.dump"
    type "%TEMP%\%0.dump"
    ECHO:
GOTO :EOF *** :_UnitTest_getDiskSpace ***
    
::----------------------------------------------------------------------

::*** Match strings for testing output --------------------------------
::  Drive            Free                Space
::  C:              15,08 GB /          117,78 GB
::  D:             603,71 GB /        6.144,00 GB
::  G:             603,71 GB /        6.144,00 GB
::  H:             603,71 GB /        6.144,00 GB
::  I:           1.849,53 GB /        3.072,00 GB
::  Total        3.675,73 GB /       21.621,78 GB
::  
::# Test strings for test 
::
::Header
::MATCH::^Drive *Free *Space$
::
::Each drive
::MATCH::^[A-Z]: *[0-9.,]* [MGT]B / *[0-9.,]* [MGT]B$
::
::Total
::MATCH::^Total *[0-9.,]* [MGT]B / *[0-9.,]* [MGT]B$
