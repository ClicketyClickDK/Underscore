::'@ECHO OFF&setlocal EnableDelayedExpansion
::'::*********************************************************************
::'SET $NAME=%~n0
::'SET $DESCRIPTION=Action part of "Action [status]" line
::'SET $SOURCE=%~f0
::'::@(#)NAME
::'::@(-)  The name of the command or function, followed by a one-line description of what it does.
::'::@(#)      %$NAME% -- %$DESCRIPTION%
::'::@(#) 
::'::@(#)SYNOPSIS
::'::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::'::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::'::@(-)  
::'::@(#)  %$NAME% [ButtonID] [Window title] [Message]
::'::@(#) 
::'::@(#)OPTIONS
::'::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::'::@(#)  -h      Help page
::'::@(#) 
::'::@(#)DESCRIPTION
::'::@(#)  %$NAME% opens a window with:
::'::@(#)  a title, a message, type based icon and reply buttons.
::'::@(#)
::'::@(#)  The return value [ErrorLevel] is the value of the button pressed.
::'::@(#)
::'::@(#) 
::'::@(#)BUTTONS
::'::@(#)  [Optional]
::'::@(#)  A value or a sum of values that specifies the number and type of buttons 
::'::@(#)  to display, the icon style to use, the identity of the default button, 
::'::@(#)  and the modality of the message box. 
::'::@(#)  Default value is 0
::'::@(#) 
::'::@(#)    0 = vbOKOnly           - OK button only
::'::@(#)    1 = vbOKCancel         - OK and Cancel buttons
::'::@(#)    2 = vbAbortRetryIgnore - Abort, Retry, and Ignore buttons
::'::@(#)    3 = vbYesNoCancel      - Yes, No, and Cancel buttons
::'::@(#)    4 = vbYesNo            - Yes and No buttons
::'::@(#)    5 = vbRetryCancel      - Retry and Cancel buttons
::'::@(#)   16 = vbCritical         - Critical Message icon
::'::@(#)   32 = vbQuestion         - Warning Query icon
::'::@(#)   48 = vbExclamation      - Warning Message icon
::'::@(#)   64 = vbInformation      - Information Message icon
::'::@(#)    0 = vbDefaultButton1   - First button is default
::'::@(#)  256 = vbDefaultButton2   - Second button is default
::'::@(#)  512 = vbDefaultButton3   - Third button is default
::'::@(#)  768 = vbDefaultButton4   - Fourth button is default
::'::@(#)    0 = vbApplicationModal - Application modal 
::'::@(#)                              (the current application will not work 
::'::@(#)                              until the user responds to the message box)
::'::@(#) 4096 = vbSystemModal      - System modal 
::'::@(#)                              (all applications wont work until the user 
::'::@(#)                              responds to the message box)
::'::@(#) 
::'::@(#)  We can divide the buttons values into four groups: 
::'::@(#)  - The first group (0-5) describes the buttons to be displayed in the 
::'::@(#)    message box,
::'::@(#)  - the second group (16, 32, 48, 64) describes the icon style, 
::'::@(#)  - the third group (0, 256, 512, 768) indicates which button is the default; 
::'::@(#)  - and the fourth group (0, 4096) determines the modality of the message box. 
::'::@(#) 
::'::@(#)  When adding numbers to create a final value for the buttons parameter, use
::'::@(#)  only one number from each group
::'::@(#)
::'::@(#)EXAMPLES
::'::@(-)  Some examples of common usage.
::'::@(#)      %$NAME% 35 "_TITLE" "_MSG"
::'::@(#)
::'::@(#)  Will open a window with a question and YesNoCancel
::'::@(#)  Select [Yes] and the script will return the value 6
::'::@(#)      
::'::@(#)  A extended example:
::'::@(#)      
::'::@(#)      :msgbox
::'::@(#)          SET _INPUT=
::'::@(#)          SET _TITLE=window title
::'::@(#)          SET _MSG=Hello world.{CrLf}Please select:
::'::@(#)          CALL _MsgBox.bat 35 "%_TITLE%" "%_MSG%"
::'::@(#)          CALL :RETURN %errorlevel%
::'::@(#)      GOTO :EOF
::'::@(#)      
::'::@(#)      :return
::'::@(#)          IF ERRORLEVEL 7 ECHO:7 = vbNo     - No was clicked      &GOTO :EOF
::'::@(#)          IF ERRORLEVEL 6 ECHO:6 = vbYes    - Yes was clicked     &GOTO :EOF
::'::@(#)          IF ERRORLEVEL 5 ECHO:5 = vbIgnore - Ignore was clicked  &GOTO :EOF
::'::@(#)          IF ERRORLEVEL 4 ECHO:4 = vbRetry  - Retry was clicked   &GOTO :EOF
::'::@(#)          IF ERRORLEVEL 3 ECHO:3 = vbAbort  - Abort was clicked   &GOTO :EOF
::'::@(#)          IF ERRORLEVEL 2 ECHO:2 = vbCancel - Cancel was clicked  &GOTO :EOF
::'::@(#)          IF ERRORLEVEL 1 ECHO:1 = vbOK     - OK was clicked      &GOTO :EOF
::'::@(#)          ECHO:Undefined value [%errorlevel%]
::'::@(#)      GOTO :EOF
::'::@(#)
::'::@ (#)EXIT STATUS
::'::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::'::@(#)  The MsgBox function can return one of the following values:
::'::@(#)  7 = vbNo     - No was clicked
::'::@(#)  6 = vbYes    - Yes was clicked
::'::@(#)  5 = vbIgnore - Ignore was clicked
::'::@(#)  4 = vbRetry  - Retry was clicked
::'::@(#)  3 = vbAbort  - Abort was clicked
::'::@(#)  2 = vbCancel - Cancel was clicked 
::'::@(#)  1 = vbOK     - OK was clicked
::'::@(#)
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
::'::@(#)SEE ALSO
::'::@(-)  A list of related commands or functions.
::'::@(#)  _inputBox.bat
::'::@(#)
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
::'::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Comment/Init [00.000]
::'::SET $VERSION=2010-10-07&SET $REVISION=08:35:00&SET $COMMENT=Intial/ErikBachmann [00.010]
::'::SET $VERSION=2010-10-20&SET $REVISION=17:15:00&SET $COMMENT=Addding $Source/ErikBachmann [01.011]
::'::SET $VERSION=2011-01-17&SET $REVISION=15:43:00&SET $COMMENT=ActionRange=45/ErikBachmann [01.012]
::'::SET $VERSION=2015-02-18&SET $REVISION=18:16:00&SET $Comment=cdmdized/ErikBachmann
::'::SET $VERSION=2015-10-08&SET $REVISION=09:40:00&SET $Comment=Help -h added/ErikBachmann
::'  SET $VERSION=2015-10-21&SET $REVISION=19:19:00&SET $Comment=Update usage/ErikBachmann
::'::**********************************************************************
::'::@(#)(c)%$VERSION:~0,4% %$Author%
::'::**********************************************************************
::'CALL "%~dp0_debug"
::'CALL "%~dp0_GetOpt" %*&IF ERRORLEVEL 1 EXIT /B 1
::'
::'"%windir%\System32\cscript.exe" //nologo //e:vbscript "%~f0" %*
::'IF DEFINED DEBUG ECHO:Errorlevel=[%ErrorLevel%]
::'ENDLOCAL&EXIT /B %ErrorLevel%
::'goto :EOF
::':Usage
::'ECHO USAGE
::'goto :EOF
Set args = Wscript.Arguments

x=MsgBox( Replace(WScript.Arguments.Item(2),"{CrLf}", vbCrLf), WScript.Arguments.Item(0), WScript.Arguments.Item(1) )

wscript.quit x
' http://www.vistax64.com/vb-script/192365-return-value-vbscript-cmd-file.html

'*** End Of File ******************************************************