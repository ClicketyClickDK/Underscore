::'@ECHO OFF
::'SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::'::**********************************************************************
::'SET $NAME=%~n0
::'SET $DESCRIPTION=Unzip an existing ZIP archive
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
::'::@(#)      %$NAME% [ZIP] {DIR}
::'::@(#)
::'::@(#)OPTIONS
::'::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::'::@(#)  -h      Help page
::'::@(#)  ZIP     FULL path and file name of a ZIP file
::'::@(#)  DIR     Directories where the archive should be decompressed
::'::@(#) 
::'::@(#)DESCRIPTION
::'::@(-)  A textual description of the functioning of the command or function.
::'::@(#)  Since Windows has no build in command line tool for compressing and
::'::@(#)  uncompressing file archive. This - originally VBS - script was build.
::'::@(#) 
::'::@(#)EXAMPLES
::'::@(-)  Some examples of common usage.
::'::@(#)      ECHO:Hello world>"%TMP%\hello.txt"
::'::@(#)      CALL zip.bat "%TMP%\hello.zip" "%TMP%\hello.txt"
::'::@(#)      DEL "%TMP%\hello.txt"
::'::@(#)      DIR "%TMP%\hello.txt"
::'::@(#)      CALL unzip.bat "%TMP%\hello.zip" "%TMP%"
::'::@(#)      DIR "%TMP%\hello.txt"
::'::@ (#)
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
::'::SET $VERSION=2015-10-08&SET $REVISION=16:00:00&SET $COMMENT=GetOpt: Calling usage and exit on error / ErikBachmann
::' SET $VERSION=2015-10-22&SET $REVISION=06:00:00&SET $COMMENT=Update usage / ErikBachmann
::'::**********************************************************************
::'::@(#)(c)%$Version:~0,4% %$Author%
::'::**********************************************************************
::'
::'    CALL "%~dp0\_DEBUG"
::'    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
::'
::'::ENDLOCAL


::':: ECHO:Hello world>"%TMP%\hello.txt"
::':: zip.bat "%TMP%\hello.zip" "%TMP%\hello.txt"
::':: DEL "%TMP%\hello.txt"
::':: DIR "%TMP%\hello.txt"
::':: unzip.bat "%TMP%\hello.zip" "%TMP%"
::':: DIR "%TMP%\hello.txt"

::'@echo off
::'"%windir%\System32\cscript.exe" //nologo //e:vbscript "%~f0" %*
::'goto :EOF
' Unzip an archive to a distination folder
'
'Adapted from http://www.robvanderwoude.com/vbstech_files_zip.html
'http://www.experts-exchange.com/OS/Microsoft_Operating_Systems/MS_DOS/Q_24087976.html
'Version="2010-11-11"
'revision="12:00:00"
Const VERSION="2014-01-31":Const REVISION="13:16:00"

Wscript.Echo Wscript.ScriptName & " v." & version 
Wscript.Echo Wscript.ScriptFullName & " rev. (" & revision & ")"
Wscript.Echo 

strArchive = "C:\Users\DBCjob\scripts.zip"
strDest = "C:\Users\DBCjob\temp"

'-----------------------------------------------------------------
'Parsing arguments
Set args = WScript.Arguments

If WScript.Arguments.Count = 0 Then
 Wscript.Echo "Usage: " & Wscript.ScriptName & " zipfile target_dir"
 Wscript.Echo "     " & Wscript.ScriptName & " C:\file.zip C:\temp"
 Wscript.Quit
End If

strArchive = args.Item(0)
Wscript.Echo "- Archive:   [" + strArchive + "]"

If WScript.Arguments.Count > 1 Then
  strDest = args.Item(1)
End If

Wscript.Echo "- Destination: [" + strDest + "]"

'------------------------------------------------------------------
 
Set objFSO = CreateObject("Scripting.FileSystemObject")
 
If Not objFSO.FolderExists(strDest) Then
    objFSO.CreateFolder(strDest)
End If
 
UnZipFile strArchive, strDest
 
Sub UnZipFile(strArchive, strDest)
    Set objApp = CreateObject( "Shell.Application" )
    
    Set objArchive = objApp.NameSpace(strArchive).Items()
    Set objDest = objApp.NameSpace(strDest)
 
    objDest.CopyHere objArchive,8+16
End Sub

'4		Do not display a progress dialog box.
'8		Give the file being operated on a new name in a move, copy, or rename operation if a file with the target name already exists.
'16		Respond with "Yes to All" for any dialog box that is displayed.
'64		Preserve undo information, if possible.
'128	Perform the operation on files only if a wildcard file name '*.*	 is specified.
'256	Display a progress dialog box but do not show the file names.
'512	Do not confirm the creation of a new directory if the operation requires one to be created.
'1024	Do not display a user interface if an error occurs.
'2048	Version 4.71. Do not copy the security attributes of the file.
'4096	Only operate in the local directory. Do not operate recursively into subdirectories.
'8192	Version 5.0. Do not copy connected files as a group. Only copy the specified files.
