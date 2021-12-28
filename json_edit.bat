@if (@CodeSection == @Batch) @then
:: https://github.com/npocmaka/batch.scripts/blob/master/hybrids/jscript/edit.json.bat
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Edit JSON and update value of specific key
SET $AUTHOR=Vasil Arnaudov [https://github.com/npocmaka]
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)      %$NAME% KEY VALUE
::@(#)      %$NAME% KEY.SUBKEY VALUE
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#) Update a specific value in a JSON
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)      
::@(#)      
::@(#)      SET JSON="normal.json"
::@(#)      SET JSON_edit="%~f0"
::@(#)      
::@(#)      ECHO:{ "solo": "Solo value", "level1": { "name": "Name1", "version": "04.21", "level2": { "name": "Name2", "code": "da" } }, "single": "Single value" }>%JSON%
::@(#)      ECHO:%JSON%
::@(#)      type %JSON%
::@(#)      ::{ "solo": "Solo value", "level1": { "name": "Name1", "version": "04.21", "level2": { "name": "Name2", "code": "da" } }, "single": "Single value" }
::@(#)      ECHO:Edit: solo=simple solo
::@(#)      CALL %JSON_edit% %JSON% solo "simple solo"
::@(#)      ::{"solo":"simple solo","level1":{"name":"Name1","version":"04.21","level2":{"name":"Name2","code":"da"}},"single":"Single value"}
::@(#)      ECHO:         ^^^^^^^^^^^^^^^^^^^^^^
::@(#)      ECHO:Edit: level1.name=name of level1
::@(#)      CALL %JSON_edit% %JSON% level1.name "name of level1"
::@(#)      ::{"solo":"Solo value","level1":{"name":"name of level1","version":"04.21","level2":{"name":"Name2","code":"da"}},"single":"Single value"}
::@(#)      ECHO:                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
::@(#)      ECHO:Edit: level1.level2.name=name of level 2
::@(#)      CALL %JSON_edit% %JSON% level1.level2.name "name of level 2"
::@(#)      ::{"solo":"Solo value","level1":{"name":"Name1","version":"04.21","level2":{"name":"name of level 2","code":"da"}},"single":"Single value"}
::@(#)      ECHO:                                                                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
::@(#) 
::@ (#)EXIT STATUS
::@(-)  Exit status / errorlevel is 0 if OK, otherwise 1+.
::@ (#)
::@ (#)ENVIRONMENT
::@(-)  Variables affected
::@ (#)
::@ (#)
::@ (#)FILES, 
::@(-)  Files used, required, affected
::@ (#)
::@ (#)
::@ (#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@ (#)
::@ (#)
::@(#)REQUIRES
::@(-)  Dependecies
::@(#) 
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  
::@ (#)  
::@ (#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@ (#)  URL: 
::@ (#) 
::@(#)
::@(#)SOURCE
::@(-)  Where to find this source
::@(#)  %$Source%
::@(#)
::@ (#)AUTHOR
::@(-)  Who did what
::@ (#)  %$AUTHOR%
::*** HISTORY **********************************************************
::SET $VERSION=YYYY-MM-DD&SET $REVISION=hh:mm:ss&SET $COMMENT=Description/init
  SET $VERSION=2021-12-28&SET $REVISION=16:19:11&SET $COMMENT=Initial/ErikBachmann
::**********************************************************************
::@(#){COPY}%$VERSION:~0,4% %$Author%
::**********************************************************************
::ENDLOCAL

GOTO :main

    SET JSON="\_\examples\testdata\normal.json"
    SET JSON_edit="\_\json_edit.bat "

    >type %JSON%
    { "solo": "Solo value", "level1": { "name": "Name1", "version": "04.21", "level2": { "name": "Name2", "code": "da" } }, "single": "Single value" }

    %JSON_edit% %JSON% solo "simple solo"
    {"solo":"simple solo","level1":{"name":"Name1","version":"04.21","level2":{"name":"Name2","code":"da"}},"single":"Single value"}

    %JSON_edit% %JSON% level1.name "name of level1"
    {"solo":"Solo value","level1":{"name":"name of level1","version":"04.21","level2":{"name":"Name2","code":"da"}},"single":"Single value"}


    %JSON_edit% %JSON% level1.level2.name "name of level 2"
    {"solo":"Solo value","level1":{"name":"Name1","version":"04.21","level2":{"name":"name of level 2","code":"da"}},"single":"Single value"}

::----------------------------------------------------------------------

:main
cscript /nologo /e:JScript "%~f0" %*
goto :EOF

@end // end batch / begin JScript hybrid chimera

var htmlfile = WSH.CreateObject('htmlfile');
htmlfile.write('<meta http-equiv="x-ua-compatible" content="IE=9" />');
var JSON = htmlfile.parentWindow.JSON;

//needs file existence checks
var jsloc=WScript.Arguments.Item(0);
var jsonPath=WScript.Arguments.Item(1);
var newValue=WScript.Arguments.Item(2);


FSOObj = new ActiveXObject("Scripting.FileSystemObject");
var txtFile=FSOObj.OpenTextFile(jsloc,1);
var json=txtFile.ReadAll();

try {
	var jParsed=JSON.parse(json);
}catch(err) {
   WScript.Echo("Failed to parse the json content");
   htmlfile.close();
   txtFile.close();
   WScript.Exit(1);
   //WScript.Echo(err.message);
}
eval("jParsed."+jsonPath+"=newValue");
WScript.Echo(eval("JSON.stringify(jParsed)"));


htmlfile.close();
txtFile.close();
