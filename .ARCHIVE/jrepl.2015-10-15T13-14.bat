@if (@X)==(@Y) @end /* Harmless hybrid line that begins a JScript comment
@ECHO OFF
::JREPL.BAT version 1.0
::
::  Release History:
::
::    2014-11-14 v1.0: Initial release
::
::************ Documentation ***********
SETLOCAL
SET $NAME=%~n0
SET $DESCRIPTION=a global regular expression search+replace operation on each line of input
SET $AUTHOR=Dave Benham
SET $SOURCE=%~f0
SET $VERSION=2014-11-14&SET $REVISION=22:26:00&SET $COMMENT=initial
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)JREPL  Search  Replace  [/Option  [Value]]...
::@(#)JREPL  /{QUEST}[REGEX{PIPE}REPLACE{PIPE}VERSION]
::@(#)
::@(#)  Performs a global regular expression search and replace operation on
::@(#)  each line of input from stdin and prints the result to stdout.
::@(#)
::@(#)  Each parameter may be optionally enclosed by double quotes. The double
::@(#)  quotes are not considered part of the argument. The quotes are required
::@(#)  if the parameter contains a batch token delimiter like space, tab, comma,
::@(#)  semicolon. The quotes should also be used if the argument contains a
::@(#)  batch special character like {AMP}, {PIPE}, etc. so that the special character
::@(#)  does not need to be escaped with ^.
::@(#)
::@(#)  Search  - By default, this is a case sensitive JScript (ECMA) regular
::@(#)            expression expressed as a string.
::@(#)
::@(#)            JScript regex syntax documentation is available at
::@(#)            http://msdn.microsoft.com/en-us/library/ae5bf541(v=vs.80).aspx
::@(#)
::@(#)  Replace - By default, this is the string to be used as a replacement for
::@(#)            each found search expression. Full support is provided for
::@(#)            substituion patterns available to the JScript replace method.
::@(#)
::@(#)            For example, ${AMP} represents the portion of the source that matched
::@(#)            the entire search pattern, $1 represents the first captured
::@(#)            submatch, $2 the second captured submatch, etc. A $ literal
::@(#)            can be escaped as $$.
::@(#)
::@(#)            An empty replacement string must be represented as "".
::@(#)
::@(#)            Replace substitution pattern syntax is fully documented at
::@(#)            http://msdn.microsoft.com/en-US/library/efy6s3e6(v=vs.80).aspx
::@(#)
::@(#)  Options:  Behavior may be altered by appending one or more options.
::@(#)  The option names are case insensitive, and may appear in any order
::@(#)  after the Replace argument.
::@(#)
::@(#)      /A  - Only print altered lines. Unaltered lines are discarded.
::@(#)            If the /S option is used, then prints the result only if
::@(#)            there was a change anywhere in the string. The /A option
::@(#)            is incompatible with the /M option unless the /S option
::@(#)            is also present.
::@(#)
::@(#)      /B  - The Search must match the beginning of a line.
::@(#)            Mostly used with literal searches.
::@(#)
::@(#)      /E  - The Search must match the end of a line.
::@(#)            Mostly used with literal searches.
::@(#)
::@(#)      /F InFile
::@(#)
::@(#)            Input is read from file InFile instead of stdin.
::@(#)
::@(#)      /I  - Makes the search case-insensitive.
::@(#)
::@(#)      /J  - The Replace argument is a JScript expression.
::@(#)            The following variables contain details about each match:
::@(#)
::@(#)              $0 is the substring that matched the Search
::@(#)              $1 through $n are the captured submatch strings
::@(#)              $off is the offset where the match occurred
::@(#)              $src is the original source string
::@(#)
::@(#)      /JBEG InitCode
::@(#)
::@(#)            JScript inititialization code to be run prior to starting the
::@(#)            search/replace. This is useful for initializing variables used to
::@(#)            accumulate information across matches. The default is an empty
::@(#)            string.
::@(#)
::@(#)      /JEND FinalCode
::@(#)
::@(#)            JScript termination code to be run after the search/replace has
::@(#)            completed. This is useful for writing summarization results.
::@(#)            The default is an empty string.
::@(#)
::@(#)      /JMATCH
::@(#)
::@(#)            Prints each Replace value on a new line, discarding all text
::@(#)            that does not match the Search. The Replace argument is a
::@(#)            JScript expression with access to the same $ variables available
::@(#)            to the /J option.
::@(#)
::@(#)      /L  - The Search is treated as a string literal instead of a
::@(#)            regular expression. Also, all $ found in the Replace string
::@(#)            are treated as $ literals.
::@(#)
::@(#)      /M  - Multi-line mode. The entire contents of stdin is read and
::@(#)            processed in one pass instead of line by line, thus enabling
::@(#)            search for \n. This also enables preservation of the original
::@(#)            line terminators. If the /M option is not present, then every
::@(#)            printed line is terminated with carriage return and line feed.
::@(#)            The /M option is incompatible with the /A option unless the /S
::@(#)            option is also present.
::@(#)
::@(#)            Note: If working with binary data containing NULL bytes,
::@(#)                  then the /M option must be used.
::@(#)
::@(#)      /N MinWidth
::@(#)
::@(#)            Precede each output line with the line number of the source line,
::@(#)            followed by a colon. Line 1 is the first line of the source.
::@(#)
::@(#)            The MinWidth value specifies the minimum number of digits to
::@(#)            display. The default value is 0, meaning do not display the
::@(#)            line number. A value of 1 diplays the line numbers without any
::@(#)            zero padding.
::@(#)
::@(#)            The /N option is ignored if the /M or /S option is used.
::@(#)
::@(#)      /O OutFile
::@(#)
::@(#)            Output is written to file OutFile instead of stdout.
::@(#)
::@(#)            A value of "-" replaces the InFile with the output. The output
::@(#)            is first written to a temporary file with the same name as InFile
::@(#)            with .new appended. Upon completion, the temporary file is moved
::@(#)            to replace the InFile.
::@(#)
::@(#)      /OFF MinWidth
::@(#)
::@(#)            Ignored unless the /JMATCH option is used. Precede each output
::@(#)            line with the offset of the match within the original source
::@(#)            string, followed by a colon. Offset 0 is the first character of
::@(#)            the source string. The offset follows the line number if the /N
::@(#)            option is also used.
::@(#)
::@(#)            The MinWidth value specifies the minimum number of digits to
::@(#)            display. The default value is 0, meaning do not display the
::@(#)            offset. A value of 1 displays the offsets without any zero
::@(#)            padding.
::@(#)
::@(#)      /S VarName
::@(#)
::@(#)            The source is read from environment variable VarName instead
::@(#)            of from stdin. Without the /M option, ^ anchors the beginning
::@(#)            of the string, and $ the end of the string. With the /M option,
::@(#)            ^ anchors the beginning of a line, and $ the end of a line.
::@(#)
::@(#)      /V  - Search, Replace, InitCode, and FinalCode represent the name of
::@(#)            environment variables that contain the respective values.
::@(#)            An undefined variable is treated as an empty string.
::@(#)
::@(#)      /X  - Enables extended substitution pattern syntax with support
::@(#)            for the following escape sequences within the Replace string:
::@(#)
::@(#)            \\     -  Backslash
::@(#)            \b     -  Backspace
::@(#)            \f     -  Formfeed
::@(#)            \n     -  Newline
::@(#)            \q     -  Quote
::@(#)            \r     -  Carriage Return
::@(#)            \t     -  Horizontal Tab
::@(#)            \v     -  Vertical Tab
::@(#)            \xnn   -  ASCII byte code expressed as 2 hex digits
::@(#)            \unnnn -  Unicode character expressed as 4 hex digits
::@(#)
::@(#)            Also enables the \q escape sequence for the Search string.
::@(#)            The other escape sequences are already standard for a regular
::@(#)            expression Search string.
::@(#)
::@(#)            Also modifies the behavior of \xnn in the Search string to work
::@(#)            properly with extended ASCII byte codes (values above 0x7F).
::@(#)
::@(#)            Extended escape sequences are supported even when the /L option
::@(#)            is used. Both Search and Replace support all of the extended
::@(#)            escape sequences if both the /X and /L opions are combined.
::@(#)
::@(#)            Extended escape sequences are not applied to JScript code when
::@(#)            using the /J, /JMATCH, /JBEG, or /JEND options. Use the decode()
::@(#)            method if extended escape sequences are needed within the code.
::@(#)
::@(#)  There are global JScript variables/objects/methods that may be used in
::@(#)  JScript code when using the /J, /JBEG, /JEND, or /JMATCH options:
::@(#)
::@(#)      ln     - Within Replace code = line number where the match occurred.
::@(#)               Within /JEND code = total number of lines read.
::@(#)               This value is always 0 if the /M or /S otion is used.
::@(#)
::@(#)      env('varName')
::@(#)
::@(#)               Access to environment variable named varName.
::@(#)
::@(#)      decode(string)
::@(#)
::@(#)               Decodes extended escape sequences within a string as defined
::@(#)               by the /X option, and returns the result. All backslashes must
::@(#)               be escaped an extra time to use this function in your code.
::@(#)
::@(#)               Examples:
::@(#)                   quote literal:       decode('\\q')
::@(#)                   extended ASCII(128): decode('\\x80')
::@(#)                   backslash literal:   decode('\\\\')
::@(#)
::@(#)               This function is only needed if you use the \q sequence
::@(#)               or \xnn for an extended ASCII code (values above 0x7F).
::@(#)
::@(#)      input  - The TextStream object from which input is read.
::@(#)               This may be stdin or a file.
::@(#)
::@(#)      output - The TextStream object to which the output is written.
::@(#)               This may be stdout or a file.
::@(#)
::@(#)      stdin  - Equivalent to WScript.StdIn
::@(#)
::@(#)      stdout - Equivalent to WScript.StdOut
::@(#)
::@(#)      stderr - Equivalent to WScript.StdErr
::@(#)
::@(#)  Help is available by supplying a single argument beginning with /{QUEST}:
::@(#)
::@(#)      /{QUEST}        - Writes this help documentation to stdout.
::@(#)
::@(#)      /{QUEST}REGEX   - Opens up Microsoft's JScript regular expression
::@(#)                  documentation within your browser.
::@(#)
::@(#)      /{QUEST}REPLACE - Opens up Microsoft's JScript REPLACE documentation
::@(#)                  within your browser.
::@(#)
::@(#)      /{QUEST}VERSION - Writes the JREPL version number to stdout.
::@(#)
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@(#)  Return Codes:
::@(#)
::@(#)      0 = At least one change was made and /JMATCH not used
::@(#)          or at least one match returned and /JMATCH was used
::@(#)          or /{QUEST} was used
::@(#)
::@(#)      1 = No change was made and /JMATCH not used
::@(#)          or no match returned and /JMATCH was used
::@(#)
::@(#)      2 = Invalid call syntax or incompatible options
::@(#)
::@(#)      3 = JScript runtime error
::@(#)
::@ (#)AUTHOR
::@(-)  Who did what
::@(#)  JREPL.BAT was written by Dave Benham, and originally posted at
::@(#)  http://www.dostips.com/forum/viewtopic.php?f=3{AMP}t=6044
::@(#)

::************ Batch portion ***********
@echo off
setlocal disableDelayedExpansion
 
if .%2 equ . (
  if "%~1" equ "/?" (
    for /f "tokens=* delims=:" %%A in ('findstr "^:::" "%~f0"') do @echo(%%A
    exit /b 0
  ) else if /i "%~1" equ "/?regex" (
    explorer "http://msdn.microsoft.com/en-us/library/ae5bf541(v=vs.80).aspx"
    exit /b 0
  ) else if /i "%~1" equ "/?replace" (
    explorer "http://msdn.microsoft.com/en-US/library/efy6s3e6(v=vs.80).aspx"
    exit /b 0
  ) else if /i "%~1" equ "/?version" (
    for /f "tokens=* delims=:" %%A in ('findstr "^::JREPL\.BAT" "%~f0"') do @echo(%%A
    exit /b 0
  ) else (
    call :err "Insufficient arguments"
    exit /b 2
  )
)
 
:: Define options
set "options= /A: /B: /E: /F:"" /I: /J: /JBEG:"" /JEND:"" /JMATCH: /L: /M: /N:0 /O:"" /OFF:0 /S:"" /V: /X: "
 
:: Set default option values
for %%O in (%options%) do for /f "tokens=1,* delims=:" %%A in ("%%O") do set "%%A=%%~B"
 
:: Get options
:loop
if not "%~3"=="" (
  setlocal enableDelayedExpansion
  set "test=!options:*%~3:=! "
  if "!test!"=="!options! " (
      endlocal
      call :err "Invalid option %~3"
      exit /b 2
  ) else if "!test:~0,1!"==" " (
      endlocal
      set "%~3=1"
  ) else (
      endlocal
      set "%~3=%~4"
      shift /3
  )
  shift /3
  goto :loop
)

:: Validate options
if defined /M if defined /A if not defined /S (
  call :err "Incompatible options"
  exit /b 2
)
if "%/O%" equ "-" if not defined /F (
  call :err "Output = - but Input file not specified"
  exit /b 2
)
if defined /F if defined /O for %%A in ("%/F%") do for %%B in ("%/O%") do if %%~fA equ %%~fB (
  call :err "Output file cannot match Input file"
  exit /b 2
)

:: Transform options
if defined /JMATCH (
  set "/J=1"
  set "/A=1"
)
if "%/M%%/S%" neq "" set "/N=0"

:: Execute
cscript //E:JScript //nologo "%~f0" %1 %2
exit /b %errorlevel%

:err
>&2 (
  echo ERROR: %~1.
  echo Use JREPL /? to get help.
)
exit /b

************* JScript portion **********/
try {
  var env=WScript.CreateObject("WScript.Shell").Environment("Process"),
      ln=0,
      stdin=WScript.StdIn,
      stdout=WScript.Stdout,
      stderr=WScript.Stderr,
      output,
      input,
      _g=new Object();
  _g.ForReading=1;
  _g.ForWriting=2;
  _g.fso = new ActiveXObject("Scripting.FileSystemObject");
  _g.inFile=env('/F');
  _g.outFile=env('/O');
  if (_g.inFile=='') {
    input=stdin;
  } else {
    input=_g.fso.OpenTextFile(_g.inFile,_g.ForReading);
  }
  if (_g.outFile=='') {
    output=stdout
  } else if (_g.outFile=='-') {
    output=_g.fso.OpenTextFile(_g.inFile+'.new',_g.ForWriting,true);
  } else {
    output=_g.fso.OpenTextFile(_g.outFile,_g.ForWriting,true);
  }
  eval(env('/V')==''?env('/JBEG'):env(env('/JBEG')));

  _g.fmtNum=function( val, pad ) {
    if (pad.length==0) return '';
    var rtn=val.toString();
    if (rtn.length<pad.length) rtn=(pad+rtn).slice(-pad.length);
    return rtn+':';
  }

  _g.writeMatch=function(str,off,lnPad,offPad) {
    if (str!='') {
      _g.rtn=0;
      output.WriteLine(_g.fmtNum(ln,lnPad)+_g.fmtNum(off,offPad)+str);
    }
  }

  _g.defineReplFunc=function() {
    eval(ln);
  }

  _g.main=function() {
    _g.rtn=1;
    var args=WScript.Arguments;
    var search=args.Item(0);
    var replace=args.Item(1);
    var options="g";
    var multi=env('/M')!='';
    var literal=env('/L')!='';
    var alterations=env('/A')!='';
    var srcVar=env('/S');
    var jexpr=env('/J')!='';
    if (multi) options+='m';
    if (env('/V')!='') {
      search=env(search);
      replace=env(replace);
    }
    if (env('/I')!='') options+='i';
    if (env('/X')!='') {
      if (!jexpr) replace=decode(replace);
      search=decode(search,literal);
    }
    if (literal) {
      search=search.replace(/([.^$*+?()[{\\|])/g,"\\$1");
      if (!jexpr) replace=replace.replace(/\$/g,"$$$$");
    }
    if (env('/B')!='') search="^"+search;
    if (env('/E')!='') search=search+"$";
    var search=new RegExp(search,options);
    var lnWidth=parseInt(env('/N'),10),
        offWidth=parseInt(env('/OFF'),10),
        lnPad=lnWidth>0?Array(lnWidth+1).join('0'):'',
        offPad=offWidth>0?Array(offWidth+1).join('0'):'';
    if (jexpr) {
      var cnt;
      ln='x';
      var test=new RegExp('.|'+search,options);
      ln.replace(test,function(){cnt=arguments.length-2; return '';});
      ln='_g.replFunc=function($0';
      for (var i=1; i<cnt; i++) ln+=',$'+i;
      ln+=',$off,$src)'+(env('/JMATCH')==''?'{return(eval(_g.replace));}':'{_g.writeMatch(eval(_g.replace),$off,\''+lnPad+'\',\''+offPad+'\');return $0;}');
      _g.defineReplFunc();
      ln=0;
    }

    var str1, str2;
    var repl=jexpr?_g.replFunc:replace;
    _g.replace=replace;
    if (srcVar!='') {
      str1=env(srcVar);
      str2=str1.replace(search,repl);
      if (!alterations || str1!=str2) if (multi) {
        output.Write(_g.fmtNum(ln,lnPad)+str2);
      } else {
        output.WriteLine(_g.fmtNum(ln,lnPad)+str2);
      }
      if (str1!=str2) _g.rtn=0;
    } else if (multi){
      var buf=1024;
      str1="";
      while (!input.AtEndOfStream) {
        str1+=input.Read(buf);
        buf*=2
      }
      str2=str1.replace(search,repl);
      if (!alterations) output.Write(_g.fmtNum(ln,lnPad)+str2);
      if (str1!=str2) _g.rtn=0;
    } else {
      while (!input.AtEndOfStream) {
        str1=input.ReadLine();
        ln+=1;
        str2=str1.replace(search,repl);
        if (!alterations || str1!=str2) output.WriteLine(_g.fmtNum(ln,lnPad)+str2);
        if (str1!=str2) _g.rtn=0;
      }
    }
  }

  _g.main();

  eval(env('/V')==''?env('/JEND'):env(env('/JEND')));
  if (_g.inFile!='') input.close();
  if (_g.outFile!='') output.close();
  if (_g.outFile=='-') {
    _g.fso.GetFile(_g.inFile).Delete();
    _g.fso.GetFile(_g.inFile+'.new').Move(_g.inFile);
  }
  WScript.Quit(_g.rtn);
} catch(e) {
  WScript.Stderr.WriteLine("JScript runtime error: "+e.message);
  WScript.Quit(3);
}

function decode(str, searchSwitch) {
  str=str.replace(
    /\\(\\|b|f|n|q|r|t|v|x80|x82|x83|x84|x85|x86|x87|x88|x89|x8[aA]|x8[bB]|x8[cC]|x8[eE]|x91|x92|x93|x94|x95|x96|x97|x98|x99|x9[aA]|x9[bB]|x9[cC]|x9[dD]|x9[eE]|x9[fF]|x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4})/g,
    function($0,$1) {
      switch ($1.toLowerCase()) {
        case 'q':   return '"';
        case 'x80': return '\\u20AC';
        case 'x82': return '\\u201A';
        case 'x83': return '\\u0192';
        case 'x84': return '\\u201E';
        case 'x85': return '\\u2026';
        case 'x86': return '\\u2020';
        case 'x87': return '\\u2021';
        case 'x88': return '\\u02C6';
        case 'x89': return '\\u2030';
        case 'x8a': return '\\u0160';
        case 'x8b': return '\\u2039';
        case 'x8c': return '\\u0152';
        case 'x8e': return '\\u017D';
        case 'x91': return '\\u2018';
        case 'x92': return '\\u2019';
        case 'x93': return '\\u201C';
        case 'x94': return '\\u201D';
        case 'x95': return '\\u2022';
        case 'x96': return '\\u2013';
        case 'x97': return '\\u2014';
        case 'x98': return '\\u02DC';
        case 'x99': return '\\u2122';
        case 'x9a': return '\\u0161';
        case 'x9b': return '\\u203A';
        case 'x9c': return '\\u0153';
        case 'x9d': return '\\u009D';
        case 'x9e': return '\\u017E';
        case 'x9f': return '\\u0178';
        case '\\':  return searchSwitch===false ? $0 : '\\';
        case 'b':   return searchSwitch===false ? $0 : '\b';
        case 'f':   return searchSwitch===false ? $0 : '\f';
        case 'n':   return searchSwitch===false ? $0 : '\n';
        case 'r':   return searchSwitch===false ? $0 : '\r';
        case 't':   return searchSwitch===false ? $0 : '\t';
        case 'v':   return searchSwitch===false ? $0 : '\v';
        default:    return searchSwitch===false ? $0 : String.fromCharCode(parseInt("0x"+$1.substr(1)));
      }
    }
  );
  return str;
}
