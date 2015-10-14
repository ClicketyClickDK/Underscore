::@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Sub script to _debug.cmd
SET $Author=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $Source=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)  %$Name% -- %$Description%
::@(#) 

>>&2 ECHO %*
>>%$TraceFile% ECHO %*
::PAUSE

::*** End Of File *****************************************************