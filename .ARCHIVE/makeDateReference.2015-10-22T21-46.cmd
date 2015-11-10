@ECHO OFF
SETLOCAL Enabledelayedexpansion
    TITLE %0
    SET _Tab=	
    SET _StartYear=1970
    SET _EndYear=2030

    ::SET _StartYear=1999
    ::SET _EndYear=2000

    SET _StartOfset=3

    IF EXIST "%TEMP%\%~n0.csv" DEL "%TEMP%\%~n0.csv"
    (
        ECHO:#ISO%_TAB%YYYY%_TAB%MM%_TAB%DD%_TAB%JD%_TAB%DOY%_TAB%DOW%_TAB%Uge.nr%_TAB%WeekNo formel
        ECHO:#"=DATO(1970;01;01)"	"#1970"	"#01"	"#01"	"#=DATO(B3;C3;D3)+2415018"	"#=DATO(B3;C3;D3)-DATO(B3;1;1)+1"	"#=UGEdag(DATO(B3;C3;D3))"	"#=UGE.NR(DATO(B3;C3;D3))"	"#=AFKORT((DATO(B3;C3;D3)-DATO(ÅR(DATO(B3;C3;D3)+3-REST(DATO(B3;C3;D3)-2;7));1;REST(DATO(B3;C3;D3)-2;7)-9))/7)"
    )>"%TEMP%\%~n0.csv"

    TITLE %0: %_StartYear% - %_EndYear%

    FOR /L %%Y in (%_StartYear%, 1, %_EndYear%) DO (
        FOR /L %%M IN (01, 1, 12) DO (   REM Jan, Mar, May Jul
            FOR /L %%D IN (01, 1, 31) DO CALL :SetDate %%Y %%M %%D
        )
    )
GOTO :EOF
    FOR /L %%Y in (%_StartYear%, 1, %_EndYear%) DO (
        FOR /L %%M IN (01, 2, 7) DO (   REM Jan, Mar, May Jul
            FOR /L %%D IN (01, 1, 31) DO CALL :SetDate %%Y %%M %%D
        )
        CALL :IsLeapYear _Leap %%y
        SET /A _Leap+=28
        
        FOR /L %%M IN (02, 2, 02) DO (  REM Feb + leap
            FOR /L %%D IN (01, 1, !_leap!) DO CALL :SetDate %%Y %%M %%D
        )
        FOR /L %%M IN (08, 2, 12) DO (   REM Aug, Oct, Dec
            FOR /L %%D IN (01, 1, 31) DO CALL :SetDate %%Y %%M %%D
        )
        FOR /L %%M IN (04, 2, 6) DO (   REM Apr Jun, Sep, Nov
            FOR /L %%D IN (01, 1, 30) DO CALL :SetDate %%Y %%M %%D
        )
        FOR /L %%M IN (09, 2, 11) DO (   REM  Sep, Nov
            FOR /L %%D IN (01, 1, 30) DO CALL :SetDate %%Y %%M %%D
        )

    )>nul
    ::>>"%TEMP%\%~n0.csv"
GOTO :EOF

:SetDate
    SET _Y=%~1
    SET _M=0%~2
    SET _M=!_M:~-2!
    SET _D=0%~3
    SET _D=!_D:~-2!
    TITLE %0 %_Y%-%_M%-%_D%
    
    REM         ISO
    SET _Ref==DATO^(%_Y%;%_M%;%_D%^)	%_Y%	%_M%	%_D%
    REM         Julian date http://www.vertex42.com/ExcelTemplates/julian-date-calendar.html
    SET _Ref=!_REF!	=DATO^(B%_StartOfset%;C%_StartOfset%;D%_StartOfset%^)+2415018
    REM         DayOfYear   http://www.excel-easy.com/examples/day-of-the-year.html
    SET _Ref=!_REF!	=DATO^(B%_StartOfset%;C%_StartOfset%;D%_StartOfset%^)-DATO^(B%_StartOfset%;1;1^)+1
    REM         DayOfWeek
    SET _Ref=!_REF!	=UGEdag^(DATO^(B%_StartOfset%;C%_StartOfset%;D%_StartOfset%^);3^)
    REM         Week no
    SET _Ref=!_REF!	=UGE.NR^(DATO^(B%_StartOfset%;C%_StartOfset%;D%_StartOfset%^)^)
    SET _REF=!_REF!	=AFKORT^(^(DATO^(B%_StartOfset%;C%_StartOfset%;D%_StartOfset%^)-DATO^(ÅR^(DATO^(B%_StartOfset%;C%_StartOfset%;D%_StartOfset%^)+3-REST^(DATO^(B%_StartOfset%;C%_StartOfset%;D%_StartOfset%^)-2;7^)^);1;REST^(DATO^(B%_StartOfset%;C%_StartOfset%;D%_StartOfset%^)-2;7^)-9^)^)/7^)
    ECHO:!_REF!>>"%TEMP%\%~n0.csv"
    SET /A _StartOfset+=1
GOTO :EOF




    CALL GetDayOfYear DayOfYear %%Y-!_M!-!_D!
    CALL GetWeekOfYear WeekOfYear %%Y-!_M!-!_D!
    CALL getDayOfWeek DayOfWeek %%Y-!_M!-!_D!
    REM ECHO %%Y-!_M!-!_D!	!DayOfWeek!	!WeekOfYear!>>"%TEMP%\%~n0.csv"
    REM :: ISO;JD;DOY;DOW;
    REM ::ECHO:%%Y-!_M!-!_D!	=DATO(%%Y;!_M!;!_D!)+2415018,5	!DayOfYear!	!DayOfWeek!>>"%TEMP%\DATE.excel.ref.csv"
    REM :: ISO;                JD;                             DOY;                                DOW;                            Week no

    REM ::  =IF(OR(MOD(A1,400)=0,AND(MOD(A1,4)=0,MOD(A1,100)<>0)),"Skudår", "IKKE et skudår")
    REM ::ECHO:=DATO^(%%Y;%%M;%%D^)	=DATO^(%%Y;%%M;%%D^)+2415018,5	=DATO(2015;1;3)-DATO(2015;1;1)+1	=UGEdag^(DATO^(%%Y;%%M;%%D^)^)	=UGE.NR^(DATO^(%%Y;%%M;%%D^)^)>>"%TEMP%\%~n0.csv"
