@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION&::(Don't pollute the global environment with the following)
::**********************************************************************
SET $NAME=%~n0
SET $DESCRIPTION=Get day number in year
SET $AUTHOR=robvanderwoude.com
SET $SOURCE=%~f0
::@(#)NAME
::@(-)  The name of the command or function, followed by a one-line description of what it does.
::@(#)      %$NAME% -- %$DESCRIPTION%
::@(#) 
::@(#)SYNOPSIS
::@(-)  In the case of a command, a formal description of how to run it and what command line options it takes. 
::@(-)  For program functions, a list of the parameters the function takes and which header file contains its definition.
::@(-)  
::@(#)      %$NAME% [VAR] [Date YYYY-MM-DD]
::@(#) 
::@(#)OPTIONS
::@(-)  Flags, parameters, arguments (NOT the Monty Python way)
::@(#)  -h      Help page
::@(#)
::@ (#) 
::@(#)DESCRIPTION
::@(-)  A textual description of the functioning of the command or function.
::@(#)  Get day number in year for a given date
::@(#) 
::@(#)EXAMPLES
::@(-)  Some examples of common usage.
::@(#)
::@(#)        getDayOfYear _doy 2015-03-30
::@(#)        SET _doy=89
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
::@ (#)REQUIRES
::@(-)  Dependencies
::@ (#)  
::@ (#)
::@(#)SEE ALSO
::@(-)  A list of related commands or functions.
::@(#)  date.reference.csv  Reference file for date convertions
::@ (#)  
::@(#)REFERENCE
::@(-)  References to inspiration, clips and other documentation
::@ (#)  Author:
::@(#)  URL: http://www.robvanderwoude.com/files/datepart_xp.txt
::@(#)  URL: http://disc.gsfc.nasa.gov/julian_calendar.shtml 
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
::SET $VERSION=2015-02-19&SET $REVISION=16:00:00&SET $COMMENT=Autoupdate / ErikBachmann
  SET $VERSION=2015-10-08&SET $REVISION=11:20:00&SET $COMMENT=GetOpt: Calling usage on -h and exit on error / ErikBachmann
::**********************************************************************
::@(#)(c)%$Version:~0,4% %$Author%
::**********************************************************************

    CALL "%~dp0\_DEBUG"
    CALL "%~dp0\_Getopt" %*&IF ERRORLEVEL 1 EXIT /B 1

::ENDLOCAL

:: URL=http://www.robvanderwoude.com/files/datepart_xp.txt

    SET UTC=%~2
    IF NOT DEFINED UTC CALL _utc>nul

    SET LeapYear=0
    SET /A Month=10%UTC:~5,2% %% 100
    SET /A DAY=10%UTC:~8,2% %% 100

    CALL isLeapYear %UTC%
    CALL :DayofYear

    IF DEFINED DEBUG IF NOT "0"=="%DEBUG%" SET DayOfYear
    ENDLOCAL&SET %~1=%DayOfYear%
GOTO :EOF

:DayOfYear
    :: Fill array with cumulative number of days of past months
    SET /A DaysPast.1  = 0
    SET /A DaysPast.2  = %DaysPast.1%  + 31
    SET /A DaysPast.3  = %DaysPast.2%  + 28 + %LeapYear%
    SET /A DaysPast.4  = %DaysPast.3%  + 31
    SET /A DaysPast.5  = %DaysPast.4%  + 30
    SET /A DaysPast.6  = %DaysPast.5%  + 31
    SET /A DaysPast.7  = %DaysPast.6%  + 30
    SET /A DaysPast.8  = %DaysPast.7%  + 31
    SET /A DaysPast.9  = %DaysPast.8%  + 31
    SET /A DaysPast.10 = %DaysPast.9%  + 30
    SET /A DaysPast.11 = %DaysPast.10% + 31
    SET /A DaysPast.12 = %DaysPast.11% + 30
    SET /A DayOfYear   = !DaysPast.%Month%! + %Day%
GOTO:EOF

::Documentation
:: URL http://disc.gsfc.nasa.gov/julian_calendar.shtml
:: 
:: Perpetual
::  
:: Day	Jan 	Feb 	Mar 	Apr 	May 	Jun 	Jul 	Aug 	Sep 	Oct 	Nov 	Dec
:: 1 	001 	032 	060 	091 	121 	152 	182 	213 	244 	274 	305 	335
:: 2 	002 	033 	061 	092 	122 	153 	183 	214 	245 	275 	306 	336
:: 3 	003 	034 	062 	093 	123 	154 	184 	215 	246 	276 	307 	337
:: 4 	004 	035 	063 	094 	124 	155 	185 	216 	247 	277 	308 	338
:: 5 	005 	036 	064 	095 	125 	156 	186 	217 	248 	278 	309 	339
:: 6 	006 	037 	065 	096 	126 	157 	187 	218 	249 	279 	310 	340
:: 7 	007 	038 	066 	097 	127 	158 	188 	219 	250 	280 	311 	341
:: 8 	008 	039 	067 	098 	128 	159 	189 	220 	251 	281 	312 	342
:: 9 	009 	040 	068 	099 	129 	160 	190 	221 	252 	282 	313 	343
:: 10 	010 	041 	069 	100 	130 	161 	191 	222 	253 	283 	314 	344
:: 11 	011 	042 	070 	101 	131 	162 	192 	223 	254 	284 	315 	345
:: 12 	012 	043 	071 	102 	132 	163 	193 	224 	255 	285 	316 	346
:: 13 	013 	044 	072 	103 	133 	164 	194 	225 	256 	286 	317 	347
:: 14 	014 	045 	073 	104 	134 	165 	195 	226 	257 	287 	318 	348
:: 15 	015 	046 	074 	105 	135 	166 	196 	227 	258 	288 	319 	349
:: 16 	016 	047 	075 	106 	136 	167 	197 	228 	259 	289 	320 	350
:: 17 	017 	048 	076 	107 	137 	168 	198 	229 	260 	290 	321 	351
:: 18 	018 	049 	077 	108 	138 	169 	199 	230 	261 	291 	322 	352
:: 19 	019 	050 	078 	109 	139 	170 	200 	231 	262 	292 	323 	353
:: 20 	020 	051 	079 	110 	140 	171 	201 	232 	263 	293 	324 	354
:: 21 	021 	052 	080 	111 	141 	172 	202 	233 	264 	294 	325 	355
:: 22 	022 	053 	081 	112 	142 	173 	203 	234 	265 	295 	326 	356
:: 23 	023 	054 	082 	113 	143 	174 	204 	235 	266 	296 	327 	357
:: 24 	024 	055 	083 	114 	144 	175 	205 	236 	267 	297 	328 	358
:: 25 	025 	056 	084 	115 	145 	176 	206 	237 	268 	298 	329 	359
:: 26 	026 	057 	085 	116 	146 	177 	207 	238 	269 	299 	330 	360
:: 27 	027 	058 	086 	117 	147 	178 	208 	239 	270 	300 	331 	361
:: 28 	028 	059 	087 	118 	148 	179 	209 	240 	271 	301 	332 	362
:: 29 	029 	    	088 	119 	149 	180 	210 	241 	272 	302 	333 	363
:: 30 	030 	    	089 	120 	150 	181 	211 	242 	273 	303 	334 	364
:: 31 	031 	    	090 	    	151 	    	212 	243 	    	304 	    	365
::  
:: For Leap Years Only
:: 
:: If a year can be divided by 4 or 400 without remainder, it is a leap year.
:: If a year can be divided by 100 without remainder it is a common year.
:: 
:: The next leap year will be 2016.
:: 
:: The next year that is divisible by both 100 and 4 will be the year 2100.
:: 
:: The next year that is divisible by 400 will be the year 2400.
:: Day	Jan 	Feb 	Mar 	Apr 	May 	Jun 	Jul 	Aug 	Sep 	Oct 	Nov 	Dec
:: 1 	001 	032 	061 	092 	122 	153 	183 	214 	245 	275 	306 	336
:: 2 	002 	033 	062 	093 	123 	154 	184 	215 	246 	276 	307 	337
:: 3 	003 	034 	063 	094 	124 	155 	185 	216 	247 	277 	308 	338
:: 4 	004 	035 	064 	095 	125 	156 	186 	217 	248 	278 	309 	339
:: 5 	005 	036 	065 	096 	126 	157 	187 	218 	249 	279 	310 	340
:: 6 	006 	037 	066 	097 	127 	158 	188 	219 	250 	280 	311 	341
:: 7 	007 	038 	067 	098 	128 	159 	189 	220 	251 	281 	312 	342
:: 8 	008 	039 	068 	099 	129 	160 	190 	221 	252 	282 	313 	343
:: 9 	009 	040 	069 	100 	130 	161 	191 	222 	253 	283 	314 	344
:: 10 	010 	041 	070 	101 	131 	162 	192 	223 	254 	284 	315 	345
:: 11 	011 	042 	071 	102 	132 	163 	193 	224 	255 	285 	316 	346
:: 12 	012 	043 	072 	103 	133 	164 	194 	225 	256 	286 	317 	347
:: 13 	013 	044 	073 	104 	134 	165 	195 	226 	257 	287 	318 	348
:: 14 	014 	045 	074 	105 	135 	166 	196 	227 	258 	288 	319 	349
:: 15 	015 	046 	075 	106 	136 	167 	197 	228 	259 	289 	320 	350
:: 16 	016 	047 	076 	107 	137 	168 	198 	229 	260 	290 	321 	351
:: 17 	017 	048 	077 	108 	138 	169 	199 	230 	261 	291 	322 	352
:: 18 	018 	049 	078 	109 	139 	170 	200 	231 	262 	292 	323 	353
:: 19 	019 	050 	079 	110 	140 	171 	201 	232 	263 	293 	324 	354
:: 20 	020 	051 	080 	111 	141 	172 	202 	233 	264 	294 	325 	355
:: 21 	021 	052 	081 	112 	142 	173 	203 	234 	265 	295 	326 	356
:: 22 	022 	053 	082 	113 	143 	174 	204 	235 	266 	296 	327 	357
:: 23 	023 	054 	083 	114 	144 	175 	205 	236 	267 	297 	328 	358
:: 24 	024 	055 	084 	115 	145 	176 	206 	237 	268 	298 	329 	359
:: 25 	025 	056 	085 	116 	146 	177 	207 	238 	269 	299 	330 	360
:: 26 	026 	057 	086 	117 	147 	178 	208 	239 	270 	300 	331 	361
:: 27 	027 	058 	087 	118 	148 	179 	209 	240 	271 	301 	332 	362
:: 28 	028 	059 	088 	119 	149 	180 	210 	241 	272 	302 	333 	363
:: 29 	029 	060 	089 	120 	150 	181 	211 	242 	273 	303 	334 	364
:: 30 	030 	    	090 	121 	151 	182 	212 	243 	274 	304 	335 	365
:: 31 	031 	    	091 	    	152 	    	213 	244 	    	305 	    	366
::  
:: ::*** End of File *****************************************************