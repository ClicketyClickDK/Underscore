
::----------------------------------------------------------------------

:_UnitTest__registry.list_keys
SETLOCAL
    SHIFT
    SET _KEY=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion
    SET _REG=REG.exe
    %_REG% query "%_KEY%" | find "CurrentVersion\" >"%TEMP%\%0.ref"
::          CALL _registry.list_keys "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion"
::      Will print a list of keys like:
::          HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Management
::          HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths
::          ::
::          HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\XWizards
::          HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SideBySide
    CALL _registry.list_keys "%_KEY%" >"%TEMP%\%0.dump"
GOTO :EOF *** :_UnitTest__registry.list_keys ***

::----------------------------------------------------------------------