alias yt=yt-dlp

# https://github.com/yt-dlp/yt-dlp/blob/master/README.md#usage-and-options
yt -f bestvideo+bestaudio "$URL"

# embed subtitles
yt --remux-video mkv --embed-info-json --embed-subs https://www.youtube.com/watch?v=
# extract audio and embed subtitles
yt -x --remux-video mka --embed-info-json --embed-subs https://www.youtube.com/watch?v=

# https://streamlink.github.io/cli.html
streamlink --hls-live-restart -o video.mp4 https://www.youtube.com/watch?v=abc best

# streamlink + ffmpeg:
URL=$(streamlink --hls-live-restart --stream-url https://www.youtube.com/watch?v=YJWPcBYqmig best)
ffmpeg -i "$URL" -acodec copy -vcodec copy video.mp4


yt -f bestvideo+bestaudio "https://www.youtube.com/watch?v=ICEP0qMczdg"

URL=$(streamlink --hls-live-restart --stream-url https://www.youtube.com/watch?v=ICEP0qMczdg best)
ffmpeg -i "$URL" -acodec copy -vcodec copy video.mp4


streamlink -o streamlink.mp4 https://www.twitch.tv/monstercat best
