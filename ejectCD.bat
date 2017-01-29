::'@ECHO OFF
::'::(Don't pollute the global environment with the following)
::'SETLOCAL ENABLEDELAYEDEXPANSION
::'::**********************************************************************
::'SET $NAME=%~n0
::'SET $DESCRIPTION=Eject CD
::'SET $AUTHOR=npocmaka https://github.com/npocmaka
::'SET $SOURCE=%~f0
::'::@(#)NAME
::'::@(-)  The name of the command or function, followed by a one-line description of what it does.
::'::@(#)      %$NAME% -- %$DESCRIPTION%
::'::@(#) 
::'::@(#)SYNOPSIS
::'::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::'::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::'::@(-)  
::'::@(#)  %$Name% 
::'::@(#) 
::'::@ (#)OPTIONS
::'::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::'::@ (#)  -h      Help page
::'::@ (#) 
::'::@(#)DESCRIPTION
::'::@(-)  A textual description of the functioning of the command or function.
::'::@(#)  Eject CD / DVD
::'::@(#) 
::'::@(#)EXAMPLES
::'::@(-)  Some examples of common usage.
::'::@(#)
::'::@ (#)EXIT STATUS
::'::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::'::@ (#)     The following exit values are returned:
::'::@ (#)     0   Any matches were found.
::'::@ (#)     1   No matches found.
::'::@ (#) 
::'::@(#)REQUIRES
::'::@(-)  Dependecies
::'::@ (#)  _Debug.cmd      Setting up debug environment for batch scripts 
::'::@ (#)  _GetOpt.cmd     Parse command line options and create environment vars
::'::@ (#) 
::'::@ (#)SEE ALSO
::'::@ (#)
::'::@(#)REFERENCE
::'::@(#) URL: http://stackoverflow.com/a/31008030/7485823
::'::@(#) http://stackoverflow.com/questions/19467792/batch-command-line-to-eject-cd-tray
::'::@(#) 
::'::@(#)SOURCE
::'::@(#)  %$Source%
::'::@(#) 
::'::----------------------------------------------------------------------
::':: History
::'::SET $VERSION=YYYY-MM-DD
::'::SET $REVISION=hh:mm:ss
::'::SET $COMMENT=Init / Description [xx.xxx]
::'  SET $VERSION=2015-10-21
::'  SET $REVISION=19:05:00
::'  SET $Comment=Update usage/ErikBachmann
::'::**********************************************************************
::'::@(#)(c)%$VERSION:~0,4% %$Author%
::'::**********************************************************************

::'"%windir%\System32\cscript.exe" //nologo "%~f0?.WSF"  //job:info %~nx0 %*
::'goto :EOF


   <job id="info">
      <script language="VBScript">
        if WScript.Arguments.Count < 2 then
            WScript.Echo "No drive letter passed"
            WScript.Echo "Usage: " 
            WScript.Echo "  " & WScript.Arguments.Item(0) & " {LETTER|*}"
            WScript.Echo "  * will eject all cd drives"
            WScript.Quit 1
        end if
        driveletter = WScript.Arguments.Item(1):
        driveletter = mid(driveletter,1,1):

        Public Function ejectThisDrive (item, iType)
            if InStr(Ucase(iType), "CD") Then
                WScript.Echo "CD FOUND!!!" 
                'ejectingThisDrive (item)
                set verbs=item.Verbs():
                set verb=verbs.Item(verbs.Count-4):
                verb.DoIt():
                item.InvokeVerb replace(verb,"&","") :
                ejectThisDrive = 1
            else
                WScript.Echo "[" & iType & "] not ejected"
                ejectThisDrive = 0
            End if
        End Function
        
        Public Function ejectDrive (drvLtr)
            Set objApp = CreateObject( "Shell.Application" ):
            Set objF=objApp.NameSpace(&H11&):
            result = 0:
            
            set MyComp = objF.Items():
            for each item in objF.Items() :
                iName = objF.GetDetailsOf (item,0): 
                iType = objF.GetDetailsOf (item,1):

                if drvLtr = "*" then 
                    WScript.Echo "eject all"
                    result = result + ejectThisDrive(item, iType)
                    'exit function:
                else
                    iLabels = split (iName , "(" ) :

                    if UBound(iLabels) Then
                        'WScript.Echo "ilabel[" & iLabels(1) & "] "
                        iLabel = iLabels(1):
                        'WScript.Echo "ilabel[" & iLabel & "] "
                        
                        if Ucase(drvLtr) = Mid(iLabel, 1, 1) Then
                            result = result + ejectThisDrive(item, iType)
                            ejectDrive = result
                            exit function:
                        end if
                    end if
                end if
            next    
            ejectDrive = result
        End Function
        
        WScript.Echo "Driveletter[" & driveletter & "] "
        result = ejectDrive (driveletter):
        WScript.Echo "result [" & result & "]"
        
        if result = 0 then
            WScript.Echo "no cd drive found with letter " & driveletter & ":"
            WScript.Quit 2
        end if

      </script>
  </job>