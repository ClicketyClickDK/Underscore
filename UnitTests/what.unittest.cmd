
::----------------------------------------------------------------------

:_UnitTest_what
    SHIFT
    SETLOCAL
    SET $NAME=%$NAME:.unittest=%
    
    SET $SOURCE=%~dp0%0
    FOR /F "tokens=*" %%A IN ('findstr /I /R /C:"^SET[ ]\$DESCRIPTION" "%~f0"') DO CALL %%A
    FOR /F "tokens=*" %%A IN ('findstr /I /R /C:"^SET[ ]\$AUTHOR" "%~f0"') DO CALL %%A
    FOR /F "tokens=*" %%A IN ('findstr /I /R /C:"^[ ]*SET[ ]\$VERSION" "%~f0"') DO SET $$=%%A
    ::&ECHO %%A
    :: Expand version
    %$$%
    ::SET $
        
    ENDLOCAL&SET _#NAME=%~n0&SET _#DESCRIPTION=%$DESCRIPTION%&SET _#REVISION=%$REVISION%&SET _#VERSION=%$VERSION%&SET _#Author=%$AUTHOR%&SET _#Source=%$SOURCE%

    :: Create ref
    (
        REM ::  SET $VERSION=01.000&SET $REVISION=2013-12-27T16:47:00&SET $Comment=ErikBachmann/Initial
        REM ::ECHO:[test] v.[01.000] rev.[2013-12-27T16:47:00]


        REM ::[what] v.[2014-02-18] rev.[10:58:00]
        REM ::
        ECHO:%_#NAME% v.%_#VERSION% rev.%_#REVISION%
        ECHO:

        REM ::NAME
        REM ::  what -- Search file for pattern '@(#)' and print remainder of string
        REM ::
        ECHO:NAME
        ::ECHO:  %_#NAME% -- %_#DESCRIPTION%
        ::ECHO:  what -- Search file for pattern '@^(#^)' and print remainder of string
        ECHO:  what -- Find and display reference manual information from file
        ECHO:
        REM ::SYNOPSIS
        REM ::  what filename [pattern] {flags}
        REM ::  what filename [pattern]
        REM ::
        REM ::::OPTIONS
        REM ::::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
        REM ::::@  -html       Output in HTML format
        REM ::::@  -history    Display file history
        ECHO:SYNOPSIS
        ECHO:  what file-name [pattern] {flags}
        ECHO:  what file-name [pattern]
        ECHO:
        ECHO:OPTIONS
        ECHO:  -html       Output in HTML format
        ECHO:  -history    Display file history
        ECHO:
        REM ::DESCRIPTION
        REM ::  Reads each file name and searches for sequences of the form
        REM ::  '@(#)', as inserted by the source code control system (SCCS)
        REM ::  It prints the remainder of the string following this marker,
        REM ::  up to a null character, newline, double quote, or "{GT}" character.
        REM ::
        ECHO:DESCRIPTION
        ECHO:  Reads each file name and searches for sequences of the form
        ECHO:  ^'@^(#^)^', as inserted by the source code control system ^(SCCS^)
        ECHO:  It prints the remainder of the string following this marker,
        ECHO:  up to a null character, newline, double quote, or '^>' character.
        ECHO:

        REM ::  So masking the VERY special characters is needed:
        REM ::  Â¤	{CURREN}	Currency
        REM ::  &	{AMP}		Ampersant
        REM ::  ^	{CARET }		Caret
        REM ::  >	{GT}		Greater than
        REM ::  <	{LT}		Less than
        REM ::  |	{PIPE}		Pipe or vertical bar
        REM ::  (c)	{COPY}		Copyright
        REM ::  (	{LPAR}		Left parentenses
        REM ::  )	{RPAR}		Right parentenses
        REM ::  {	{LCURL}		Left curly parentenses
        REM ::  }	{RCURL}		Right curly parentenses
        REM ::
        ECHO:  So masking the VERY special characters is needed:
        ECHO:  Ï	{CURREN}	Currency
        ECHO:  ^&	{AMP}		Ampersand
        ECHO:  ^^	{CARET}		Caret
        ECHO:  ­	{EXCL}		Exclamation mark
        ECHO:  ^>	{GT}		Greater than
        ECHO:  ^<	{LT}		Less than
        ECHO:  ^|	{PIPE}		Pipe or vertical bar
        ECHO:  ^(c^)	{COPY}		Copyright
        ECHO:  ^(	{LPAR}		Left parentheses
        ECHO:  ^)	{RPAR}		Right parentheses
        ECHO:  {	{LCURL}		Left curly parentheses
        ECHO:  }	{RCURL}		Right curly parentheses
        ECHO:  %%	{PCT}		Percent
        ECHO:  ?	?		Question mark
        ECHO:

        REM ::  A pattern may be given to replace the x in (x) like:
        REM ::
        REM ::     what file pattern
        REM ::
        ECHO:  A pattern may be given to replace the x in ^(x^) like:
        ECHO:
        ECHO:     %_#NAME% file pattern
        ECHO:

        REM ::  Will print all lines with the sequence: '@(pattern)'
        REM ::  Note: Patterns are case insensitive
        REM ::
        ECHO:  Will print all lines with the sequence: '@^(pattern^)'
        ECHO:  Note: Patterns are case insensitive
        ECHO:
        REM ::EXAMPLES
        REM ::  %$NAME% what.cmd
        REM ::
        REM ::
        REM ::EXIT STATUS
        REM ::     0   Any matches were found.
        REM ::     1   No matches found.
        REM ::
        ECHO:EXAMPLES
        REM ::@(-)  Some examples of common usage.
        ECHO:  what what.cmd
        ECHO:
        ECHO:
        ECHO:EXIT STATUS
        rem ::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
        ECHO:     0   Any matches were found.
        ECHO:     1   No matches found.
        ECHO:
        REM ::SOURCE
        REM ::  C:\_\what.cmd
        REM ::
        REM ::(c)2014 Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
        ECHO:SOURCE
        ECHO:  %_#SOURCE%
        ECHO:
        ECHO:(c^)%_#VERSION:~0,4% %_#Author%
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

::    DIR "%TEMP%\%0.ref_"

    ::CALL HexDump /A /O "%TEMP%\%0.ref" >"%TEMP%\%0.hexref" 2>>"%TEMP%\%0.trc"

    :: Dump test data
    >"%TEMP%\%0.dump" 2>>"%TEMP%\%0.trc" CALL %0 "%~f0"

    :: Convert to hexdump
    ::CALL HexDump /A /O "%TEMP%\%0.dump" >"%TEMP%\%0.hexdump" 2>>"%TEMP%\%0.trc"

::    FC "%TEMP%\%0.ref_" "%TEMP%\%0.dump" >diff.txt
GOTO :EOF *** what ***

::----------------------------------------------------------------------
