@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Make posters
SET $AUTHOR=Erik Bachmann, ClicketyClick.dk [ErikBachmann@ClicketyClick.dk]
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)      %$NAME% [strings]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#) 
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  %$NAME% prints its arguments [each up to 10 characters long] 
::@(#)  in large letters on the standard output.
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)  banner Banner
::@(#) 
::@(#)  ######
::@(#)  #     #   ##   #    # #    # ###### #####
::@(#)  #     #  #  #  ##   # ##   # #      #    #
::@(#)  ######  #    # # #  # # #  # #####  #    #
::@(#)  #     # ###### #  # # #  # # #      #####
::@(#)  #     # #    # #   ## #   ## #      #   #
::@(#)  ######  #    # #    # #    # ###### #    #
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
::@(#)BUGS / KNOWN PROBLEMS
::@(-)  If any known
::@(#)  Several characters can cause problems: Ampersand, percent, circumflex.
::@(#)  The most common can be handled ASCII 32 [20h] - 126 [7Eh]
::@(#)
::@ (#)REQUIRES
::@(-)  Dependencies
::@ (#)  
::@ (#)
::@ (#)SEE ALSO
::@(-)  A list of related commands or functions.
::@ (#)  
::@ (#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@(#)  Author: Wikipedia
::@(#)  URL: http://en.wikipedia.org/wiki/List_of_Unicode_characters
::@(#) 
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
  SET $VERSION=2015-03-18&SET $REVISION=08:00:00&SET $COMMENT=Initial/ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

:init
    ::SET _DEBUG_=IF DEFINED DEBUG IF NOT "0"=="%DEBUG%" 2^>^&1 ECHO:[%0]: 

    SET "_STR=%~1"
    %_DEBUG_% "%_Str%"
    SET "_str=%_str:^^=^%"
    ::pause
    %_DEBUG_% "[%_STR%]"
    SET _Config=Ban2.txt
    SET _Config=Ban2.csv
    SET _Config=%~dpnx0

:Process
    FOR /L %%l IN (7,-1,0) DO (
        %_DEBUG_%- %%l
        CALL :parseStr %%l
    )

GOTO :EOF

::---------------------------------------------------------------------

:ParseStr
    SeT "_myStr=%_str%"
    SET _line=

    :ParseStrNext
        :: Extract next char
            SET "_Char=%_myStr:~0,1%"
        
        :: Map char
            SET "_Char=%_Char:"=22%"
            SET "_Char=%_Char:&=26%"
            SET "_Char=%_Char:<=3C%"
            SET "_Char=%_Char:>=3E%"
            SET "_Char=%_Char:^=5E%"
            SET "_Char=%_Char:`=60%"
            %_DEBUG_%[%_Char%]
            ::pause
            IF " "=="%_char%" SET _Char=20
            
            IF "!"=="%_char%" SET _Char=21
            ::IF "^^^""=="%_char%" SET _Char=22
            IF "#"=="%_char%" SET _Char=23
            IF "$"=="%_char%" SET _Char=24
            IF "%%"=="%_char%" SET _Char=25
            IF "^&"=="%_char%" SET _Char=26
            IF "'"=="%_char%" SET _Char=27
            IF "Å"=="%_char%" SET _Char=C2
            
            IF "@"=="%_char%" SET _Char=AT
            IF "\"=="%_char%" SET _Char=5C
            IF "="=="%_char%" SET _Char=3D
            IF "."=="%_char%" SET _Char=2E
            IF "*"=="%_char%" SET _Char=2A
            IF "+"=="%_char%" SET _Char=2B
            IF ","=="%_char%" SET _Char=2C
            IF ":"=="%_char%" SET _Char=3A
            IF ";"=="%_char%" SET _Char=3B

        :: Danish characters
        :: Upper case ASCII
            IF "’"=="%_char%" SET _Char=C6&REM AE
            IF ""=="%_char%" SET _Char=D2&REM OE
            IF ""=="%_char%" SET _Char=C2&REM AA

        :: Upper case Ansi
            IF "Æ"=="%_char%" SET _Char=C6&REM AE
            IF "Ø"=="%_char%" SET _Char=D2&REM OE
            IF "Å"=="%_char%" SET _Char=C2&REM AA

        :: Lower case ASCII
            IF "‘"=="%_char%" SET _Char=E6&REM ae
            IF "›"=="%_char%" SET _Char=F8& REM oe
            IF "†"=="%_char%" SET _Char=E5& REM aa

        :: Lower case Ansi
            IF "æ"=="%_char%" SET _Char=E6&REM ae
            IF "ø"=="%_char%" SET _Char=F8& REM oe
            IF "å"=="%_char%" SET _Char=E5& REM aa

        :: Shorten reminding string
        SET "_myStr=%_myStr:~1%"
        
        :: If undefined char quit
        IF NOT DEFINED _char GOTO :EOF
        
        :: Search for matching ASCII ART
        SET "_Pattern=::Banner:%_char%-%~1:"
        %_DEBUG_%"%_pattern%"

        FOR /F "Delims=: tokens=3*" %%B IN ('FINDSTR "%_pattern%" "%_config%"') DO CALL SET "_LINE=%_line% %%B"
        %_DEBUG_%[%%B] [%_line%]
        
        :: Print line
        IF NOT DEFINED _myStr ECHO:%_line:.=%&GOTO :EOF
        rem PAUSE
    GOTO :ParseStrNext
GOTO :EOF :: *** :ParseStr ***

::---------------------------------------------------------------------
::     +------------------ Prefix
::     |   |+------------- Character
::     |   |||+----------- Separator "-"
::     |   ||||+---------- Line number 7-0
::     |   |||||+--------- Separator ":"
::     |   |||||| +------ Field content = Art
::     |   |||||| |  +--- End of field marker "."
::     |   |||||v---v|  
:: v------v:V-v:#####.
:: ::banner:?-7:       .

::** Blank
::Banner:20-7:  .
::Banner:20-6:  .
::Banner:20-5:  .
::Banner:20-4:  .
::Banner:20-3:  .
::Banner:20-2:  .
::Banner:20-1:  .
::Banner:20-0:  .
::-------------------------------------
:: Exclamation mark
::Banner:21-7:     .
::Banner:21-6:  ###.
::Banner:21-5:  ###.
::Banner:21-4:  ###.
::Banner:21-3:   # .
::Banner:21-2:     .
::Banner:21-1:  ###.
::Banner:21-0:  ###.
::-------------------------------------
:: Double Quote
::Banner:22-7:       .
::Banner:22-6:  ## ##.
::Banner:22-5:  ## ##.
::Banner:22-4:  #  # .
::Banner:22-3: #  #  .
::Banner:22-2:       .
::Banner:22-1:       .
::Banner:22-0:       .
::-------------------------------------
:: Hash
::Banner:23-7:       .
::Banner:23-6:       .
::Banner:23-5:  #  # .
::Banner:23-4: ######.
::Banner:23-3:  #  # .
::Banner:23-2: ######.
::Banner:23-1:  #  # .
::Banner:23-0:       .
::-------------------------------------
:: Dollar
::Banner:24-7:       .
::Banner:24-6:   #   .
::Banner:24-5:  #### .
::Banner:24-4: # #   .
::Banner:24-3:  #### .
::Banner:24-2:   #  #.
::Banner:24-1: ##### .
::Banner:24-0:   #   .
::-------------------------------------
:: Pct
::Banner:25-7:       .
::Banner:25-6:       .
::Banner:25-5: ##  # .
::Banner:25-4: ## #  .
::Banner:25-3:   #   .
::Banner:25-2:  # ## .
::Banner:25-1: #  ## .
::Banner:25-0:       .
::-------------------------------------
:: Ampersand
::Banner:26-7:       .
::Banner:26-6: ####  .
::Banner:26-5:#    # .
::Banner:26-4:#    # .
::Banner:26-3: ####  .
::Banner:26-2:#    ##.
::Banner:26-1:#    # .
::Banner:26-0: #### #.
::-------------------------------------
:: Single Quote
::Banner:27-7:     .
::Banner:27-6:  ## .
::Banner:27-5:  ## .
::Banner:27-4:  #  .
::Banner:27-3: #   .
::Banner:27-2:     .
::Banner:27-1:     .
::Banner:27-0:     .
::-------------------------------------
:: Left parentheses
::Banner:(-7:     .
::Banner:(-6:   ##.
::Banner:(-5:  #  .
::Banner:(-4: #   .
::Banner:(-3: #   .
::Banner:(-2: #   .
::Banner:(-1:  #  .
::Banner:(-0:   ##.
:: Right parentheses
::Banner:)-7:      .
::Banner:)-6:  ##  .
::Banner:)-5:    # .
::Banner:)-4:     #.
::Banner:)-3:     #.
::Banner:)-2:     #.
::Banner:)-1:    # .
::Banner:)-0:  ##  .
::-------------------------------------
:: Asterix
::Banner:2A-7:       .
::Banner:2A-6:       .
::Banner:2A-5: #   # .
::Banner:2A-4:  # #  .
::Banner:2A-3:#######.
::Banner:2A-2:  # #  .
::Banner:2A-1: #   # .
::Banner:2A-0:       .
::-------------------------------------
:: Plus
::Banner:+-7:      .
::Banner:+-6:      .
::Banner:+-5:   #  .
::Banner:+-4:   #  .
::Banner:+-3: #####.
::Banner:+-2:   #  .
::Banner:+-1:   #  .
::Banner:+-0:      .
::-------------------------------------
:: Comma
::Banner:2C-7:     .
::Banner:2C-6:     .
::Banner:2C-5:     .
::Banner:2C-4:     .
::Banner:2C-3:  ###.
::Banner:2C-2:  ###.
::Banner:2C-1:   # .
::Banner:2C-0:  # .
::-------------------------------------
:: Separator
::Banner:--7:      .
::Banner:--6:      .
::Banner:--5:      .
::Banner:--4:      .
::Banner:--3: #####.
::Banner:--2:      .
::Banner:--1:      .
::Banner:--0:      .
::-------------------------------------
:: Punctuation
::Banner:2E-7:     .
::Banner:2E-6:     .
::Banner:2E-5:     .
::Banner:2E-4:     .
::Banner:2E-3:     .
::Banner:2E-2:  ###.
::Banner:2E-1:  ###.
::Banner:2E-0:  ###.
::-------------------------------------
:: Slash
::Banner:/-7:       .
::Banner:/-6:      #.
::Banner:/-5:     # .
::Banner:/-4:    #  .
::Banner:/-3:   #   .
::Banner:/-2:  #    .
::Banner:/-1: #     .
::Banner:/-0:#      .
::-------------------------------------
::Banner:0-7:       .
::Banner:0-6:  ###  .
::Banner:0-5: #   # .
::Banner:0-4:#     #.
::Banner:0-3:#     #.
::Banner:0-2:#     #.
::Banner:0-1: #   # .
::Banner:0-0:  ###  .
::-------------------------------------
::Banner:1-7:      .
::Banner:1-6:   #  .
::Banner:1-5:  ##  .
::Banner:1-4: # #  .
::Banner:1-3:   #  .
::Banner:1-2:   #  .
::Banner:1-1:   #  .
::Banner:1-0: #####.
::-------------------------------------
::Banner:2-7:       .
::Banner:2-6: ##### .
::Banner:2-5:#     #.
::Banner:2-4:      #.
::Banner:2-3: ##### .
::Banner:2-2:#      .
::Banner:2-1:#      .
::Banner:2-0:#######.
::-------------------------------------
::Banner:3-7:       .
::Banner:3-6: ##### .
::Banner:3-5:#     #.
::Banner:3-4:      #.
::Banner:3-3: ##### .
::Banner:3-2:      #.
::Banner:3-1:#     #.
::Banner:3-0: ##### .
::-------------------------------------
::Banner:4-7:       .
::Banner:4-6:#      .
::Banner:4-5:#    # .
::Banner:4-4:#    # .
::Banner:4-3:#    # .
::Banner:4-2:#######.
::Banner:4-1:     # .
::Banner:4-0:     # .
::-------------------------------------
::Banner:5-7:       .
::Banner:5-6:#######.
::Banner:5-5:#      .
::Banner:5-4:#      .
::Banner:5-3:###### .
::Banner:5-2:      #.
::Banner:5-1:#     #.
::Banner:5-0: ##### .
::-------------------------------------
::Banner:6-7:       .
::Banner:6-6: ##### .
::Banner:6-5:#     #.
::Banner:6-4:#      .
::Banner:6-3:###### .
::Banner:6-2:#     #.
::Banner:6-1:#     #.
::Banner:6-0: ##### .
::-------------------------------------
::Banner:7-7:       .
::Banner:7-6:#######.
::Banner:7-5:#    # .
::Banner:7-4:    #  .
::Banner:7-3:   #   .
::Banner:7-2:  #    .
::Banner:7-1:  #    .
::Banner:7-0:  #    .
::-------------------------------------
::Banner:8-7:       .
::Banner:8-6: ##### .
::Banner:8-5:#     #.
::Banner:8-4:#     #.
::Banner:8-3: #####.
::Banner:8-2:#     #.
::Banner:8-1:#     #.
::Banner:8-0: ##### .
::-------------------------------------
::Banner:9-7:       .
::Banner:9-6: ##### .
::Banner:9-5:#     #.
::Banner:9-4:#     #.
::Banner:9-3: ######.
::Banner:9-2:      #.
::Banner:9-1:#     #.
::Banner:9-0: ##### .
::-------------------------------------
::Colon
::Banner:3A-7:     .
::Banner:3A-6:   # .
::Banner:3A-5:  ###.
::Banner:3A-4:   # .
::Banner:3A-3:     .
::Banner:3A-2:   # .
::Banner:3A-1:  ###.
::Banner:3A-0:   # .
::Banner:3B-7:     .
::-------------------------------------
:: Semicolon
::Banner:3B-6:  ###.
::Banner:3B-5:  ###.
::Banner:3B-4:     .
::Banner:3B-3:  ###.
::Banner:3B-2:  ###.
::Banner:3B-1:   # .
::Banner:3B-0:  #  .
::-------------------------------------
:: Less than
::Banner:3C-7:     .
::Banner:3C-6:    #.
::Banner:3C-5:   # .
::Banner:3C-4:  #  .
::Banner:3C-3: #   .
::Banner:3C-2:  #  .
::Banner:3C-1:   # .
::Banner:3C-0:    #.
::-------------------------------------
:: Equal
::Banner:3D-7:      .
::Banner:3D-6:      .
::Banner:3D-5:      .
::Banner:3D-4: #####.
::Banner:3D-3:      .
::Banner:3D-2: #####.
::Banner:3D-1:      .
::Banner:3D-0:      .
::-------------------------------------
:: Greater than
::Banner:3E-7:      .
::Banner:3E-6:  #   .
::Banner:3E-5:   #  .
::Banner:3E-4:    # .
::Banner:3E-3:     #.
::Banner:3E-2:    # .
::Banner:3E-1:   #  .
::Banner:3E-0:  #   .
::-------------------------------------
:: Question mark
::Banner:?-7:       .
::Banner:?-6: ##### .
::Banner:?-5:#     #.
::Banner:?-4:      #.
::Banner:?-3:   ### .
::Banner:?-2:   #   .
::Banner:?-1:       .
::Banner:?-0:   #   .
::-------------------------------------
:: Masterspace / AT
::Banner:AT-7:       .
::Banner:AT-6: ##### .
::Banner:AT-5:#     #.
::Banner:AT-4:# ### #.
::Banner:AT-3:# ### #.
::Banner:AT-2:# #### .
::Banner:AT-1:#      .
::Banner:AT-0: ##### .
::-------------------------------------
::Banner:A-7:       .
::Banner:A-6:   #   .
::Banner:A-5:  # #  .
::Banner:A-4: #   # .
::Banner:A-3:#     #.
::Banner:A-2:#######.
::Banner:A-1:#     #.
::Banner:A-0:#     #.
::-------------------------------------
::Banner:B-7:       .
::Banner:B-6:###### .
::Banner:B-5:#     #.
::Banner:B-4:#     #.
::Banner:B-3:###### .
::Banner:B-2:#     #.
::Banner:B-1:#     #.
::Banner:B-0:###### .
::-------------------------------------
::Banner:C-7:       .
::Banner:C-6: ##### .
::Banner:C-5:#     #.
::Banner:C-4:#      .
::Banner:C-3:#      .
::Banner:C-2:#      .
::Banner:C-1:#     #.
::Banner:C-0: ##### .
::-------------------------------------
::Banner:D-7:       .
::Banner:D-6:###### .
::Banner:D-5:#     #.
::Banner:D-4:#     #.
::Banner:D-3:#     #.
::Banner:D-2:#     #.
::Banner:D-1:#     #.
::Banner:D-0:###### .
::-------------------------------------
::Banner:E-7:       .
::Banner:E-6:#######.
::Banner:E-5:#      .
::Banner:E-4:#      .
::Banner:E-3:#####  .
::Banner:E-2:#      .
::Banner:E-1:#      .
::Banner:E-0:#######.
::-------------------------------------
::Banner:F-7:       .
::Banner:F-6:#######.
::Banner:F-5:#      .
::Banner:F-4:#      .
::Banner:F-3:#####  .
::Banner:F-2:#      .
::Banner:F-1:#      .
::Banner:F-0:#      .
::-------------------------------------
::Banner:G-7:       .
::Banner:G-6: ##### .
::Banner:G-5:#     #.
::Banner:G-4:#      .
::Banner:G-3:#  ####.
::Banner:G-2:#     #.
::Banner:G-1:#     #.
::Banner:G-0: ##### .
::-------------------------------------
::Banner:H-7:       .
::Banner:H-6:#     #.
::Banner:H-5:#     #.
::Banner:H-4:#     #.
::Banner:H-3:#######.
::Banner:H-2:#     #.
::Banner:H-1:#     #.
::Banner:H-0:#     #.
::-------------------------------------
::Banner:I-7:     .
::Banner:I-6:###.
::Banner:I-5: # .
::Banner:I-4: # .
::Banner:I-3: # .
::Banner:I-2: # .
::Banner:I-1: # .
::Banner:I-0:###.
::-------------------------------------
::Banner:J-7:       .
::Banner:J-6:      #.
::Banner:J-5:      #.
::Banner:J-4:      #.
::Banner:J-3:      #.
::Banner:J-2:#     #.
::Banner:J-1:#     #.
::Banner:J-0: ##### .
::-------------------------------------
::Banner:K-7:      .
::Banner:K-6:#    #.
::Banner:K-5:#   # .
::Banner:K-4:#  #  .
::Banner:K-3:###   .
::Banner:K-2:#  #  .
::Banner:K-1:#   # .
::Banner:K-0:#    #.
::-------------------------------------
::Banner:L-7:       .
::Banner:L-6:#      .
::Banner:L-5:#      .
::Banner:L-4:#      .
::Banner:L-3:#      .
::Banner:L-2:#      .
::Banner:L-1:#      .
::Banner:L-0:#######.
::-------------------------------------
::Banner:M-7:       .
::Banner:M-6:#     #.
::Banner:M-5:##   ##.
::Banner:M-4:# # # #.
::Banner:M-3:#  #  #.
::Banner:M-2:#     #.
::Banner:M-1:#     #.
::Banner:M-0:#     #.
::-------------------------------------
::Banner:N-7:       .
::Banner:N-6:#     #.
::Banner:N-5:##    #.
::Banner:N-4:# #   #.
::Banner:N-3:#  #  #.
::Banner:N-2:#   # #.
::Banner:N-1:#    ##.
::Banner:N-0:#     #.
::-------------------------------------
::Banner:O-7:       .
::Banner:O-6:#######.
::Banner:O-5:#     #.
::Banner:O-4:#     #.
::Banner:O-3:#     #.
::Banner:O-2:#     #.
::Banner:O-1:#     #.
::Banner:O-0:#######.
::-------------------------------------
::Banner:P-7:       .
::Banner:P-6:###### .
::Banner:P-5:#     #.
::Banner:P-4:#     #.
::Banner:P-3:###### .
::Banner:P-2:#      .
::Banner:P-1:#      .
::Banner:P-0:#      .
::-------------------------------------
::Banner:Q-7:       .
::Banner:Q-6: ##### .
::Banner:Q-5:#     #.
::Banner:Q-4:#     #.
::Banner:Q-3:#     #.
::Banner:Q-2:#   # #.
::Banner:Q-1:#    # .
::Banner:Q-0: #### #.
::-------------------------------------
::Banner:R-7:      .
::Banner:R-6:###### .
::Banner:R-5:#     #.
::Banner:R-4:#     #.
::Banner:R-3:###### .
::Banner:R-2:#   #  .
::Banner:R-1:#    # .
::Banner:R-0:#     #.
::-------------------------------------
::Banner:S-7:       .
::Banner:S-6: ##### .
::Banner:S-5:#     #.
::Banner:S-4:#      .
::Banner:S-3: ##### .
::Banner:S-2:      #.
::Banner:S-1:#     #.
::Banner:S-0: ##### .
::-------------------------------------
::Banner:T-7:       .
::Banner:T-6:#######.
::Banner:T-5:   #   .
::Banner:T-4:   #   .
::Banner:T-3:   #   .
::Banner:T-2:   #   .
::Banner:T-1:   #   .
::Banner:T-0:   #   .
::-------------------------------------
::Banner:U-7:       .
::Banner:U-6:#     #.
::Banner:U-5:#     #.
::Banner:U-4:#     #.
::Banner:U-3:#     #.
::Banner:U-2:#     #.
::Banner:U-1:#     #.
::Banner:U-0: ##### .
::-------------------------------------
::Banner:V-7:       .
::Banner:V-6:#     #.
::Banner:V-5:#     #.
::Banner:V-4:#     #.
::Banner:V-3:#     #.
::Banner:V-2: #   # .
::Banner:V-1:  # #  .
::Banner:V-0:   #   .
::-------------------------------------
::Banner:W-7:       .
::Banner:W-6:#     #.
::Banner:W-5:#  #  #.
::Banner:W-4:#  #  #.
::Banner:W-3:#  #  #.
::Banner:W-2:#  #  #.
::Banner:W-1:#  #  #.
::Banner:W-0: ## ## .
::-------------------------------------
::Banner:X-7:       .
::Banner:X-6:#     #.
::Banner:X-5: #   # .
::Banner:X-4:  # #  .
::Banner:X-3:   #   .
::Banner:X-2:  # #  .
::Banner:X-1: #   # .
::Banner:X-0:#     #.
::-------------------------------------
::Banner:Y-7:       .
::Banner:Y-6:#     #.
::Banner:Y-5: #   # .
::Banner:Y-4:  # #  .
::Banner:Y-3:   #   .
::Banner:Y-2:   #   .
::Banner:Y-1:   #   .
::Banner:Y-0:   #   .
::-------------------------------------
::Banner:Z-7:       .
::Banner:Z-6:#######.
::Banner:Z-5:     # .
::Banner:Z-4:    #  .
::Banner:Z-3:   #   .
::Banner:Z-2:  #    .
::Banner:Z-1: #     .
::Banner:Z-0:#######.
::-------------------------------------
::Banner:[-7:      .
::Banner:[-6: #####.
::Banner:[-5: #    .
::Banner:[-4: #    .
::Banner:[-3: #    .
::Banner:[-2: #    .
::Banner:[-1: #    .
::Banner:[-0: #####.
::-------------------------------------
:: Back slash
::Banner:5C-7:        .
::Banner:5C-6: #      .
::Banner:5C-5:  #     .
::Banner:5C-4:   #    .
::Banner:5C-3:    #   .
::Banner:5C-2:     #  .
::Banner:5C-1:      # .
::Banner:5C-0:       #.
::-------------------------------------
:: Hard right
::Banner:]-7:      .
::Banner:]-6: #####.
::Banner:]-5:     #.
::Banner:]-4:     #.
::Banner:]-3:     #.
::Banner:]-2:     #.
::Banner:]-1:     #.
::Banner:]-0: #####.
::-------------------------------------
:: Hacheck
::Banner:5E-7:          .
::Banner:5E-6:     #    .
::Banner:5E-5:   #   #  .
::Banner:5E-4: #       #.
::Banner:5E-3:          .
::Banner:5E-2:          .
::Banner:5E-1:          .
::Banner:5E-0:          .
::-------------------------------------
:: Accent grave
::Banner:60-7:     .
::Banner:60-6:  #  .
::Banner:60-5:   # .
::Banner:60-4:     .
::Banner:60-3:     .
::Banner:60-2:     .
::Banner:60-1:     .
::Banner:60-0:     .
::-------------------------------------
:: Underscore
::Banner:_-7:       .
::Banner:_-6:       .
::Banner:_-5:       .
::Banner:_-4:       .
::Banner:_-3:       .
::Banner:_-2:       .
::Banner:_-1:       .
::Banner:_-0: ######.
::-------------------------------------
::Banner:a-7:       .
::Banner:a-6:       .
::Banner:a-5:  ##  .
::Banner:a-4: #  # .
::Banner:a-3:#    #.
::Banner:a-2:######.
::Banner:a-1:#    #.
::Banner:a-0:#    #.
::-------------------------------------
::Banner:b-7:      .
::Banner:b-6:      .
::Banner:b-5:##### .
::Banner:b-4:#    #.
::Banner:b-3:##### .
::Banner:b-2:#    #.
::Banner:b-1:#    #.
::Banner:b-0:##### .
::-------------------------------------
::Banner:c-7:      .
::Banner:c-6:      .
::Banner:c-5: #### .
::Banner:c-4:#    #.
::Banner:c-3:#     .
::Banner:c-2:#     .
::Banner:c-1:#    #.
::Banner:c-0: #### .
::-------------------------------------
::Banner:d-7:      .
::Banner:d-6:      .
::Banner:d-5:##### .
::Banner:d-4:#    #.
::Banner:d-3:#    #.
::Banner:d-2:#    #.
::Banner:d-1:#    #.
::Banner:d-0:##### .
::-------------------------------------
::Banner:e-7:      .
::Banner:e-6:      .
::Banner:e-5:######.
::Banner:e-4:#     .
::Banner:e-3:##### .
::Banner:e-2:#     .
::Banner:e-1:#     .
::Banner:e-0:######.
::-------------------------------------
::Banner:f-7:      .
::Banner:f-6:      .
::Banner:f-5:######.
::Banner:f-4:#     .
::Banner:f-3:##### .
::Banner:f-2:#     .
::Banner:f-1:#     .
::Banner:f-0:#     .
::-------------------------------------
::Banner:g-7:      .
::Banner:g-6:      .
::Banner:g-5: #### .
::Banner:g-4:#    #.
::Banner:g-3:#     .
::Banner:g-2:#  ###.
::Banner:g-1:#    #.
::Banner:g-0: #### .
::-------------------------------------
::Banner:h-7:      .
::Banner:h-6:      .
::Banner:h-5:#    #.
::Banner:h-4:#    #.
::Banner:h-3:######.
::Banner:h-2:#    #.
::Banner:h-1:#    #.
::Banner:h-0:#    #.
::-------------------------------------
::Banner:i-7:   .
::Banner:i-6:   .
::Banner:i-5:###.
::Banner:i-4: # .
::Banner:i-3: # .
::Banner:i-2: # .
::Banner:i-1: # .
::Banner:i-0:###.
::-------------------------------------
::Banner:j-7:      .
::Banner:j-6:      .
::Banner:j-5:     #.
::Banner:j-4:     #.
::Banner:j-3:     #.
::Banner:j-2:     #.
::Banner:j-1:#    #.
::Banner:j-0: #### .
::-------------------------------------
::Banner:k-7:      .
::Banner:k-6:      .
::Banner:k-5:#    #.
::Banner:k-4:#   # .
::Banner:k-3:####  .
::Banner:k-2:#  #  .
::Banner:k-1:#   # .
::Banner:k-0:#    #.
::-------------------------------------
::Banner:l-7:      .
::Banner:l-6:      .
::Banner:l-5:#     .
::Banner:l-4:#     .
::Banner:l-3:#     .
::Banner:l-2:#     .
::Banner:l-1:#     .
::Banner:l-0:######.
::-------------------------------------
::Banner:m-7:      .
::Banner:m-6:      .
::Banner:m-5:#    #.
::Banner:m-4:##  ##.
::Banner:m-3:# ## #.
::Banner:m-2:#    #.
::Banner:m-1:#    #.
::Banner:m-0:#    #.
::-------------------------------------
::Banner:n-7:      .
::Banner:n-6:      .
::Banner:n-5:#    #.
::Banner:n-4:##   #.
::Banner:n-3:# #  #.
::Banner:n-2:#  # #.
::Banner:n-1:#   ##.
::Banner:n-0:#    #.
::-------------------------------------
::Banner:o-7:      .
::Banner:o-6:      .
::Banner:o-5: #### .
::Banner:o-4:#    #.
::Banner:o-3:#    #.
::Banner:o-2:#    #.
::Banner:o-1:#    #.
::Banner:o-0: #### .
::-------------------------------------
::Banner:p-7:      .
::Banner:p-6:      .
::Banner:p-5:##### .
::Banner:p-4:#    #.
::Banner:p-3:#    #.
::Banner:p-2:##### .
::Banner:p-1:#     .
::Banner:p-0:#     .
::-------------------------------------
::Banner:q-7:      .
::Banner:q-6:      .
::Banner:q-5: #### .
::Banner:q-4:#    #.
::Banner:q-3:#    #.
::Banner:q-2:#  # #.
::Banner:q-1:#   # .
::Banner:q-0: ### #.
::-------------------------------------
::Banner:r-7:      .
::Banner:r-6:      .
::Banner:r-5:##### .
::Banner:r-4:#    #.
::Banner:r-3:#    #.
::Banner:r-2:##### .
::Banner:r-1:#   # .
::Banner:r-0:#    #.
::-------------------------------------
::Banner:s-7:      .
::Banner:s-6:      .
::Banner:s-5: #### .
::Banner:s-4:#     .
::Banner:s-3: #### .
::Banner:s-2:     #.
::Banner:s-1:#    #.
::Banner:s-0: #### .
::-------------------------------------
::Banner:t-7:     .
::Banner:t-6:     .
::Banner:t-5:#####.
::Banner:t-4:  #  .
::Banner:t-3:  #  .
::Banner:t-2:  #  .
::Banner:t-1:  #  .
::Banner:t-0:  #  .
::-------------------------------------
::Banner:u-7:     .
::Banner:u-6:      .
::Banner:u-5:#    #.
::Banner:u-4:#    #.
::Banner:u-3:#    #.
::Banner:u-2:#    #.
::Banner:u-1:#    #.
::Banner:u-0: #### .
::-------------------------------------
::Banner:v-7:      .
::Banner:v-6:      .
::Banner:v-5:#    #.
::Banner:v-4:#    #.
::Banner:v-3:#    #.
::Banner:v-2:#    #.
::Banner:v-1: #  # .
::Banner:v-0:  ##  .
::-------------------------------------
::Banner:w-7:      .
::Banner:w-6:      .
::Banner:w-5:#    #.
::Banner:w-4:#    #.
::Banner:w-3:#    #.
::Banner:w-2:# ## #.
::Banner:w-1:##  ##.
::Banner:w-0:#    #.
::-------------------------------------
::Banner:x-7:      .
::Banner:x-6:      .
::Banner:x-5:#    #.
::Banner:x-4: #  # .
::Banner:x-3:  ##  .
::Banner:x-2:  ##  .
::Banner:x-1: #  # .
::Banner:x-0:#    #.
::-------------------------------------
::Banner:y-7:     .
::Banner:y-6:     .
::Banner:y-5:#   #.
::Banner:y-4: # # .
::Banner:y-3:  #  .
::Banner:y-2:  #  .
::Banner:y-1:  #  .
::Banner:y-0:  #  .
::-------------------------------------
::Banner:z-7:      .
::Banner:z-6:      .
::Banner:z-5:######.
::Banner:z-4:    # .
::Banner:z-3:   #  .
::Banner:z-2:  #   .
::Banner:z-1: #    .
::Banner:z-0:######.
::-------------------------------------
:: Left curl
::-------------------------------------
::Banner:{-7:       .
::Banner:{-6:  ###.
::Banner:{-5: #   .
::Banner:{-4: #   .
::Banner:{-3:##   .
::Banner:{-2: #   .
::Banner:{-1: #   .
::Banner:{-0:  ###.
::-------------------------------------
:: Pipe
::Banner:|-7:    .
::Banner:|-6:   #.
::Banner:|-5:   #.
::Banner:|-4:   #.
::Banner:|-3:    .
::Banner:|-2:   #.
::Banner:|-1:   #.
::Banner:|-0:   #.
::-------------------------------------
:: Right Curl
::Banner:}-7:       .
::Banner:}-6:  ###  .
::Banner:}-5:     # .
::Banner:}-4:     # .
::Banner:}-3:     ##.
::Banner:}-2:     # .
::Banner:}-1:     # .
::Banner:}-0:  ###  .
::-------------------------------------
:: Thilde
::Banner:~-7:       .
::Banner:~-6: ##    .
::Banner:~-5:#  #  #.
::Banner:~-4:    ## .
::Banner:~-3:       .
::Banner:~-2:       .
::Banner:~-1:       .
::Banner:~-0:       .
::-------------------------------------
:: Æ Ae - ae lig upper case
::Banner:C6-7:          .
::Banner:C6-6:   #######.
::Banner:C6-5:  ##      .
::Banner:C6-4: #  #     .
::Banner:C6-3:##########.
::Banner:C6-2:#    #    .
::Banner:C6-1:#    #    .
::Banner:C6-0:#    #####.
::-------------------------------------
:: Ø Oe - O slash upper case
::Banner:D2-7:        .
::Banner:D2-6: #### # .
::Banner:D2-5:#    # #.
::Banner:D2-4:#   #  #.
::Banner:D2-3:#  #   #.
::Banner:D2-2:# #    #.
::Banner:D2-1: #     #.
::Banner:D2-0:# ##### .
::-------------------------------------
:: Å Aa - A ring upper case
::Banner:C2-7:       .
::Banner:C2-6: ##### .
::Banner:C2-5: ## ## .
::Banner:C2-4: # # # .
::Banner:C2-3:#     #.
::Banner:C2-2:#######.
::Banner:C2-1:#     #.
::Banner:C2-0:#     #.
::-------------------------------------
:: æ ae - ae lig  lower case
::Banner:E6-7:       .
::Banner:E6-6:       .
::Banner:E6-5:  #####.
::Banner:E6-4: ##    .
::Banner:E6-3:#  #   .
::Banner:E6-2:#######.
::Banner:E6-1:#  #   .
::Banner:E6-0:#  ####.
::-------------------------------------
:: ø oe - o slash lower case
::Banner:F8-7:      .
::Banner:F8-6:      .
::Banner:F8-5: ### #.
::Banner:F8-4:#   # .
::Banner:F8-3:#  # #.
::Banner:F8-2:# #  #.
::Banner:F8-1: #   #.
::Banner:F8-0:# ### .
::-------------------------------------
:: å aa - a ring lower case
::Banner:E5-7:       .
::Banner:E5-6: #### .
::Banner:E5-5: #  # .
::Banner:E5-4: #### .
::Banner:E5-3:#    #.
::Banner:E5-2:######.
::Banner:E5-1:#    #.
::Banner:E5-0:#    #.
::-------------------------------------
:: *** End of File ***