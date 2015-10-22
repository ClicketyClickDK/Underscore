@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)


SET _Filename=expand.ref
SET _WHAT=@^(#^)
    FOR /F "tokens=1* delims=)" %%a IN ('find /i "%_WHAT%" ^< "%_FileName%"') DO (
        CALL :ExpandEnv "%%b"
    )
GOTO :EOF

::----------------------------------------------------------------------

:: Expanding variables inside what strings
:ExpandEnv
    SETLOCAL ENABLEDELAYEDEXPANSION
    SET _=%*
    SET _=%_:~1,-1% 
::    SET _=%_:(={%
::    SET _=%_:)={%
    SET _=%_:(={lPar}%
    SET _=%_:)={rPar}%
    SET _=%_:&={amp}%
::    SET _=%_:^^={caret}%
::    SET _=%_:|={pipe}%
    SET _=%_:"='%
    SET _=%_:^^=x%
::    SET _=%_:}LT}=®%
::    SET _=%_:}GT}=¯%
::    SET _=%_:}PIPE}=^^^|%

::    CALL SET _=%_:}LT}=^^^^^^^<%
::    CALL SET _=!_:}GT}=^^^>!

    IF DEFINED _HTML GOTO :Expand2HTML
    GOTO :Expand2Text

:Expand2HTML
        IF "{"=="%_:~0,1%" (
			:: Sub paragraph (Deprecated!)
            ECHO:^<h4^>%_: =^&nbsp;%^</h4^>
        ) ELSE IF " "=="%_:~0,1%" (
		    :: Ordinary text
			CALL SET "_=%_:{curren}=&curren;%"
			CALL SET "_=!_:{LT}=&lt;!"
			CALL SET "_=!_:{GT}=&gt;!"

			CALL SET "_=!_:{lPar}=(!"
			CALL SET "_=!_:{rPar}=)!"
			CALL SET "_=!_:{lCurlPar}={!"
			CALL SET "_=!_:{rCurlPar}=}!"
			CALL SET "_=!_:{pipe}=|!"
			CALL SET "_=!_:{copy}=&copy;!"
			CALL SET "_=!_: =!"
			CALL SET "_=!_: =&nbsp;!"
			CALL SET "_=!_:	=&#09;&#09;!"
			CALL SET "_=!_:	=&#09;&#09;!"
				
			CALL SET "_=!_:{amp}=&amp;!"
			CALL SET "_=!_:{caret}=&#94;!"

			ECHO:^<tt^>!_!^</tt^>^<br^>
        ) ELSE (
			:: Headlines
			CALL SET "_=!_:{copy}=&copy;!"
			CALL SET "_=!_:{lPar}=(!"
			CALL SET "_=!_:{rPar}=)!"
			CALL SET "_=!_:{lCurlPar}={!"
			CALL SET "_=!_:{rCurlPar}=}!"
            ECHO:^<h3^>!_!^</h3^>
        )
GOTO :EOF

:Expand2Text
::SETLOCAL DisABLEDELAYEDEXPANSION
        CALL SET "_=%_:{LT}=>%"
        CALL SET "_=%_:{GT}=>%"
        CALL SET "_=%_:{lPar}=(%"
        CALL SET "_=%_:{rPar}=)%"
        CALL SET "_=%_:{pipe}=^^^|%"
        CALL SET "_=%_:{amp}=&%"
        CALL SET "_=%_:{copy}=(c)%"
        CALL SET "_=%_: =%"
        CALL SET "_=%_:{lCurlPar}={%"
        CALL SET "_=%_:{rCurlPar}=}%"
        CALL SET "_=%_:{caret}=^%"
        CALL SET "_=%_:{excl}=!%"
        CALL SET "_=%_:{PCT}=%%%%%%"
        ::CALL SET "_=%_:{curren}=¤"
        ::ECHO:!_!
        
    CALL ECHO:!_!
::ENDLOCAL
GOTO :EOF

