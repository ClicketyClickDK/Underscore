::'@ECHO OFF
::'SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::'::**********************************************************************
::'SET $NAME=%~n0
::'SET $DESCRIPTION=Create a ZIP archive
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
::'::@(#)      %$NAME% [ZIP] {FILE}
::'::@(#)
::'::@(#)OPTIONS
::'::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::'::@(#)  -h      Help page
::'::@(#)  ZIP     FULL path and file name of a ZIP file
::'::@(#)  FILE    Files / directories to be compressed
::'::@(#) 
::'::@(#)DESCRIPTION
::'::@(-)  A textual description of the functioning of the command or function.
::'::@(#)  Since Windows has no build in command line tool for compressing and
::'::@(#)  uncompressing file archive. This - originally VBS - script was build.
::'::@(#) 
::'::@(#)EXAMPLES
::'::@(-)  Some examples of common usage.
::'::@(#)      ECHO:Hello world > "%TEMP%\hello.txt"
::'::@(#)      %$NAME% "%TEMP%\myZip.zip" "%TEMP%\hello.txt"
::'::@(#)      DIR "%TEMP%\myZip.zip"
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
::'::@(#)REQUIRES
::'::@(-)  Dependecies
::'::@(#)  _Debug.cmd      Setting up debug environment for batch scripts 
::'::@(#)  _GetOpt.cmd     Parse command line options and create environment vars
::'::@(#) 
::'::@ (#)SEE ALSO
::'::@(-)  A list of related commands or functions.
::'::@ (#)  
::'::@ (#)  
::'::@ (#)REFERENCE
::'::@(-)  References to inspiration, clips and other documentation
::'::@ (#)  Author:
::'::@ (#)  URL: http://superuser.com/questions/110991/can-you-zip-a-file-from-the-command-prompt-using-only-windows-built-in-capabili
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
::'::SET $VERSION=2014-01-31&SET $REVISION=13:16:00&SET $COMMENT=Description/init
::'::SET $VERSION=2015-02-19&SET $REVISION=16:00:00&SET $COMMENT=Autoupdate / ErikBachmann
::'  SET $VERSION=2015-10-08&SET $REVISION=16:00:00&SET $COMMENT=GetOpt: Calling usage and exit on error / ErikBachmann
::'::**********************************************************************
::'::@(#)(c)%$Version:~0,4% %$Author%
::'::**********************************************************************
::'
::'    CALL "%~dp0\_DEBUG"
::'    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
::'::ENDLOCAL
::'
::'"%windir%\System32\cscript.exe" //nologo //e:vbscript "%~f0" %*
::'goto :EOF
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

Const OPEN_FILE_FOR_APPENDING       = 8

Const FOF_SILENT                    = &H4&
Const FOF_RENAMEONCOLLISION         = &H8&
Const FOF_NOCONFIRMATION            = &H10&    ' 16
Const FOF_ALLOWUNDO                 = &H40&
Const FOF_FILESONLY                 = &H80&
Const FOF_SIMPLEPROGRESS            = &H100&
Const FOF_NOCONFIRMMKDIR            = &H200&   ' 512
Const FOF_NOERRORUI                 = &H400&
Const FOF_NOCOPYSECURITYATTRIBS     = &H800&
Const FOF_NORECURSION               = &H1000&
Const FOF_NO_CONNECTED_ELEMENTS     = &H2000&
cFlags = FOF_SILENT + FOF_NOCONFIRMATION + FOF_NOERRORUI +_
        FOF_NOCONFIRMMKDIR + FOF_RENAMEONCOLLISION

Const ERROR_MAX_RUNTIME_EXCEDED     = &H4&

maxRuntime = 120    ' Max 2 min to zip each file

Set objArgs = WScript.Arguments

' Get ZIP file
    ZipFile = objArgs(0)

    ' Expand file name
    With CreateObject("Scripting.FileSystemObject")
        ZipFile = .GetAbsolutePathName(ZipFile)
    End With

'----------------------------------------------------------------------

' Check if file exists: Append or create
' http://stackoverflow.com/questions/12670123/check-if-a-file-exists-and-only-if-it-does-open-another-file-or-folder-or-ru
Set fileSystemObject = CreateObject("Scripting.FileSystemObject")
If fileSystemObject.FileExists(ZipFile) Then

    'Append to file
    Wscript.Echo "- Append to ZIP file [" & ZipFile & "]"
    CreateObject("Scripting.fileSystemObject").OpenTextFile _
            ZipFile, OPEN_FILE_FOR_APPENDING 
    'objOutputFile.Close
    'Set objFileSystem = Nothing
Else

    ' Create a new file
    Wscript.Echo "- Create ZIP file [" & ZipFile & "]"
    CreateObject("Scripting.FileSystemObject").CreateTextFile(ZipFile, True).Write _
            "PK" & Chr(5) & Chr(6) & String(18, vbNullChar)
End If

Set zip = CreateObject("Shell.Application").NameSpace(ZipFile)

'----------------------------------------------------------------------

' Add each file/directory to the .zip file
For i = 1 To objArgs.count-1
    ' Reset runtime
    runtime             = 0
    ' Count no of items currently in ZIP
    noItemsInZip        = zip.Items.Count
    
    ' Get absolut path of file to add
    With CreateObject("Scripting.FileSystemObject")
        source  = .GetAbsolutePathName(objArgs(i))
    End With

    ' Check if file is all ready in zip
    'http://stackoverflow.com/questions/4724140/how-to-read-the-contents-of-a-zip-file-with-vbscript-without-actually-extractin
    fileExists  = 0
    Set objSource = zip.Items ()
    For Each item in objSource
        intCompare = StrComp(UCase(item) ,UCase(objArgs(i)), vbTextCompare)
        If 0 = intCompare Then
            WScript.Echo "% Skipping: [" & source & "]"
            fileExists = 1
        'Else
            'WScript.Echo "no match: " & item & " == " & objArgs(i)
        End If
    Next     
    
    ' If file is not i ZIP: Apppend
    If ( 0 = fileExists) Then
        WScript.Echo "+ Appending: [" & source & "]"

        zip.CopyHere source, cflags

        ' Wait until copy is done..
        Do Until zip.Items.Count >= ( noItemsInZip + 1 )
            WScript.Sleep 100
            Wscript.Stdout.Write "."
            runtime = runtime + 1

            ' If runtime is exceeded: abort
            If runtime >= maxRuntime Then
                noItemsInZip = noItemsInZip - 9
                WScript.Echo "! Max runtime exceeded: " & maxRuntime
                WScript.Echo "! Aborting"
                WScript.Quit ERROR_MAX_RUNTIME_EXCEDED
            End If
        Loop
    'Else
        'WScript.Echo "Skipping: [" & source & "]"
    End If
Next

WScript.Quit 0

'*** End of File ******************************************************