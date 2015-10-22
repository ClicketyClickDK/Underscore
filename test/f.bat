::@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
cls
CALL _DEBUG
SET _fileName=%~1

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
SET $
ECHO ---
SET $NAME=%_fileName:~0,-4%
SET $SOURCE=%~f1
::"%windir%\System32\cscript.exe" //nologo //e:vbscript "%~f0" %_FileName%" "@\(#\)" %*
::"%windir%\System32\cscript.exe" //nologo  f.vbs "%_FileName%" "@\(#\)"
cscript f.vbs "%_FileName%" "@\(#\)"


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

'**********************************************************************
Const NAME          = "zip.vbs"
Const DESCRIPTION   = "Zipping files or directories"
Const AUTHOR        = "Erik Bachmann"
'*** History **********************************************************
Const VERSION="2014-01-31":Const REVISION="13:16:00"
::Const COMMENT="Init"
'**********************************************************************
' http://superuser.com/questions/110991/can-you-zip-a-file-from-the-command-prompt-using-only-windows-built-in-capabili
' cscript zip.vbs target.zip sourceFile1 sourceDir2 ... sourceObjN
' Return
'   0   OK
'   4   Max runtime exceeded


WScript.Echo Wscript.ScriptName & " v." & VERSION & " - " & DESCRIPTION
WScript.Echo " rev." & REVISION & " by " & AUTHOR
WScript.Echo

Const ForReading = 1

Set objRegEx = CreateObject("VBScript.RegExp")
input=WScript.Arguments.Item(0) 'File to read
'objRegEx.Pattern = "@\(#\)"
objRegEx.Pattern=WScript.Arguments.Item(1)
If IsEmpty(objRegEx.Pattern) Then
	objRegEx.Pattern = "@\(#\)"
End If
'objRegEx.Pattern=WScript.Arguments.Item(1)
'Pattern=WScript.Arguments.Item(1)
Pattern=Replace(objRegEx.Pattern, "\", "")
'Wscript.Echo Pattern
'Wscript.Echo 
'Wscript.Echo objRegEx.Pattern

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile(input, ForReading)

Do Until objFile.AtEndOfStream
    strSearchString = objFile.ReadLine
    Set colMatches = objRegEx.Execute(strSearchString)  
    If colMatches.Count > 0 Then
        For Each strMatch in colMatches   
            ' Original string
	    'Wscript.Echo strSearchString
	    strText = Right(strSearchString, len(strSearchString) - (InStr(strSearchString,"@(#)")+len(Pattern) -1))
	    ' Expand variables
	    Wscript.Echo ExpVar(strText)
	    'Wscript.Echo 
        Next
    End If
Loop

'https://msdn.microsoft.com/en-us/library/dy8116cf%28v=vs.84%29.aspx
set WshShell = WScript.CreateObject("WScript.Shell")
WScript.Echo "WinDir is " & WshShell.ExpandEnvironmentStrings("%WinDir%")


'strComputer = "." 
'Set objWMIService = GetObject("winmgmts:" _ 
'    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2") 
 
'Set colItems = objWMIService.ExecQuery("Select * from Win32_Environment") 
 
'For Each objItem in colItems 
'    Wscript.Echo "Description: " & objItem.Description 
'    Wscript.Echo "Name: " & objItem.Name 
'    Wscript.Echo "System Variable: " & objItem.SystemVariable 
'    Wscript.Echo "User Name: " & objItem.UserName 
'    Wscript.Echo "Variable Value: " & objItem.VariableValue 
'Next 
Dim objWSH
Dim objUserVariables
Dim objSystemVariables

Set objWSH =  CreateObject("WScript.Shell")
'This actually returns all the User Variables, and you either loop through all, or simply print what you want
Set objUserVariables = objWSH.Environment("USER")
Wscript.Echo objUserVariables("$VERSION")
'For Each objItem in objUserVariables
'Wscript.Echo "Variable Value: " & objItem.VariableValue 
'next




Set objShell = CreateObject("WScript.Shell")
Set objEnv = objShell.Environment("Process")
wscript.echo "[" & objEnv("$DESCRIPTION") & "]"



'http://blogs.technet.com/b/heyscriptingguy/archive/2007/03/29/how-can-i-search-a-text-file-for-strings-meeting-a-specified-pattern.aspx
'https://msdn.microsoft.com/en-us/library/bx9ceb2w%28v=vs.84%29.aspx

Function ExpVar(strText)

'Set objSortedList = CreateObject( "System.Collections.Sortedlist" )
'objSortedList.Add "$NAME", "Navn"
'objSortedList.Add "$DESCRIPTION", "Beskrivelse"
'objSortedList.Add "$SOURCE", "$SOURCE"
'objSortedList.Add "$Author", "Forfatter"
'objSortedList.Add "$VERSION", ""

	Set objShell = CreateObject("WScript.Shell")
	Set objEnv = objShell.Environment("Process")
	'wscript.echo "[" & objEnv("$DESCRIPTION") & "]"
	strText = Replace(strText, "{EXCL}", "!")
	strText = Replace(strText, "{PCT}", "%")
	strText = Replace(strText, "{PIPE}", "|")
	strText = Replace(strText, "{CARET}", "^")
	strText = Replace(strText, "{AMP}", "&")

	strText = Replace(strText, "%$Name%", objEnv("$NAME"))
	strText = Replace(strText, "%$Description%", objEnv("$Description"))
	strText = Replace(strText, "%$Source%", objEnv("$Source"))
	strText = Replace(strText, "%$Author%", objEnv("$Author"))
	strText = Replace(strText, "%$Revision:~0,4%", objEnv("$Revision"))
	
'For i = 0 To objSortedList.Count - 1
'	strText = Replace(strText, objSortedList.GetKey(i) , objEnv(objSortedList.GetByIndex(i)))
'Next

	ExpVar = strText
End Function

