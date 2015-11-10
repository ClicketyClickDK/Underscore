# The _ Windows Batch Library
By [ErikBachmann@ClicketyClick.dk](mailto:ErikBachmann@ClicketyClick.dk&subject=The_Underscore_Library")

Latest update: 2015-10-22


## WHAT'S IT ALL ABOUT
>Mean, motive and opportunity

**The "_" Windows Batch Library** (*The "underscore" Windows Batch Library*) is a collection of generic, ready-to-use batch scripts, that I've developed and refined over the years. Most of the script are self-made, but other sources or inspiration are mentioned in either $AUTHOR or URL tags in the scripts headers.

Experience has learned me the hard way, that one cannot rely on pre-installed scripts and functionality. Often it is not possible to install binary tools like Cygwin, Unix tools or script interpreters like Perl or PHP. This leaves me with M$ tools like Debug, Basic, Visual Basic or Powerscript. Even these tools may not be available on every system.

The scripts in this library are all pure text based source code. You should be able to install them by simply copy the library directory onto your system - and you will be ready to Rock'n'roll!

The origin of the name is due to my own practises of installing the library in `C:\_\`. You're free to install in any directory of your own choice (like `%ProgramFiles%\_\`).

>Please note! This is a library and should be used in context. Scripts may have dependencies and requires other scripts in the library. Most requires **_debug.cmd** and **_GetOpt.cmd**. 

> **Do download the entire library!**

## STRUCTURE

### Directory structure

Let me assume, that you install the library in `%ProgramFiles%\_\`
The structure will then be:

* `%programFile%\_`
  * Scripts and sub-functions
* `%programFile%\_\.Archive`
  * Archived scripts and new scripts for update
* `%programFile%\_\bin`
  * Storage for binaries, I use frequently like Exiftool, SQLite, Blat, Putty
* `%programFile%\_\dev`
  * Test bench for new upcomming scripts
* `%programFile%\_\Documentation`
  * Documentation for each function with examples (text and HTML)
* `%programFile%\_\Tips`
  * Text description of Tips and tricks
* `%programFile%\_\UnitTests`
  * Unit Test Suite

### Script structure

Scripts can be pure WinDOS commands, jscript, VBscript - or a combination

The naming convention is as follows
* xxx.CMD
  * A conventional ready to use scripts.
* _xxx.CMD
  * A sub function that provide macro like functionality to be embedded in other scripts (i.e. has no real life of it's own).
* xxx.BAT
  * A wrapper to VBscript or Jscript functionality.

* xxx.CSV
  * Data file with reference data
* xxx.HTML
  * General documentation (like this file)
* xxx.CSS
  * Style Sheet for documentation


Each script has a header, with description of functionality, source of origin, examples. 
This is extracted to the documentation directory in a structured form using the `what` command .

The basic structure is as in the template `0template.cmd`


``` Batchfile
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Template for DOS batch script
SET $AUTHOR=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
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
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#) 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#) 
::@(#) 
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
::@ (#)REQUIRES
::@(-)  Dependencies
::@ (#)  
::@ (#)
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
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Description/init
  SET $VERSION=2015-02-19&SET $REVISION=00:00:00&SET $COMMENT=Initial/ErikBachmann
::**********************************************************************
::@(#){COPY}%$VERSION:~0,4% %$Author%
::**********************************************************************
::ENDLOCAL
```

Be careful to update the version section:
```
  SET $VERSION=2015-02-19&SET $REVISION=00:00:00&SET $COMMENT=Initial/ErikBachmann
```
Put `::` in front of the current line and insert an update below with current time, change and you name:
```
::SET $VERSION=2015-02-19&SET $REVISION=00:00:00&SET $COMMENT=Initial/ErikBachmann
  SET $VERSION=2015-10-14&SET $REVISION=00:00:00&SET $COMMENT=This is an update/ErikBachmann
```

Each script has ideally tree steps as described in the `:MAIN` section:

* `:init`
  * An initiation of all variables and call for initiating sub functions (like `_debug` or `_getopt`]
* `:Proccess`
  * The processing ..
* `:Finalize`
  * A Status reporting.

Any call to another script in the library the name should be prefixed with the drive and path to the calling script. Which is assumed to be in the same directory:

``` Batchfile
CALL "%~dp0\what"
```


## UNIT TESTS

Any script (function or sub-function) should have a unittest 
to verify the integrity of the script. 
These tests are stored in `_\unittests\` and run 
using the `unittest` command .

The Directory `UnitTests` contains a collection of unit tests for the functions.

Run the entire test suite using the command: `UnitTest.cmd`

Unittest can test an individual script:
``` Batchfile
C:\_>unittest what.cmd
what.cmd                                     [OK.                             ]
```

or the entire suite of scripts (no arguments):

```
C:\_>unittest

unittest v.2015-03-19 -- Unittest for Underscore
No arg
Name                                         [                                ]
Testing                                      [                                ]
Script Dir                                   [C:\_\                           ]
Unit test                                    [                                ]
Unit Test Dir                                [C:\_\UnitTests\                 ]
_MissingLog                                  [C:\Users\ERIKBA~1\AppData\Local ]
_FailedLog                                   [C:\Users\ERIKBA~1\AppData\Local ]
Scripts to process                           [83                              ]
:
:
shortDate2Iso.cmd                            [OK.                             ]
startScreenSaver.cmd                         [Skipped:Win internal=no test    ]
strstr.cmd                                   [OK.                             ]
tail.cmd                                     [OK.                             ]
test.date2jdate.cmd                          [Skipping: Test module. No funct ]
unittest.cmd                                 [Skipped:Template=no test        ]
unzip.bat                                    [OK.                             ]
Utc2JulianDate.cmd                           [OK.                             ]
wget.bat                                     [FAIL [2]                        ]
what.cmd                                     [OK.                             ]
which.cmd                                    [OK.                             ]
zip.bat                                      [OK.                             ]

Scripts processed                            [69                              ]
- Missing                                    [1                               ]
- Failed                                     [4                               ]
- Skipped                                    [14                              ]
- Succeeded                                  [64                              ]
Log files:
_MissingLog                                  [C:\Users\ERIKBA~1\AppData\Local ]
_FailedLog                                   [C:\Users\ERIKBA~1\AppData\Local ]

HKEY_LOCAL_MACHINE.failed.log
HKEY_LOCAL_MACHINE.missing.log
All run
```


* OK
  * UnitTest matched the expected result.
* FAIL
  * Unittest did _not_ match the expected result. Please consult the `xxx.trc`, `xxx.*dump` and `xxx.ref` files in the `%TEMP%` directory

* Skipped
  * Templates, test modules - and functionality that cannot be tested in a batch job will NOT be tested. This is indicated in the unit test.

### Writting a unit test

A script like `myScript.cmd` placed in `_` should have a valid unit test like `_\unitTests\myScript.unittest.cmd`

By default there are three methods of test:
1 Simple comparison of output `%temp%\myScript.cmd.dump` to a reference file (`%temp%\myScript.cmd.ref`)
2 Comparing hexdumps of output `%temp%\myScript.cmd.HEXdump` to a reference file (`%temp%\myScript.cmd.HEXref`)
3 Pattern matching on the output `%temp%\myScript.cmd.dump`

Rank:
1 IF "hexref" exists the hexdumps will be compared
2 If "ref" exists the ref and dump will be compared
3 Otherwise dump will be matched against patterns found in the original script

#### Simple comparison

Create a unit test file with a label named `:_UnitTest_myScript`.
This is required by the `unittest` script. 

Set a local environment using `SETLOCAL` and shift arguments one position (since the script name is first argument)

Write your reference to `%TEMP%\%0.ref`, test output to `%TEMP%\%0.dump` and any other output, info, debug, trace or whatever to `%TEMP%\%0.trc`

``` Batchfile
::----------------------------------------------------------------------
:_UnitTest_myScript
SETLOCAL
    SHIFT
    
    :: Create ref
    (
        ECHO:Hello World
    )>"%TEMP%\%0.ref" 2>>"%TEMP%\%0.trc"

    :: Dump data
    (
        CALL %0
    )>"%TEMP%\%0.dump"
    
GOTO :EOF *** :_UnitTest_myScript ***
::----------------------------------------------------------------------
```
In this example `myScript.cmd` is supposed to echo `Hello World` into `%temp%\myscript.dump`

#### Hexdump

``` Batchfile
::---------------------------------------------------------------------
:_UnitTest__cr
SETLOCAL
    SHIFT
    :: Create ref
    ECHO 00000000: 5B 0D 5D 0D 0A                                   [.]..>"%TEMP%\%0.HEXref" 2>>"%TEMP%\%0.trc"
    ::                ^^
    
    :: Dump test data
    >"%TEMP%\%0.dump" 2>>"%TEMP%\%0.trc" ECHO [!_CR!]

    :: Convert to hexdump
    CALL HexDump /A /O "%TEMP%\%0.dump" >"%TEMP%\%0.hexdump" 2>>"%TEMP%\%0.trc"
GOTO :EOF *** :_CR ***
::---------------------------------------------------------------------
```

#### Pattern matching

The dump file is tested using patterns stored in the `myScript.cmd` itself.
The patterns are stored in strings prefixed with `::MATCH::`. The strings are regular expressions as used by `FindStr`

See the matchTest for details

``` Batchfile
::*** Match strings for testing output --------------------------------
::# Test strings for test matching script.bat
::MATCH::SET.$DESCRIPTION
::MATCH:vSET.FAILURE
```
In this example output from `MatchText.cmd` are matched with "SET.$DESCRIPTION" 
(where "." is a wildcard matching any character)


#### Skipping test

If for some reason, a test is impossible or misleading, you can chose to skip testing the module (please don't!) by writting a short statement to `%temp\%0.skip` and then bail out.
``` Batchfile
:_UnitTest_UnitTest
SETLOCAL
    SHIFT
    :: Dummy test - UnitTest is a template. No functional test
    ECHO:<i>Skipped:Template=no test</i>>"%TEMP%\%0.skip" & GOTO :EOF
```

## LOG, DEBUG, TRACE AND TEMPORARY FILES

All temporary files are written to your local temporary directory using environment variables %TEMP% or %TMP%

## INSTALLATION

### FIRST TIME INSTALLATION

1. Create a directory to hold the library (like `%ProgramFiles%\_\` or `C:\_\`.
2. Download the current library from depository: [https://github.com/ClicketyClickDK/Underscore](https://github.com/ClicketyClickDK/Underscore)
3. Unzip the library to the chosen directory.
4. Run the `unittest` without any arguments (= test entire suite)
5. Ready to Rock'n'Roll!
	
### UPDATING

The library is maintained using the functions:
* `checkInArchive.cmd`
  * Make an archive version of batch jobs
* `checkoutArchive.cmd`
  * Checkout updates/install new units (Only if archived version is newer!)
* `updateArchive.cmd`
  * Download an update from ClicketyClick.dk
* `UnitTest.cmd`
  * Runs the test suite and updates documentation using What.cmd


Run the `updateArchive`
The script will connect to the repository, find and download the current version, and extract the newest versions of scripts from `.ARCHIVE`

_Please note_

IF you have made any local changes to the scripts PRIOR to the latest version in the repository. Your local change will be overwritten by the update.

However: You can find your local change in the backup in `.ARCHIVE` directory.
Before unpacking the latest version, at backup using `checkInArchive` command has "archived" your file in `.ARCHIVE\xxxx.yyyy-mm-ddThh-mm.cmd`, where "yyyy-mm-ddThh-mm" is the file date in ISO format.


Be very careful when updating the patched version:
1. Think about the consequences
2. Test intensively!!!
3. Send me the patch (please!!!!)


## HOW-TO..

Feel free..!

## BUG FIXES

**WHEN** you find a bug, require a modification or has any form of comment on this library - please do not hesitate to send me an email: [ErikBachmann@ClicketyClick.dk](mailto:ErikBachmann@ClicketyClick.dk&subject=The_Underscore_Library")

