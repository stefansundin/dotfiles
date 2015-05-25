@echo off
SETLOCAL EnableDelayedExpansion

set /P artist="Enter artist: "
set /P album="Enter album: "
set /P year="Enter year: "

if not exist "%album% (%year%)". mkdir "%album% (%year%)"

for %%f in (*.flac) do (
	set g=%%~nf
	flac -d -c -s "%%f" | faac -o "%album% (%year%)\%%~nf.m4a" --artist "%artist%" --album "%album%" --year "%year%" --track "!g:~0,2!" --title "!g:~5!" -
)
