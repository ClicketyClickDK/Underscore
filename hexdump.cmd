@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Dump a file in hex format
SET $AUTHOR=Dave Benham [dbenham]
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)      %$NAME% [/option]... file
::@(#) 
::@ (#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)    The format of the dump can be modified by the following case insensitive
::@(#)    options:
::@(#)  
::@(#)      /BblockSize   The blockSize after the /B specifies the number of bytes
::@(#)                    to print in each block. If the blockSize is {LT}= 0 then /C,
::@(#)                    /D, /E, /A and /O options are ignored and the bytes are
::@(#)                    output in a continuous stream without any delimiters or
::@(#)                    linebreaks.
::@(#)                    The default blockSize is 1.
::@(#)  
::@(#)      /CblockCount  The blockCount after the /C specifies the number of blocks
::@(#)                    to include on each line of output.
::@(#)                    The default blockCount is 16.
::@(#)  
::@(#)      /DbyteDelim   The byteDelim after the /D specifies the delimiter string
::@(#)                    to use between bytes within a block.
::@(#)                    The default byteDelim is undefined (no delimiter)
::@(#)  
::@(#)      /EblockDelim  The blockDelim after the /E specifies the delimiter string
::@(#)                    to use between blocks within a line.
::@(#)                    The default blockDelim is '/E "' ^(a single space^)
::@(#)  
::@(#)      /SstartOffset The startOffset after the /S specifies the number of bytes
::@(#)                    to skip before displaying bytes.
::@(#)                    The default startOffset is 0.
::@(#)  
::@(#)      /Nlength      The length after the /N specifies the total number of
::@(#)                    bytes to display after the startOffset. The default is to
::@(#)                    display up until the end of the file.
::@(#)  
::@(#)      /A            Append the ASCII representation of the bytes to the end
::@(#)                    of each line. Non-printable and extended ASCII characters
::@(#)                    are displayed as periods.
::@(#)  
::@(#)      /O            Prefix each line with the starting offset of the line in
::@(#)                    hexadecimal notation.
::@(#)  
::@(#)      /H            Display hexDump help
::@(#)  
::@(#)    Each option must be entered as a separate argument. Numeric components to
::@(#)    options may be specified using any numeric expression supported by SET /A.
::@(#)    The option defaults may be modified by presetting a hexDumpDefaults
::@(#)    variable.
::@(#)  
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)    Displays the content of a binary file using a pair of hexadecimal digits
::@(#)    for each byte. By default the ouput displays 16 bytes per line, with the
::@(#)    bytes (hexadecimal pairs) delimited by a space.
::@(#) 
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      
::@(#)      echo Hello>out.txt
::@(#)      echo world>>out.txt
::@(#)      hexdump out.txt
::@(#)      00000000: 48 65 6C 6C 6F 0D 0A 77 6F 72 6C 64 0D 0A        Hello..world..
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
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@(#)   Author: Dave Benham [dbenham]
::@(#)   URL: http://www.dostips.com/forum/viewtopic.php?t=1786
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
::SET $VERSION=2015-02-19&SET $REVISION=16:00:00&SET $COMMENT=Autoupdate / ErikBachmann
::SET $VERSION=2015-03-30&SET $REVISION=10:40:00&SET $COMMENT=Example / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

:hexDump [/option]... file        -- dump a file in hex format
:: author: Dave Benham [dbenham]
:: URL: http://www.dostips.com/forum/viewtopic.php?t=1786
::
::  Displays the content of a binary file using a pair of hexadecimal digits
::  for each byte. By default the ouput displays 16 bytes per line, with the
::  bytes (hexadecimal pairs) delimited by a space.
::
::  The format of the dump can be modified by the following case insensitive
::  options:
::
::    /BblockSize   The blockSize after the /B specifies the number of bytes
::                  to print in each block. If the blockSize is <= 0 then /C,
::                  /D, /E, /A and /O options are ignored and the bytes are
::                  output in a continuous stream without any delimiters or
::                  linebreaks.
::                  The default blockSize is 1.
::
::    /CblockCount  The blockCount after the /C specifies the number of blocks
::                  to include on each line of output.
::                  The default blockCount is 16.
::
::    /DbyteDelim   The byteDelim after the /D specifies the delimiter string
::                  to use between bytes within a block.
::                  The default byteDelim is undefined (no delimiter)
::
::    /EblockDelim  The blockDelim after the /E specifies the delimiter string
::                  to use between blocks within a line.
::                  The default blockDelim is "/E " (a single space)
::
::    /SstartOffset The startOffset after the /S specifies the number of bytes
::                  to skip before displaying bytes.
::                  The default startOffset is 0.
::
::    /Nlength      The length after the /N specifies the total number of
::                  bytes to display after the startOffset. The default is to
::                  display up until the end of the file.
::
::    /A            Append the ASCII representation of the bytes to the end
::                  of each line. Non-printable and extended ASCII characters
::                  are displayed as periods.
::
::    /O            Prefix each line with the starting offset of the line in
::                  hexadecimal notation.
::
::    /H            Display hexDump help
::
::  Each option must be entered as a separate argument. Numeric components to
::  options may be specified using any numeric expression supported by SET /A.
::  The option defaults may be modified by presetting a hexDumpDefaults
::  variable.
::
  setlocal enableDelayedExpansion
  set /a blockSize=1, blockCount=16, startOffset=0
  set ascii=  
  set offset=TRUE
  set len=
  set opts=
  set byteDelim=
  set "blockDelim= "
  set endDefault=
  for %%a in (!hexDumpDefaults! // %*) do (
    if not defined opts (
      set "arg=%%~a"
      if "!arg:~0,1!"=="/" (
        if defined endDefault shift /1
        set "opt=!arg:~1,1!"
        if /i "!opt!"=="B" set /a blockSize=!arg:~2!
        if /i "!opt!"=="C" set /a blockCount=!arg:~2!
        if /i "!opt!"=="D" set "byteDelim=!arg:~2!"
        if /i "!opt!"=="E" set "blockDelim=!arg:~2!"
        if /i "!opt!"=="S" set /a startOffset=!arg:~2!
        if /i "!opt!"=="N" set /a len=!arg:~2!
        if /i "!opt!"=="A" set "ascii=  "
        if /i "!opt!"=="O" set offset=TRUE
        if /i "!opt!"=="H" set "opts=TRUE" & goto :hexDump.help
        if /i "!opt!"=="/" set endDefault=true
      ) else set opts=TRUE
    )
  )
  if "%~1"=="" goto :hexDump.help
  if not exist %1 (
    echo ERROR: File not found >&2
    exit /b 1
  )
  set fileSize=%~z1
  if defined len (
    set /a "endOffset = startOffset + len"
    if !endOffset! gtr %fileSize% set endOffset=%fileSize%
  ) else set endOffset=%fileSize%
  if defined offset set offset=%startOffset%
  if %blockSize% lss 1 (
    set /a "blockSize=0, blockCount=2000"
    set "ascii="
    set "offset="
    set "byteDelim="
    rem set "blockDelim="
  )
  set dummy="!temp!\hexDumpDummy%random%.txt"
  <nul >%dummy% set /p ".=A"
  set dummySize=1
  for /l %%n in (1,1,32) do (if !dummySize! lss %endOffset% set /a "dummySize*=2" & type !dummy! >>!dummy!)
  set /a "pos=0, cnt=0, skipStart=startOffset+1, lnBytes=blockSize*blockCount"
  set "off="
  set "hex="
  set "txt=%ascii%"
  set map= ^^^!^"#$%%^&'^(^)*+,-./0123456789:;^<=^>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^^^^_`abcdefghijklmnopqrstuvwxyz{^|}~
  set hexMap=0123456789ABCDEF
  ::DEFINE INTERNAL MACRO USED SOLELY BY THIS FUNCTION
  setlocal disableDelayedExpansion

  set LF=^


  ::Above 2 blank lines are required - do not remove

  set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"

  set callMacro=for /f %%a in

  set addChar= do (%\n%
    set "byte=%%~a"%\n%
    if "!byte!"=="2space" set "byte=  "%\n%
    if defined ascii if "!byte!" neq "  " (%\n%
      set /a "d=0x!byte!-32"%\n%
      if !d! lss 0 set d=14%\n%
      if !d! gtr 94 set d=14%\n%
      for %%d in (!d!) do set txt=!txt!!map:~%%d,1!%\n%
    )%\n%
    if %blockSize% gtr 0 set /a pos+=1%\n%
    if !pos!==%blockSize% set /a "pos=0, cnt+=1"%\n%
    if not !cnt!==!blockCount! (%\n%
      if !pos!==0 (set "hex=!hex!!byte!!blockDelim!") else set "hex=!hex!!byte!!byteDelim!"%\n%
    ) else (%\n%
      set "hex=!hex!!byte!"%\n%
      set cnt=0%\n%
      if defined offset (%\n%
        set off=%\n%
        set dec=!offset!%\n%
        for /l %%n in (1,1,8) do (%\n%
          set /a "d=dec&15,dec>>=4"%\n%
          for %%d in (!d!) do set "off=!hexMap:~%%d,1!!off!"%\n%
        )%\n%
        set "off=!off!: "%\n%
        set /a offset+=lnBytes%\n%
      )%\n%
      set "ln=!off!!hex!!txt!"%\n%
      if %blockSize%==0 (^<nul set /p ".=!ln!") else echo !ln!%\n%
      set hex=%\n%
      set "txt=%ascii%"%\n%
    )%\n%
  )

   ::END OF MACRO DEFS
  setlocal enableDelayedExpansion
  for /f "eol=F usebackq tokens=1,2 skip=1 delims=:[] " %%A in (`fc /b "%~dpf1" %dummy%`) do (
    set /a skipEnd=0x%%A && (
      if !skipEnd! geq %startOffset% if !skipStart! leq %endOffset% (
        for /l %%n in (!skipStart!,1,!skipEnd!) do %callMacro% ("41") %addChar%
        %callMacro% ("%%B") %addChar%
        set /a skipStart=skipEnd+2
      )
    )
  )
  for /l %%n in (%skipStart%,1,%endOffset%) do %callMacro% ("41") %addChar%
  if %blockSize%==0 if defined hex (<nul set /p ".=!hex!") & set hex=
  for /l %%n in (1,1,%lnBytes%) do if defined hex %callMacro% ("2space") %addChar%
  del %dummy%
  exit /b
  ::-------------------------------------------------------
  :hexDump.help
    setlocal disableDelayedExpansion
    echo:
    set file="%~f0"
    set beg=
    for /f "tokens=1,* delims=:" %%a in ('findstr /n /r /i /c:"^:hexDump " %file%') do (
      if not defined beg set beg=%%a
    )
    set end=
    for /f "tokens=1 delims=:" %%a in ('findstr /n /r /c:"^[^:]" %file%') do (
      if not defined end if %beg% LSS %%a set end=%%a
    )
    for /f "tokens=1,* delims=[]:" %%a in ('findstr /n /r /c:"^ *:[^:]" /c:"^::[^:]" /c:"^ *::$" %file%') do (
      if %beg% LEQ %%a if %%a LEQ %end% echo: %%b
    )
exit /b 0