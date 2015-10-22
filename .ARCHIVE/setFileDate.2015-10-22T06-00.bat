::'@ECHO OFF
::'SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::'::**********************************************************************
::'SET $NAME=%~n0
::'SET $DESCRIPTION=Set a specific date on a file
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
::'::@(#)      %$NAME% [FILE] [DATE]
::'::@(#) 
::'::@(#)OPTIONS
::'::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::'::@(#)  -h      Help page
::'::@(#)  FILE    The target file which date will be updated
::'::@(#)  DATE    A date and time string 
::'::@(#) 
::'::@(#) 
::'::@(#)DESCRIPTION
::'::@(-)  A textual description of the functioning of the command or function.
::'::@(#)  The date string kan be ISO [YYYY-MM-DD hh:mm:ss] or traditional
::'::@(#)  [MM/DD/YYYY hh:mm:ss]
::'::@(#) 
::'::@(#)EXAMPLES
::'::@(-)  Some examples of common usage.
::'::@(#)  ECHO:Hello World>"%TMP%\hello.txt"
::'::@(#)  setfiledate.bat "%TMP%\hello.txt" "01/01/2008 8:00:00 AM"
::'::@(#)  setfiledate.bat "%TMP%\hello.txt" "2015-01-02 01:02:03"
::'::@(#)  DIR "%TMP%\hello.txt"|findstr "hello"
::'::@(#) 
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
::'
::'"%windir%\System32\cscript.exe" //nologo //e:vbscript "%~f0" %*
::'goto :EOF
'**********************************************************************
Const NAME          = "setFileDate.vbs"
Const DESCRIPTION   = "Change modification time stamp"
Const AUTHOR        = "Erik Bachmann"
'*** History **********************************************************
Const VERSION="01.000":Const REVISION="2014-02-06T13:16:00"
::Const COMMENT="Init"
'**********************************************************************
' http://superuser.com/questions/110991/can-you-zip-a-file-from-the-command-prompt-using-only-windows-built-in-capabili
' http://blogs.technet.com/b/heyscriptingguy/archive/2006/05/30/how-can-i-extract-just-the-file-name-from-the-full-path-to-the-file.aspx
'
' cscript zip.vbs target.zip sourceFile1 sourceDir2 ... sourceObjN
' Return
'   0   OK
'   4   Max runtime exceeded

WScript.Echo Wscript.ScriptName & " v." & VERSION & " - " & DESCRIPTION
WScript.Echo " rev." & REVISION & " by " & AUTHOR
WScript.Echo

Set objArgs = WScript.Arguments

'http://stackoverflow.com/questions/16217829/change-modification-time-stamp-with-vbscript
Set objShell = CreateObject("Shell.Application")

    ' Get absolut path of file to add
    With CreateObject("Scripting.FileSystemObject")
        source  = .GetAbsolutePathName(objArgs(0))
        path    = .GetParentFolderName(source)
        file    = .GetFileName(source)
    End With

    'WScript.Echo "source=[" & source &"]"
    'WScript.Echo "path=[" & path &"]"
    'WScript.Echo "file=[" & file &"]"
    'WScript.Echo "date=[" & objArgs(1)  &"]"

Set objFolder = objShell.NameSpace(path)
Set objFolderItem = objFolder.ParseName(file)

'objFolderItem.ModifyDate = objArgs(1)
fDate = Replace(objArgs(1),"T"," ")
'WScript.Echo "fDate" & fDate
objFolderItem.ModifyDate = fDate


'*** End Of File ***
