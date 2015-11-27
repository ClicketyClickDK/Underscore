
::---------------------------------------------------------------------

:_UnitTest_htree
SETLOCAL
    SHIFT
    
    >>"%_TEMPDIR%\%0.trc" ECHO %0

    :: Create ref
    >>"%_TEMPDIR%\%0.trc" ECHO :: Create ref
 ::   SET _REF_=^>^>"%_TEMPDIR%\%0.ref" 2^>^>"%_TEMPDIR%\%0.trc" ECHO
    (
        ECHO:ÀÄÄÄ#$#First
        ECHO:    ÃÄÄÄ#$#secondA
        ECHO:    ³   ÀÄÄÄ#$#thierdA
        ECHO:    ÀÄÄÄ#$#secondB
        ECHO:        ÀÄÄÄ#$#thierdA

REM        ECHO:Ã€Ã„Ã„Ã„#$#First
REM        ECHO:    ÃƒÃ„Ã„Ã„#$#secondA
REM        ECHO:    Â³   Ã€Ã„Ã„Ã„#$#thierdA
REM        ECHO:    Ã€Ã„Ã„Ã„#$#secondB
REM        ECHO:        Ã€Ã„Ã„Ã„#$#thierdA
    )>"%_TEMPDIR%\%0.ref"

    ::MKDIR "%_TEMPDIR%\#$#First\#$#secondA\#$#thierdA"
    ::MKDIR "%_TEMPDIR%\#$#First\#$#secondB\#$#thierdA"
    
    FOR %%A IN ("\#$#First\#$#secondA\#$#thierdA" "#$#First\#$#secondB\#$#thierdA" ) DO (
        IF NOT EXIST "%_TEMPDIR%%%~A" MKDIR "%_TEMPDIR%%%~A"
    )

::  %$Name% [drive:][path] [/F] [/A] [^>html_tree.html] [2^>ascii_tree.txt]
:: 
::  /F   Display the names of the files in each folder.
::  /A   Use ASCII instead of extended characters. (NO HTML)

    :: Create dump
    >>"%_TEMPDIR%\%0.trc" ECHO :: Create dump

    CALL %0 %_TEMPDIR% >"%_TEMPDIR%\%0.html" 2>"%_TEMPDIR%\%0.tmp" 
    find "#$#" <"%_TEMPDIR%\%0.tmp" >"%_TEMPDIR%\%0.dump"

GOTO :EOF *** :_UnitTest__htree ***

::---------------------------------------------------------------------