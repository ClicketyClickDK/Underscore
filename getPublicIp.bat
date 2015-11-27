::'@ECHO OFF
::'SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::'::**********************************************************************
::'SET $NAME=%~n0
::'SET $DESCRIPTION=Call to external site returns external IP
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
::'::@(#)      %$NAME%
::'::@(#) 
::'::@(#)OPTIONS
::'::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::'::@(#)  -h      Help page
::'::@(#) 
::'::@ (#) 
::'::@(#)DESCRIPTION
::'::@(-)  A textual description of the functioning of the command or function.
::'::@(#)  A call to http://ifconfig.me/ip returns the external IP
::'::@(#) 
::'::@(#)EXAMPLES
::'::@(-)  Some examples of common usage.
::'::@(#)  getPublicIp.bat
::'::@(#)  46.30.212.21
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
::'::@(-)  Dependencies
::'::@(#)  MSXML2.XMLHTTP
::'::@(#)
::'::@ (#)SEE ALSO
::'::@(-)  A list of related commands or functions.
::'::@ (#)  
::'::@ (#)  
::'::@(#)REFERENCE
::'::@(-)  References to inspiration, clips and other documentation
::'::@(#)  Author: bob
::'::@(#)  URL: http://superuser.com/questions/404926/how-to-get-my-external-ip-address-over-nat-from-the-windows-command-line
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
::'::SET $VERSION=2015-02-19&SET $REVISION=00:00:00&SET $COMMENT=Initial/ErikBachmann
::'  SET $VERSION=2015-10-08&SET $REVISION=16:00:00&SET $COMMENT=GetOpt: Calling usage and exit on error / ErikBachmann
::'::**********************************************************************
::'::@(#)(c)%$Version:~0,4% %$Author%
::'::**********************************************************************
::'::ENDLOCAL
::'
::'    CALL "%~dp0\_DEBUG"
::'    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1
::'
::'"%windir%\System32\cscript.exe" //nologo //e:vbscript "%~f0" %*
::'EXIT /B %Errorlevel%
::'GOTO :EOF
' get public IP for current location
Dim target
' Posible targets
'target = "http://ifconfig.me/ip"
'target = "http://www.whatsmyip.org"
'target = "ipinfo.io/ip"
target = "http://ipecho.net/plain"
Dim o
Set o = CreateObject("MSXML2.XMLHTTP")
On Error Resume Next
o.open "GET", target, False
getError(Err.Number)
o.send
getError(Err.Number)
WScript.Echo o.responseText

sub getError(ErrNumber)
    If ErrNumber <> 0 Then
        'error handling:
        if -2146697209 = ErrNumber Then
            WScript.Echo "No internet connection"
        End if
        WScript.Echo Err.Number & " Srce: " & Err.Source & " Desc: " &  Err.Description
        WScript.Quit(Err.Number)
        Err.Clear
    End if
End sub


}

'::*** End of File ******************************************************