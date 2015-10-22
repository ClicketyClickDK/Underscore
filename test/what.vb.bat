@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
cls
CALL _DEBUG
::ECHO ON
CALL _getopt %* 
::||ECHO out&EXIT /B 1
SET _fileName=%~1


::echo WHAAAAAT?
::GOTO :EOF
:: Hide pattern for this very script ;-)
    SET _PATTERN=SET ^$
    ::FOR /F "TOKENS=1*" %%a IN ('find /i "%_PATTERN%" ^<"%_FileName%"') DO ECHO --[%%a][%%b]
    FOR /F "TOKENS=1*" %%a IN ('find /i "%_PATTERN%" ^<"%_FileName%"') DO (
            IF /I "SET"=="%%a" (
                %_DEBUG_%  ---[%%a] [%%b] [%%c]
                CALL :SETENV "%%a %%b"
            ) ELSE (
                %_DEBUG_%  skipping [%%a %%b]
            )
    )

SET $NAME=%_fileName:~0,-4%
SET $SOURCE=%~f1
"%windir%\System32\cscript.exe" //nologo  f.vbs "%_FileName%" "@\(#\)" %2


GOTO :EOF

::----------------------------------------------------------------------

:: Setting environment variables from sub script
:SETENV
:: NOTE $Source must be handled separately, since the $source referes to %~f0
:: which will be expanded in What's scope
    ECHO:"%~1" | FINDSTR /I " $source="  1>NUL 2>&1

    SET _result=%ErrorLevel%

    IF "0"=="%_result%" (
        %_DEBUG_% Match SET $SOURCE=%_SourceName%
        CALL SET $SOURCE=%_SourceName%
    ) ELSE (
        %_DEBUG_% No match %_result% %~1
        CALL %~1
        %_DEBUG_% subdefine: %~1
    )

GOTO :EOF

::----------------------------------------------------------------------
