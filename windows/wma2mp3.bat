for %%f in (*.wma) do ffmpeg -i "%%f" -vn -f wav - | lame -h - "%%~nf.mp3"
