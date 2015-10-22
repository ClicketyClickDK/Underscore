@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=checkoutArchive
SET $DESCRIPTION=Input routine for batch using VBScript to provide input box
SET $Author=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $Source=C:\Users\Erik\Documents\GitHub\Underscore\checkoutArchive.cmd
:: History
::SET $VERSION=xx.xxx&SET $REVISION=YYYY-MM-DDThh:mm:ss&SET $COMMENT=Init / Description
::SET $VERSION=01.000&SET $REVISION=2010-10-13T15:36:00&SET $COMMENT=ebp / Initial: FindInPath
  SET $VERSION=01.002&SET $REVISION=2014-01-11T10:59:00&SET $Comment=Update doc + example/EBP
