'http://stackoverflow.com/questions/14973105/replace-multiple-text-in-a-text-file-using-vbscript
Const ForReading = 1
Const ForWriting = 2

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile(".\expand.ref", ForReading)

strText = objFile.ReadAll
objFile.Close
strText = Replace(strText, "{EXCL}", "!")
strText = Replace(strText, "{PCT}", "%")
strText = Replace(strText, "{PIPE}", "|")
strText = Replace(strText, "{CARET}", "^")
strText = Replace(strText, "{AMP}", "&")

Set objFile = objFSO.OpenTextFile(".\Test.txt", ForWriting)
objFile.WriteLine strText

objFile.Close
