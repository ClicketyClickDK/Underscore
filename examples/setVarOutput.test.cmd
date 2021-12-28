@ECHO OFF

ECHO Listing test script file and storing DIR output in XX
ECHO:
CALL SETVAROUTPUT XX "dir %0"
:: & set xx & CALL unwrapstr "%XX%"

:: Testing output
ECHO ^>^>^> Raw output ^>^>^>
::SET XX
ECHO %XX%
ECHO ^<^<^< Raw output ^<^<^<
ECHO:
ECHO ----------
ECHO:
ECHO ^>^>^> Expanded output ^>^>^>
::CALL ECHO "%%%~1%%" | \_\jrepl "\\n" "\x0D\x0A" /x  | \_\jrepl "\q(.*)" "$1" /x
CALL unwrapstr "%XX%"
ECHO ^<^<^< Expanded output ^<^<^<
ECHO:
