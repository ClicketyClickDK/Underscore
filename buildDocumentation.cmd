@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Unit test processing
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)      %$NAME% [VAR]
::@(#)  %$Name%
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Loops through scripts in current directory and executes
::@(#)  any matching unit test in the unit test directory.
::@(#)  For each script a status of "OK", "Not available" or "FAIL"
::@(#)  is displayed.
::@(#)  Log files with respectively failing and missing unit tests
::@(#)  are produced and displayed after running the tests.
::@(#)
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  buildDocumentation.cmd
::@(#)  buildDocumentation -- Unit test processing
::@(#)  v. 2015-10-08 r. 11:20:00
::@(#)  
::@(#)  Clean up                                     [Done                            ]
::@(#)  Documentation directory                      [Found                           ]
::@(#)  Html index                                   [Opened                          ]
::@(#)  Documentation JavaScript                     [Done                            ]
::@(#)  Build Script list                            [Build and sorted                ]
::@(#)  No of scripts to process                     [88                              ]
::@(#)  
::@(#)  - 0template.cmd                              [Done                            ]
::@(#)  - banner.cmd                                 [Done                            ]
::@(#)  - BatchSubstitude.bat                        [Done                            ]
::@(#) *** skip ***
::@(#)  - _UTC.cmd                                   [Done                            ]
::@(#)  - _utf2ansi.cmd                              [Done                            ]
::@(#)  - _utf2oem.cmd                               [Done                            ]
::@(#) 
::@(#)  Html index                                   [Closed                          ]
::@(#)  Total scripts                                [88                              ]
::@(#)  buildDocumentation                           [Done                            ]
::@(#)
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)
::@ (#)ENVIRONMENT
::@(-)  Variables affected
::@ (#)
::@ (#)
::@ (#)FILES, 
::@(-)  Files used, required, affected
::@ (#)
::@ (#)
::@ (#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@ (#)
::@ (#)
::@(#)REQUIRES
::@(-)  Dependecies
::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::@(#)  _GetOpt.cmd     Parse command line options and create environment vars
::@(#) 
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  
::@ (#)  
::@ (#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@ (#)  URL: 
::@ (#) 
::@(#)
::@(#)SOURCE
::@(-)  Where to find this source
::@(#)  %$Source%
::@(#)
::@ (#)AUTHOR
::@(-)  Who did what
::@ (#)  %$AUTHOR%
::*** HISTORY **********************************************************
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init Description [xx.xxx]
::SET $VERSION=2010-10-20&SET $REVISION=00:00:00&SET $COMMENT=Initial [01.000]
::SET $VERSION=2010-11-12&SET $REVISION=16:23:00&SET $COMMENT=Adding exact path to _prescript/ErikBachmann [01.010]
::SET $VERSION=2015-02-18&SET $REVISION=23:33.00&SET $COMMENT=Status on missing/failing scripts/ErikBachmann
::SET $VERSION=2015-02-19&SET $REVISION=03:14:08&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

:MAIN
    CALL :UnitTest.init
    CALL :UnitTest.process
    CALL :UnitTest.finalize
GOTO :EOF :Main

::----------------------------------------------------------------------

:UnitTest.init
    CALL "%~dp0\_debug"
    FOR %%a IN (CON: "%$TraceFile%" "%$LogFile%") DO (
        ECHO:%$NAME% -- %$DESCRIPTION%
        ECHO:v. %$VERSION% r. %$REVISION%
        ECHO:
    )>>%%a

    SET _ScriptTypes=cmd bat vbs
    SET _ScriptList=%Tmp%\%~n0.ScriptList.txt
    SET _TestMissingList=%Tmp%\%~n0.TestMissing.txt
    SET _TestFailingList=%Tmp%\%~n0.TestFailing.txt

    SET _UnitTestsTotalCount=0
    SET _UnitTestFailCount=0
    SET _UnitTestMissingCount=0
    SET _DocDir=%~dp0\Documentation\
    %_TRACE_% %0 Done
    
GOTO :EOF :UnitTest.init

::----------------------------------------------------------------------

:UnitTest.Process
    
    CALL _Action "Clean up"
    PUSHD "%~dp0"
    IF EXIST "%Tmp%\%~n0.*" DEL "%Tmp%\%~n0.*"
    CALL _Status "Done"

    CALL _Action "Documentation directory"
    IF NOT EXIST "%_DocDir%" (
        MKDIR "%_DocDir%"
        IF ERRORLEVEL 1 ( 
            CALL _Status "ERROR Cannot create [%_DocDir%]"
        ) ELSE (
            CALL _Status "Created"
        )
    ) ELSE (
        CALL _Status "Found"
    )
    
    CALL _Action "Html index"
    
    (   REM Main index file = frameset
        ECHO:^<frameset cols="20%%,*"^>
        ECHO:   ^<frame src="index.frame.html"^>
        ECHO:   ^<frame src="../readme.html" name="main"^>
        ECHO:^</frameset^> 
    )>Documentation\index.html

    (   REM Index in left frame
        ECHO:^<a href="../readme.html" target="main"^>
        ECHO:^<H1^>Documentation index^</H1^>^</a^>^<ul^>
        ECHO:^<link rel="stylesheet" href="../underscore.css" type="text/css" /^>
        ECHO:^<script language="JavaScript" src="../underscore.js" type="text/javascript"^>^</script^>
    )>Documentation\index.frame.html 
    
    
    (   REM Index in left frame
        ECHO:    
        ECHO:^<a href="../readme.html" target="main"^>^<H1^>Documentation index^</H1^>^</a^>
        ECHO:^<link rel="stylesheet" href="../underscore.css" type="text/css" /^>
        ECHO:^<script language="JavaScript" src="what.js" type="text/javascript"^>^</script^>
        ECHO:^<ol^>
        ::ECHO:^<li^>^<a href="../readme.html#_" target="main"^>_^</a^>
        ECHO:^<li^>^<a href="../readme.html#WhatsItAllAbout" target="main"^>WhatsItAllAbout^</a^>
        ECHO:^<li^>^<a href="../readme.html#Structure" target="main"^>Structure^</a^>
        ECHO:^<ol^>
        ECHO:	^<li^>^<a href="../readme.html#DirectoryStructure" target="main"^>DirectoryStructure^</a^>
        ECHO:	^<li^>^<a href="../readme.html#ScriptStructure" target="main"^>ScriptStructure^</a^>
        ECHO:^</ol^>
        ECHO:^<li^>^<a href="../readme.html#UnitTests" target="main"^>UnitTests^</a^>
        ECHO:^<ol^>
        ECHO:	^<li^>^<a href="../readme.html#WrittingAUnitTest" target="main"^>WrittingAUnitTest^</a^>
        ECHO:	^<li^>^<a href="../readme.html#SimpleComparison" target="main"^>SimpleComparison^</a^>
        ECHO:	^<li^>^<a href="../readme.html#HexDump" target="main"^>HexDump^</a^>
        ECHO:	^<li^>^<a href="../readme.html#PatternMatching" target="main"^>PatternMatching^</a^>
        ECHO:	^<li^>^<a href="../readme.html#SkippingTest" target="main"^>SkippingTest^</a^>
        ECHO:^</ol^>
        ECHO:
        ECHO:^<li^>^<a href="../readme.html#LogDebugTraceAndTemporaryFiles" target="main"^>LogDebugTraceAndTemporaryFiles^</a^>
        ECHO:^<li^>^<a href="../readme.html#Installation" target="main"^>Installation^</a^>
        ECHO:^<ol^>
        ECHO:	^<li^>^<a href="../readme.html#FirstTimeInstallation" target="main"^>FirstTimeInstallation^</a^>
        ECHO:	^<li^>^<a href="../readme.html#Updating" target="main"^>Updating^</a^>
        ECHO:^</ol^>
        ECHO:^<li^>^<a href="../readme.html#How-To" target="main"^>How-To^</a^>
        ECHO:^<li^>^<a href="../readme.html#BugFixes" target="main"^>BugFixes^</a^>
        ECHO:^</ol^>
        ECHO:    )>Documentation\index.frame.html 


    CALL _Status "Opened"
    
    CALL _Action "Documentation JavaScript"
    (   REM Java script
        ECHO:function linkMe^(link^) {
        ECHO:    url = link.replace ^(/\.[^\.]*$/, ''^)
        ECHO:    url += '.html'
        ECHO:    document.write^("<a href='" + url + "' title='Jump to HELP on [" + link + "]'>" + link + "</a>"^)
        ECHO:}
    )>Documentation\underscore.js
    CALL _Status "Done"

    REM CALL _Action "Documentation Style Sheet"
    REM IF NOT EXIST "Documentation\what.css" (
        REM (   REM CSS Style Sheet
            REM ECHO:body { Background: #F5FFFF; /* Light cyan */ }
            REM ECHO:h2 {
            REM ECHO:    Background:    #BDEDFF;    /* Light blue */
            REM ECHO:    Background:    #B8E6E6;
            REM ECHO:    color:         Red;
            REM ECHO:    margin:        0px;
            REM ECHO:}
            REM ECHO:h3 {
            REM ECHO:    Background:    #BDEDFF;    /* Light blue */
            REM ECHO:    Background:    #CCFFFF;
            REM ECHO:    color:         Blue;
            REM ECHO:    margin:        5px;
            REM ECHO:}
            REM ECHO:h4 {
            REM ECHO:    Background:    #BDEDFF;    /* Light blue */
            REM ECHO:    Background:    #CCFFFF;
            REM ECHO:    color:         Green;
            REM ECHO:}
            REM ECHO:tt {
            REM ECHO:   color:          purple;
            REM ECHO:   color:          #001A4C;
            REM ECHO:}
            REM ECHO:hr { width: 10% }
        REM )>Documentation\what.css
        REM CALL _Status "Done"
    REM ) ELSE (
        REM CALL _Status "Found"
    REM )
    
    CALL _Action "Build Script list"
    FOR %%a IN (%_ScriptTypes%) DO DIR /B *.%%a >>"%_ScriptList%.tmp" 2>>"%$TraceFile%"
    SORT < "%_ScriptList%.tmp"|FIND /v /I "%~nx0" >>"%_ScriptList%"
    CALL _STATUS "Build and sorted"
    IF NOT "0"=="%DEBUG%" (
        ECHO:- Check the list of scripts in [%_ScriptList%]
        ECHO:pause
    )
    CALL _ACTION "No of scripts to process"
    FOR /F %%a IN ('FIND /c "." ^<"%_ScriptList%"') DO SET _ScriptsTotalCount=%%a
    CALL _Status "%_ScriptsTotalCount%"
    ECHO:
    
::    FOR /F %%a IN (%_ScriptList%) DO CALL :UnitTest.ProcessScript "%%a"
    (
        ECHO:Functions
        ECHO:^<ul^>
    )>>Documentation\index.frame.html 
    FOR /F %%a IN ('TYPE %_ScriptList%^|findstr -v "^_"') DO CALL :UnitTest.ProcessScript "%%a"
    (
        ECHO:^</ul^>
        ECHO:Subfunctions
    )>>Documentation\index.frame.html 
    FOR /F %%a IN ('TYPE %_ScriptList%^|findstr "^_"') DO CALL :UnitTest.ProcessScript "%%a"
GOTO :EOF :UnitTest.Process

::----------------------------------------------------------------------

:UnitTest.finalize

    ECHO:
    CALL _Action "Html index"
    ECHO ^</ul^>^<HR^> >>Documentation\index.frame.html 
    CALL _Status "Closed"

    CALL _Action "Total scripts"
    CALL _Status "%_ScriptsTotalCount%"
    REM CALL _Action "Total unit tests"
    REM CALL _Status "%_UnitTestsTotalCount%"
    REM CALL _Action "Tests failing"
    REM CALL _Status "%_UnitTestFailCount%"
    REM CALL _Action "Tests not available"
    REM CALL _Status "%_UnitTestMissingCount%"

    REM CALL _Action "Missing scripts list"
    REM IF EXIST "%_TestMissingList%" (
        REM CALL _Status "Opening"
        REM START "Missing scripts" /B notepad "%_TestMissingList%"
    REM ) ELSE (
        REM CALL _Status "Skip"
    REM )

    ::ECHO ---------------------------------------------------
    REM CALL _Action "Failing scripts list"
    REM IF EXIST "%_TestFailingList%" (
        REM CALL _Status "Opening"
        REM START "Failing tests"   /B notepad "%_TestFailingList%"
    REM ) ELSE (
        REM CALL _Status "Skip"
    REM )

    CALL _Action "%$NAME%"
    CALL _Status "Done"
GOTO :EOF :UnitTest.finalize

::----------------------------------------------------------------------

:UnitTest.ProcessScript

    SET _Script=%~1
    SET _UnitTest=UnitTest\%~n1.UnitTest%~x1

    TITLE %_Script% - documentation
    CALL _Action "- %_Script%"

    REM IF EXIST "%_UnitTest%" (
        REM CALL :UnitTest.TestScript
    REM ) ELSE (
        REM CALL _Status "Not available"
        REM CALL SET /A _UnitTestMissingCount+=1
        REM ECHO %_Script% >>"%_TestMissingList%"
    REM )
    CALL _state "*** building ***"

    CALL what.cmd "%~1" >Documentation\%~n1.txt 
    CALL what.cmd "%~1" -html >Documentation\%~n1.html  
    ECHO ^<li^>^<a href="%~n1.html" target="main"^>%~n1^</a^>  >>Documentation\index.frame.html 
    CALL _status "Done"

GOTO :EOF :UnitTest.ProcessScript

::----------------------------------------------------------------------

REM :UnitTest.TestScript
    REM CALL SET /A _UnitTestsTotalCount+=1
    REM CALL _State "Test found - running.."
    REM SET ErrorLevel=
    REM CALL "%_UnitTest%" >> "%$LogFile%" 2>>"%$TraceFile%"
    REM IF ErrorLevel 1 ( 
        REM CALL _Status "FAIL [%ErrorLevel%]"
        REM CALL SET /A _UnitTestFailCount+=1
        REM ECHO:%_UnitTest%>>"%_TestFailingList%"
    REM ) ELSE (
        REM CALL _Status "OK" 
    REM )
    
REM GOTO :EOF :UnitTest.TestScript

::*** End Of Line *****************************************************