@ECHO OFF
IF NOT EXIST "%~1" COPY NUL "%~1"
COPY /B "%~1"+,,
DIR "%~1"
