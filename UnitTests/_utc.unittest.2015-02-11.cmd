
::----------------------------------------------------------------------

:_UnitTest__utc
    SHIFT

    :: Create ref
    
     >"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc" ECHO 0
    >>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc" ECHO 0
     
    CALL HexDump.cmd /A /O "%TEMP%\%0.ref" >"%TEMP%\%0.hexref" 2>>"%TEMP%\%0.trc"
    
    :: Dump test data
    >"%TEMP%\%0.out" 2>>"%TEMP%\%0.trc" ( CALL %0 xx&set utc )
    ::findstr "^UTC=20[012][0-9]-[01][0-9]-[0-2][0-9]T[0-2][0-9]:[0-5][0-9]:[0-5][0-9],[0-9][0-9]$" "%TEMP%\%0.out" >nul
    ::UTC=2014-02-07T09:08:45
    findstr "^UTC=20[012][0-9]-[01][0-9]-[0-2][0-9]T[0-2][0-9]:[0-5][0-9]:[0-5][0-9]$" "%TEMP%\%0.out" >nul
    ECHO:%ERRORLEVEL%>"%TEMP%\%0.dump"
    
    ::findstr "^UTC_FILE=20[012][0-9]-[01][0-9]-[0-2][0-9]T[0-2][0-9]-[0-5][0-9]-[0-5][0-9]-[0-9][0-9]$" "%TEMP%\%0.out">nul
    ::UTC_FILE=2014-02-07T09_17_44.065000+060
    ::                 YY Y    Y   - M   M   - D    D   T H    H     m    m     s    s   . h    h    h    h    h    h   + z    z    z
    ::findstr "^UTC_FILE=20[012][0-9]-[01][0-9]-[0-2][0-9]T[0-2][0-9]-[0-5][0-9]-[0-5][0-9].[0-9][0-9][0-9][0-9][0-9][0-9].[0-9][0-9][0-9]$" "%TEMP%\%0.out">nul
    findstr "^UTC_FILE=20[012][0-9]-[01][0-9]-[0-2][0-9]T[0-2][0-9]-[0-5][0-9]-[0-5][0-9]." "%TEMP%\%0.out">nul
    ECHO:%ERRORLEVEL%>>"%TEMP%\%0.dump"
    
    :: Convert to hexdump
    CALL HexDump.cmd /A /O "%TEMP%\%0.dump" >"%TEMP%\%0.hexdump" 2>>"%TEMP%\%0.trc"
GOTO :EOF *** _utc ***



:: http://ss64.com/nt/findstr-escapes.html
REM ::On Vista and Windows7/2008 the maximum allowed length for a single search 
REM string is 511 bytes. If any search string exceeds 511 then the result is a 
REM FINDSTR: Search string too long. error with ERRORLEVEL 2.

REM When doing a regular expression search, the maximum search string length is 254. 
REM A regular expression with length between 255 and 511 will result in a FINDSTR: 
REM Out of memory error with ERRORLEVEL 2. A regular expression length >511 results in
REM the FINDSTR: Search string too long. error.

REM https://groups.google.com/forum/#!topic/alt.msdos.batch.nt/n36VGULacVU
REM FINDSTR's limit is 127 characters.


REM http://alt.msdos.batch.nt.narkive.com/Oixc1sqZ/workaround-for-error-findstr-search-string-too-long
REm findstr /b /c:"%mylinebegin%" "%myfile%" | findstr /e /c:"%mylineend%"



:: findstr "^UTC=20[012][0-9]-[01][0-9]-[0-2][0-9]T[0-2][0-9]:[0-5][0-9]:[0-5][0-9],[0-5][0-9]$" out.txt
:: ECHO %ERRORLEVEL%
:: findstr "^UTC_FILE=20[012][0-9]-[01][0-9]-[0-2][0-9]T[0-2][0-9]-[0-5][0-9]-[0-5][0-9]-[0-5][0-9]$" out.txt
:: ECHO %ERRORLEVEL%

::----------------------------------------------------------------------
