Const ForReading = 1

Set objRegEx = CreateObject("VBScript.RegExp")
input=WScript.Arguments.Item(0) 'File to read
objRegEx.Pattern=WScript.Arguments.Item(1)

If 2 < WScript.Arguments.Count Then  
   style=WScript.Arguments.Item(2)
Else  
   style=""
End If

Wscript.Echo style & WScript.Arguments.Count & WScript.Arguments.Item(2)

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
'set WshShell = WScript.CreateObject("WScript.Shell")
'WScript.Echo "WinDir is " & WshShell.ExpandEnvironmentStrings("%WinDir%")


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




'Set objShell = CreateObject("WScript.Shell")
'Set objEnv = objShell.Environment("Process")
'wscript.echo "[" & objEnv("$DESCRIPTION") & "]"



'http://blogs.technet.com/b/heyscriptingguy/archive/2007/03/29/how-can-i-search-a-text-file-for-strings-meeting-a-specified-pattern.aspx
'https://msdn.microsoft.com/en-us/library/bx9ceb2w%28v=vs.84%29.aspx

Function ExpVar(strText)

Set objSortedList = CreateObject( "System.Collections.Sortedlist" )
objSortedList.Add "$NAME", "Navn"
objSortedList.Add "$DESCRIPTION", "Beskrivelse"
objSortedList.Add "$SOURCE", "$SOURCE"
'objSortedList.Add "$Author", "Forfatter"
objSortedList.Add "$VERSION", ""

	Set objShell = CreateObject("WScript.Shell")
	Set objEnv = objShell.Environment("Process")
	strText = Replace(strText, "%$Name%", objEnv("$NAME"))
	strText = Replace(strText, "%$Description%", objEnv("$Description"))
	strText = Replace(strText, "%$Source%", objEnv("$Source"))
	strText = Replace(strText, "%$Author%", objEnv("$Author"))
	strText = Replace(strText, "%$Revision:~0,4%", objEnv("$Revision"))
	
	If IsEmpty(style) Then
		strText = ExpDosVar(strText)
	Else
		strText = ExpHtmlVar(strText)
	End If
	ExpVar = strText
End Function

function ExpDosVar(strText)
	strText = Replace(strText, "{EXCL}", "!", 1, -1, 1)
	strText = Replace(strText, "{PCT}", "%", 1, -1, 1)
	strText = Replace(strText, "{PIPE}", "|", 1, -1, 1)
	strText = Replace(strText, "{CARET}", "^", 1, -1, 1)
	strText = Replace(strText, "{AMP}", "&", 1, -1, 1)
	strText = Replace(strText, "{GT}", ">", 1, -1, 1)
	strText = Replace(strText, "{LT}", ">", 1, -1, 1)
	strText = Replace(strText, "{COPY}", "(c)", 1, -1, 1)
	strText = Replace(strText, "{lCurlPar}", "{", 1, -1, 1)
	strText = Replace(strText, "{rCurlPar}", "}", 1, -1, 1)

	ExpDosVar = strText
End Function

function ExpHtmlVar(strText)
	prefix = Mid(strText, 1, 1)
	If NOT " " = prefix Then
		strText="<h3>" & strText & "</h3>"
	Else
		strText="<tt>" & strText & "</tt><BR>"
	End If

'Wscript.Echo "[" & Mid(strText, 1, 1) & "]"
	strText = Replace(strText, "{EXCL}", "!", 1, -1, 1)
	strText = Replace(strText, "{PCT}", "%", 1, -1, 1)
	strText = Replace(strText, "{PIPE}", "|", 1, -1, 1)
	strText = Replace(strText, "{CARET}", "^", 1, -1, 1)
	strText = Replace(strText, "{AMP}", "&", 1, -1, 1)
	strText = Replace(strText, "{GT}", "&gt;", 1, -1, 1)
	strText = Replace(strText, "{LT}", "&lt;", 1, -1, 1)
	strText = Replace(strText, "{COPY}", "&copy;", 1, -1, 1)
	strText = Replace(strText, "{lCurlPar}", "{", 1, -1, 1)
	strText = Replace(strText, "{rCurlPar}", "}", 1, -1, 1)

	ExpHtmlVar = strText
End Function
