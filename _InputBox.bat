::'@ECHO OFF
::'SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::'::**********************************************************************
::'SET $NAME=%~n0
::'SET $DESCRIPTION=Input routine for batch using VBScript to provide input box
::'SET $AUTHOR=Stephen Knight, October 2009, http://www.dragon-it.co.uk/
::'SET $SOURCE=%~f0
::'::@(#)NAME
::'::@(-)  The name of the command or function, followed by a one-line description of what it does.
::'::@(#)      %$NAME% -- %$DESCRIPTION%
::'::@(#) 
::'::@(#)SYNOPSIS
::'::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::'::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::'::@(-)  
::'::@(#)  %$Name% [Window title] [Message] [Default value]
::'::@(#) 
::'::@(#)OPTIONS
::'::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::'::@(#)  -h      Help page
::'::@(#) 
::'::@(#)DESCRIPTION
::'::@(-)  A textual description of the functioning of the command or function.
::'::@(#)  Prompting user for simple text input using input box
::'::@(#) 
::'::@(#)EXAMPLES
::'::@(-)  Some examples of common usage.
::'::@(#)      SET _INPUT=
::'::@(#)      SET _TITLE=window title
::'::@(#)      SET _MSG=Hello world.{CrLf}Please enter something for me:
::'::@(#)      SET _CMD=CALL %$NAME% "{PCT}_TITLE{PCT}" "{PCT}_MSG{PCT}" "default"
::'::@(#)      FOR /F "tokens=* delims=" {PCT}{PCT}a IN ('CALL {PCT}_CMD{PCT}') DO SET _VAR={PCT}{PCT}a
::'::@(#)      ECHO You entered [{PCT}_VAR{PCT}]
::'::@(#)
::'::@ (#)EXIT STATUS
::'::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::'::@(#)     The following exit values are returned:
::'::@(#)     0   Any matches were found.
::'::@(#)     1   No matches found.
::'::@(#) 
::'::@(#)SEE ALSO
::'::@(#)  _MsgBox.bat
::'::@(#)
::'::@(#)REFERENCE
::'::@(#) Stephen Knight, October 2009, http://www.dragon-it.co.uk/
::'::@(#) URL: http://scripts.dragon-it.co.uk/scripts.nsf/docs/batch-gui-inputbox!OpenDocument
::'::@(#) 
::'::@(#)SOURCE
::'::@(#)  %$Source%
::'::@(#) 
::'::----------------------------------------------------------------------
::':: History
::'::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Init / Description [xx.xxx]
::'::SET $VERSION=2010-10-13&SET $REVISION=15:36:00&SET $COMMENT=ErikBachmann / Initial: FindInPath [01.000]
::'::SET $VERSION=2014-01-11&SET $REVISION=10:59:00&SET $COMMENT=Update doc + example/ErikBachmann [01.002]
::'  SET $VERSION=2015-02-18&SET $REVISION=19:32:00&SET $Comment=cmdized/ErikBachmann
::'::**********************************************************************
::'::@(#)¤COPY¤%$VERSION:~0,4% %$Author%
::'::**********************************************************************
::'CALL "%~dp0_debug"
::'CALL "%~dp0_GetOpt" %*&IF ERRORLEVEL 1 EXIT /B 1
::'
::'"%windir%\System32\cscript.exe" //nologo //e:vbscript "%~f0" %*
::'goto :EOF
Set args = Wscript.Arguments
x=InputBox(Replace(WScript.Arguments.Item(1),"{CrLf}", vbCrLf),WScript.Arguments.Item(0),WScript.Arguments.Item(2))
wscript.echo x
' http://www.vistax64.com/vb-script/192365-return-value-vbscript-cmd-file.html
'
'*** End of File ******************************************************