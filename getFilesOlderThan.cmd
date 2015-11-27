@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=List files older than x days
SET $Author=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $Source=%~f0
::----------------------------------------------------------------------
::@(#)NAME
::@(#)  %$Name% -- %$Description%
::@(#) 
::@(#)SYNOPSIS
::@(#)  %$Name% [files] [days] [date]
::@(#) 
::@(#)  files   *.* File mask
::@(#)  days    30  No of days in valid span
::@(#)  date    now Reference date
::@(#) 
::@(#)DESCRIPTION
::@(#)  List files older than a predefined no of days
::@(#) 
::@(#)EXAMPLE
::@(#)      CALL %$Name% *.* 10 2012-12-10
::@(#)  Should echo
::@(#)      Files from before 2012-12-01
::@(#)
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  _GetOpt.cmd     Parse command line options and create environment vars
::@(#) 
::@ (#)URL
::@(#)  
::EXIT STATUS
::
::     The following exit values are returned:
::     0   Any matches were found.
::     1   No matches found.
::
::@(#)SOURCE
::@(#)  %$Source%
::@(#) 
::----------------------------------------------------------------------
:: History
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init / Description [xx.xxx]
::SET $VERSION=2014-02-05&SET $REVISION=13:23:00&SET $COMMENT=Init/Erik [01.000]
::SET $VERSION=2015-02-18&SET $REVISION=15:54:00&SET $COMMENT=ECHO^. to ECHO:
::SET $VERSION=2015-02-19&SET $REVISION=02:59:39&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1


:main
    CALL :init %*
    CALL :process
    CALL :finalize
GOTO :EOF

::---------------------------------------------------------------------

:init
    :: files days 
    SET "_files=%~1"
    IF NOT DEFINED _files SET _FILES=*.*
    SET "_days=%~2"
    IF NOT DEFINED _days SET _days=30
    SET "_tnow=%~3"
    ::IF NOT DEFINED _tnow CALL :jdate _tnow
    IF DEFINED _tnow GOTO :EOF
    
    CALL shortDate2Iso _tnow %date% 
    rem IF DEFINED DEBUG IF NOT "0"=="%DEBUG%" ECHO:_tnow[iso]=%_tnow%
    ::CALL :jdate _tnow %_tnow%
    CALL date2jdate _tnow %_tnow%
    rem IF DEFINED DEBUG IF NOT "0"=="%DEBUG%" ECHO:_tnow[jdate]=%_tnow%
GOTO :EOF

::---------------------------------------------------------------------

:process
    FOR %%a IN (%_files%) DO (
        CALL ftime _tfile "%%a"

        CALL set /a "_diff=!_tnow! - !_tfile!"

        IF DEFINED DEBUG IF NOT "0"=="%DEBUG%" CALL FormatStr "{30}: {10} - {10} = {10} / {5}" "%%a" "!_tnow!" "!_tfile!" "!_diff!" "!_days!"

        IF !_diff!0 GTR !_days!0 CALL FormatStr "{45}: {20}" "%%a" "%%~ta"
    )
GOTO :EOF

::---------------------------------------------------------------------

:finalize
GOTO :EOF

::---------------------------------------------------------------------

:ftime JD filename attr -- returns the file time in julian days
::                      -- JD    [out]    - valref file time in julian days
::                      -- attr  [in,opt] - time field to be used, creation/last-access/last-write, see 'dir /?', i.e. /tc, /ta, /tw, default is /tw
:$created 20060101 :$changed 20090322 :$categories DateAndTime
:$source http://www.dostips.com
SETLOCAL
set file=%~2
set attr=%~3
if not defined attr (call:jdate JD "- %~t2"
) ELSE (for /f %%a in ('"dir %attr% /-c "%file%"|findstr "^^[0-9]""') do call:jdate JD "%%a")
( ENDLOCAL & REM RETURN VALUES
    IF "%~1" NEQ "" (SET %~1=%JD%) ELSE (echo:%JD%)
)
EXIT /b

::---------------------------------------------------------------------

:jdate JD DateStr -- converts a date string to julian day number with respect to regional date format
::                -- JD      [out,opt] - julian days
::                -- DateStr [in,opt]  - date string, e.g. "03/31/2006" or "Fri 03/31/2006" or "31.3.2006"
:$reference http://groups.google.com/group/alt.msdos.batch.nt/browse_frm/thread/a0c34d593e782e94/50ed3430b6446af8#50ed3430b6446af8
:$created 20060101 :$changed 20090328 :$categories DateAndTime
:$source http://www.dostips.com
SETLOCAL
set DateStr=%~2&if "%~2"=="" set DateStr=%date%
for /f "skip=1 tokens=2-4 delims=(-)" %%a in ('"echo:|date"') do (
    for /f "tokens=1-3 delims=/.- " %%A in ("%DateStr:* =%") do (
        set %%a=%%A&set %%b=%%B&set %%c=%%C))
set /a "yy=10000%yy% %%10000,mm=100%mm% %% 100,dd=100%dd% %% 100"
if %yy% LSS 100 set /a yy+=2000 &rem Adds 2000 to two digit years
set /a JD=dd-32075+1461*(yy+4800+(mm-14)/12)/4+367*(mm-2-(mm-14)/12*12)/12-3*((yy+4900+(mm-14)/12)/100)/4
ENDLOCAL & IF "%~1" NEQ "" (SET %~1=%JD%) ELSE (echo:%JD%)
EXIT /b

::*** End of File *****************************************************