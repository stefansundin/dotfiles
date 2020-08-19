# https://github.com/ytdl-org/youtube-dl/blob/master/README.md#options
youtube-dl [...]
youtube-dl -f bestvideo+bestaudio "$URL"

# https://streamlink.github.io/cli.html
streamlink --hls-live-restart -o video.mp4 https://www.youtube.com/watch?v=abc best

# streamlink + ffmpeg:
URL=$(streamlink --hls-live-restart --stream-url https://www.youtube.com/watch?v=YJWPcBYqmig best)
ffmpeg -i "$URL" -acodec copy -vcodec copy video.mp4
