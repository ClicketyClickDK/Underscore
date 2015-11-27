'**********************************************************************
'*@(#) what.inc.vbs - VB script include file for What.cmd
'*
'*
'*
'**********************************************************************
'*
'**********************************************************************

Const ForReading = 1

Set objRegEx = CreateObject("VBScript.RegExp")
input=WScript.Arguments.Item(0) 'File to read
objRegEx.Pattern=WScript.Arguments.Item(1)
masterspace="@"

If 2 < WScript.Arguments.Count Then  
   style=LCase(WScript.Arguments.Item(2))
   Wscript.Echo "<link rel='stylesheet' href='what.css' type='text/css' />"

Else  
   style=""
End If

'Wscript.Echo "style=[" & style &"] Count=[" & WScript.Arguments.Count &"]" '& WScript.Arguments.Item(2)

If IsEmpty(objRegEx.Pattern) Then
	objRegEx.Pattern = masterspace&"\(#\)"
End If
Pattern=Replace(objRegEx.Pattern, "\", "")

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile(input, ForReading)

Do Until objFile.AtEndOfStream
    strSearchString = objFile.ReadLine
    Set colMatches = objRegEx.Execute(strSearchString)  
    If colMatches.Count > 0 Then
        For Each strMatch in colMatches   
			' Original string
			
			strText = Right(strSearchString, len(strSearchString) - (InStr(strSearchString,masterspace&"(#)")+len(Pattern) -1))
			' Expand variables
			Wscript.Echo ExpVar(strText)
        Next
    End If
Loop

'https://msdn.microsoft.com/en-us/library/dy8116cf%28v=vs.84%29.aspx


Dim objWSH
Dim objUserVariables
Dim objSystemVariables

Set objWSH =  CreateObject("WScript.Shell")
'This actually returns all the User Variables, and you either loop through all, or simply print what you want
Set objUserVariables = objWSH.Environment("USER")
Wscript.Echo objUserVariables("$VERSION")


'----------------------------------------------------------------------

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
	If "html" = style Then
		strText = Replace(strText, "%$Name%", "<span class='name'>" & objEnv("$NAME"), 1,-1,1) & "</span>"
		strText = Replace(strText, "%$Description%", "<span class='description'>" & objEnv("$Description"), 1,-1,1) & "</span>"
	else
		strText = Replace(strText, "%$Name%", objEnv("$NAME"), 1,-1,1)
		strText = Replace(strText, "%$Description%", objEnv("$Description"), 1,-1,1)
	End If
	strText = Replace(strText, "%$Source%", objEnv("$Source"), 1,-1,1)
	strText = Replace(strText, "%$Author%", objEnv("$Author"), 1,-1,1)
	'strText = Replace(strText, "%$Revision:~0,4%", objEnv("$Revision"), 1,-1,1)
	strText = Replace(strText, "%$Revision:~0,4%", Mid(objEnv("$Revision"), 1,4),1,-1,1)
	strText = Replace(strText, "%$Version:~0,4%", Mid(objEnv("$Version"), 1,4),1,-1,1)
	
	If "html" = style Then
		strText = ExpHtmlVar(strText)
	Else
		strText = ExpDosVar(strText)
	End If
	ExpVar = strText
End Function	'*** ExpVar() ***

'----------------------------------------------------------------------

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
End Function	'*** expDosVar() ***

'----------------------------------------------------------------------

function ExpHtmlVar(strText)
	prefix = Mid(strText, 1, 1)
	If NOT " " = prefix Then
		if "(c)" = Mid(strText, 1, 3) Then
			strText="<h5>" & strText & "</h5>"
		Else
			strText="<h3>" & strText & "</h3>"
		End If
	Else
		strText="<tt>&nbsp;&nbsp;" & replace(strText, " ", "&nbsp;") & "</tt><BR>"
	End If

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
End Function	'*** expHtmlVar() ***

'*** End of File ******************************************************