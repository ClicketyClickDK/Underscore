# Tips2Tricks for DOS batch
By [ErikBachmann@ClicketyClick.dk](mailto:ErikBachmann@ClicketyClick.dk&subject=The_Underscore_Library")

Latest update: 2022-02-28

## String replacement using var
:link http://scripts.dragon-it.co.uk/scripts.nsf/docs/batch-search-replace-substitute!OpenDocument&ExpandSection=3&BaseTarget=East&AutoFramed
	
``` Batch
::	set string=This is my string to work with.
SET find=my string
SET replace=your replacement
CALL SET string=%%string:!find!=!replace!%%
ECHO %string%
```

## OR failure
:link: http://stackoverflow.com/a/334023

``` Batchfile
cls & dir
copy a b && echo Success
copy a b || echo Failure
```

## Setting environment variables from a file
:link: http://stackoverflow.com/a/1077250

Setting environment variables from a file with SET /P

``` Batchfile
:: dump windows version into file
ver |find ".">ver.tmp
:: read into env var
SET /P SVNVERSION=<ver.tmp
```

## Type file content from command line
:link: http://stackoverflow.com/a/534890

``` Batchfile
copy con o.bat
ECHO Hello world
[Ctrl]+[z]
o.bat
```
Will produce:
```
Hello World
```

## ECHO without newline
:link: http://stackoverflow.com/a/374361

``` Batchfile
@set /p any-variable-name=Hello<nul
@echo: world
```
Will produce:
```
Hello World
```

## Nested variables
:link: http://windowsitpro.com/article/articleid/82861/jsi-tip-8971-how-can-i-change-the-case-of-string-to-all-upper-case-or-all-lower-case.html
:link: http://stackoverflow.com/a/3752322

``` Batchfile
SET extension=xxx
SET value=123
set somevalue=value
call set SomeEnvVariable_%extension%=%%%somevalue%%%
set SomeEnvVariable_
```
Will produce:
```
SomeEnvVariable_xxx=123
```

This is used in `_toLowerCase.cmd`
``` Batchfile
    SET _=%~2
    CALL :Lcase _
    @ENDLOCAL&SET %1=%_%
GOTO :EOF

:LCase
    FOR %%c IN (a b c d e f g h i j k l m n o p q r s t u v w x y z ‘ › †) DO CALL SET %1=%%%1:%%c=%%c%%
GOTO :EOF
```

## Finding executable in PATH
:link: http://stackoverflow.com/a/374363

```
for %i in (cmd.exe) do @echo. %~$PATH:i
```
Or
```
where cmd.exe
```

## REM versus ::
:Link: http://ss64.com/nt/rem.html

`::` is much faster to execute than ´REM`. However be carefull not to use `::` inside blocks:

``` Batchfile
(
echo This example will fail
:: some comment Use REM instead
)
```

## Exporting variables outside scope
:link: http://stackoverflow.com/a/1077308

Local variables are still parsed for the line that ENDLOCAL uses. This allows for tricks like:

``` Batchfile
ENDLOCAL & SET MYGLOBAL=%SOMELOCAL% & SET MYOTHERGLOBAL=%SOMEOTHERLOCAL%
```

This is is a useful way to transmit results to the calling context. Specifically, %SOMELOCAL% goes out of scope as soon as ENDLOCAL completes, but by then %SOMELOCAL% is already expanded, so the MYGLOBAL is assigned in the calling context with the local variable.


## Quick edit mode in cmd.exe [Ctrl]+[c] /[Ctrl]+[v]
:link: http://stackoverflow.com/a/253456
```
reg add HKCU\Console /v QuickEdit /t REG_DWORD /d 1 /f
```

## Redirecting

## Forced  to console
Redirecting to `con:` will force out to console

``` Batchfile
@ECHO OFF
(
  ECHO A
  ECHO B>con:
) >nul
```

Will produce
```
B
```
While A is send to nul


## Arrays in Environment

``` Batchfile
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
SET no=0
FOR %%a IN (*.*) DO (
    CALL SET /A no+=1
    SET filelist.!no!=%%a
)
SET filelist
``` 

Will produce a numbered list of files like:
```
filelist.1=o.bat
filelist.2=p.cmd
filelist.3=q.cmd
```


## Remove surrounding quote
http://stackoverflow.com/a/5419228

``` Batchfile
for /f "useback tokens=*" %%a in ('%str%') do set str=%%~a
```
