@echo off
SETLOCAL EnableDelayedExpansion

set /P artist="Enter artist: "
set /P album="Enter album: "
set /P year="Enter year: "

if not exist "%album% (%year%)". mkdir "%album% (%year%)"

for %%f in (*.flac) do (
	set g=%%~nf
	flac -d -c "%%f" | lame -h -V4 -v --id3v2-only --tt "!g:~5!" --ta "%artist%" --tl "%album%" --ty "%year%" --tn "!g:~0,2!" --priority 0 - "%album% (%year%)\%%~nf.mp3"
)
