
::----------------------------------------------------------------------

:_UnitTest__ParentDir

    SHIFT
    :: Create ref
    ECHO _parentDir_x=%Windir%>"%TEMP%\%0.ref"
    ECHO _parentDir_y=%Windir%\system32>>"%TEMP%\%0.ref"
    CALL HexDump.cmd /A /O "%TEMP%\%0.ref" >"%TEMP%\%0.hexref" 2>>"%TEMP%\%0.trc"
    
    :: Dump test data
    >"%TEMP%\%0.dump" 2>>"%TEMP%\%0.trc" CALL %0 _parentDir_x "%Windir%\system32"
    >>"%TEMP%\%0.dump" 2>>"%TEMP%\%0.trc" CALL %0 _parentDir_y "%Windir%\system32\Logfiles"
    set _parentDir>"%TEMP%\%0.dump"
    
    :: Convert to hexdump
    CALL HexDump.cmd /A /O "%TEMP%\%0.dump" >"%TEMP%\%0.hexdump" 2>>"%TEMP%\%0.trc"
GOTO :EOF *** _ParentDir ***

::----------------------------------------------------------------------