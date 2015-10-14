
::----------------------------------------------------------------------

:_UnitTest__action
SETLOCAL
    SHIFT
    
    :: Create ref
    (
    ECHO 00000000: 48 65 6C 6C 6F 20 57 6F 72 6C 64 20 20 20 20 20  Hello World     
    ECHO 00000010: 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20                  
    ECHO 00000020: 20 20 20 20 20 20 20 20 20 20 20 20 20                        
    )>"%TEMP%\%0.hexref" 2>>"%TEMP%\%0.trc"

    :: Simple dump
    CALL %0 "Hello World" 1>"%TEMP%\%0.dump" 2>&1

    :: Convert to hexdump
    CALL HexDump /A /O "%TEMP%\%0.dump" >"%TEMP%\%0.hexdump" 2>>"%TEMP%\%0.trc"
    
GOTO :EOF *** :_UnitTest__action ***

::----------------------------------------------------------------------