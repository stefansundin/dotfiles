@echo off

for %%f in (*.m4a *.aac) do (
	faad -w -f2 -d -s 44100 "%%f" | flac --sample-rate=44100 --endian=little --channels=2 --bps=16 --sign=signed --best -f -s -o "%%~nf.flac" -
)
