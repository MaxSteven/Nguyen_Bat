@echo off
REM Get lastest modified source file
setlocal enableextensions enabledelayedexpansion

set RVpath="E:\rv-win64-x86-64-7.3.1\bin\"
set CHECKQTpath=N:\RCPS\Check\CP\CheckData\Shot
::set CHECKQTpath=E:\TEST
set EP=102
set "lastestMOV="

CALL :Padding_Number %EP%
set "n=00%EP%"
set "EP=!n:~-3!"
::ECHO EP = !EP!

:Padding_Number

for /d /r "%CHECKQTpath%\e%EP%\" %%i in (*) do (
    @if exist "%%i" (
        ( @echo "%%i" | FIND /I ".sgmedia" 1>NUL) || (
            @set ALLCUTS=%%i
            @echo !ALLCUTS!

            for /f "delims=" %%a in ('dir /b /od /t:w "!ALLCUTS!\*.mov" 2^>nul') do (
                set "lastestMOV=%%a"
            )
            echo Newest File is !lastestMOV!

            REM  Change directory to RV folder
            CD /d %RVpath%

            REM  Start adding source to RV
            rvpush -tag NguyenRV merge [ !ALLCUTS!\!lastestMOV! ]
        )
   )
)

endlocal



:: rv -help
:: rvpush url 'rvlink:// -reuse 1 N:\RCP\Check\CP\CheckQT\e03\c001E\e03_c001E_H_t01_02.mov'


:: Get the lastest mov in each sub-folders
::This trick works by asking the dir command
::to list just the names (/b)
::of just the files /a-d
::sorted by date (/od)
::based on the creation time (/t:c)
::for a reverse sort (/o-d)
::file sorted by modified time rather than creation time, then use /t:w
