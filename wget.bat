::'::@ECHO OFF
::'SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::'::**********************************************************************
::'SET $NAME=%~n0
::'SET $DESCRIPTION=A non-interactive network downloader
::'SET $AUTHOR=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
::'SET $SOURCE=%~f0
::'::@(#)NAME
::'::@(-)  The name of the command or function, followed by a one-line description of what it does.
::'::@(#)      %$NAME% -- %$DESCRIPTION%
::'::@(#) 
::'::@(#)SYNOPSIS
::'::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::'::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::'::@(-)  
::'::@(#)      %$NAME% [URL] [Output file]
::'::@(#) 
::'::@(#)OPTIONS
::'::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::'::@(#)  -h      Help page
::'::@(#) 
::'::@ (#) 
::'::@(#)DESCRIPTION
::'::@(-)  A textual description of the functioning of the command or function.
::'::@(#)  Used for downloading files from the internet
::'::@(#)  using a command line batch tool.
::'::@(#) 
::'::@(#)EXAMPLES
::'::@(-)  Some examples of common usage.
::'::@(#)  %$NAME% "http://clicketyclick.dk/development/dos/_/current" "{PCT}TEMP{PCT}\current.txt" 
::'::@(#) 
::'::@(#) 
::'::@ (#)EXIT STATUS
::'::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::'::@ (#)
::'::@ (#)ENVIRONMENT
::'::@(-)  Variables affected
::'::@ (#)
::'::@ (#)
::'::@ (#)FILES, 
::'::@(-)  Files used, required, affected
::'::@ (#)
::'::@ (#)
::'::@ (#)BUGS / KNOWN PROBLEMS
::'::@(-)  If any known
::'::@ (#)
::'::@ (#)
::'::@ (#)REQUIRES
::'::@(-)  Dependencies
::'::@ (#)  
::'::@ (#)
::'::@ (#)SEE ALSO
::'::@(-)  A list of related commands or functions.
::'::@ (#)  
::'::@ (#)  
::'::@ (#)REFERENCE
::'::@(-)  References to inspiration, clips and other documentation
::'::@ (#)  Author:
::'::@ (#)  URL: 
::'::@ (#) 
::'::@(#)
::'::@(#)SOURCE
::'::@(-)  Where to find this source
::'::@(#)  %$Source%
::'::@(#)
::'::@ (#)AUTHOR
::'::@(-)  Who did what
::'::@ (#)  %$AUTHOR%
::'::*** HISTORY **********************************************************
::'::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Description/init
::'::SET $VERSION=2015-02-19&SET $REVISION=16:00:00&SET $COMMENT=Autoupdate / ErikBachmann
::'::SET $VERSION=2015-04-02&SET $REVISION=09:57:00&SET $COMMENT=Update description / ErikBachmann
::'  SET $VERSION=2015-10-08&SET $REVISION=16:00:00&SET $COMMENT=GetOpt: Calling usage and exit on error / ErikBachmann
::'::**********************************************************************
::'::@(#)(c)%$Version:~0,4% %$Author%
::'::**********************************************************************
::'
::'    CALL "%~dp0\_DEBUG"
::'    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
::'
::'::ENDLOCAL
::'
::'"%windir%\System32\cscript.exe" //nologo //e:vbscript "%~f0" %*
::'goto :EOF
'wget.vbs - similar to wget but written in vbscript
'based on a script by Chrissy LeMaire
' https://gist.github.com/udawtr/2053179 
'2015-02-18/ErikBachmann: Added errorCode and status output
'
' Usage
errorCode=0
if WScript.Arguments.Count < 1 then
	MsgBox "Usage: wget.vbs <url> (file)"
	WScript.Quit errorCode+1
end if

' Arguments
URL = WScript.Arguments(0)
if WScript.Arguments.Count > 1 then
	saveTo = WScript.Arguments(1)
else
	parts = split(url,"/")
	saveTo = parts(ubound(parts))
end if

WScript.Echo "- Get ["+URL+"]"
WScript.Echo "- To  ["+saveTo+"]"

' Fetch the file
Set objXMLHTTP = CreateObject("MSXML2.ServerXMLHTTP")
 
objXMLHTTP.open "GET", URL, false
objXMLHTTP.send()

WScript.Echo "- http state ["+Cstr(objXMLHTTP.Status)+"]"

If objXMLHTTP.Status = 200 Then
	WScript.Echo "-- http response = OK"
	Set objADOStream = CreateObject("ADODB.Stream")
	objADOStream.Open
	objADOStream.Type = 1 'adTypeBinary
 
	objADOStream.Write objXMLHTTP.ResponseBody
	objADOStream.Position = 0 'Set the stream position to the start
 
	Set objFSO = Createobject("Scripting.FileSystemObject")
	If objFSO.Fileexists(saveTo) Then 
		WScript.Echo "Removing target ["+saveTo+"]"
		objFSO.DeleteFile saveTo
	end if
	Set objFSO = Nothing
	 
	objADOStream.SaveToFile saveTo
	objADOStream.Close
	Set objADOStream = Nothing
	WScript.Echo "- file retrieved"
Else 
	WScript.Echo "- download failed"
	errorCode = errorCode+2
End if
 
Set objXMLHTTP = Nothing
 
' Done
WScript.Quit errorCode
