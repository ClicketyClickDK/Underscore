
::----------------------------------------------------------------------

:_UnitTest_getWindowsVersion
SETLOCAL
    SHIFT
    SET $NAME=HKEY_LOCAL_MACHINE
::(#)  #HKEY_LOCAL_MACHINE.CSDVersion=Service Pack 1
::(#)  #HKEY_LOCAL_MACHINE.CurrentBuild=7601
::(#)  #HKEY_LOCAL_MACHINE.CurrentVersion=6.1
::(#)  #HKEY_LOCAL_MACHINE.InstallationType=Client
::(#)  #HKEY_LOCAL_MACHINE.ProductName=Windows 7 Professional
    >>"%TEMP%\%0.trc" ECHO %0

    :: Create dump
    >>"%TEMP%\%0.trc" ECHO :: Create dump
    CALL %0 1>>"%TEMP%\%0.trc" 2>&1
    SET #HKEY_LOCAL_MACHINE. 1>>"%TEMP%\%0.trc" 2>&1

    (
        SET #HKEY_LOCAL_MACHINE
    )>"%TEMP%\%0.dump"
GOTO :EOF *** :_UnitTest_getWindowsVersion ***

::----------------------------------------------------------------------

::MATCH::^#HKEY_LOCAL_MACHINE.CSDVersion=Service Pack
::MATCH::^#HKEY_LOCAL_MACHINE.CurrentBuild=[0-9]*
::MATCH::^#HKEY_LOCAL_MACHINE.CurrentVersion=[0-9]\.[0-9]
::MATCH::^#HKEY_LOCAL_MACHINE.InstallationType=Client
::MATCH::^#HKEY_LOCAL_MACHINE.ProductName=Windows
:: MATCH::^#HKEY_LOCAL_MACHINE.ProductName=Windows 7 Professional
