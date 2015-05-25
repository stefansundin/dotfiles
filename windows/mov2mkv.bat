for %%f in (*.mov) do ffmpeg -i "%%f" "%%~nf.mkv"
