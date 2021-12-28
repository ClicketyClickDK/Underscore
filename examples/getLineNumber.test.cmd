:: https://www.dostips.com/forum/viewtopic.php?t=6455

@echo off
setlocal EnableDelayedExpansion


call getLineNumber 2021-12-24T11:51:24 "%~f0" 
echo: Was called from lineno %getlinenumber%

call getLineNumber 2021-12-24T11:51:29 "%~f0" 
echo:lineno %getlinenumber%

