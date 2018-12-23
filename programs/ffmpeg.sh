# https://ffmpeg.org/ffmpeg-filters.html
# https://trac.ffmpeg.org/wiki/FilteringGuide
# https://trac.ffmpeg.org/wiki/AudioChannelManipulation

ffmpeg -i video.flv -acodec copy audio.mp3

# remove right audio channel
# https://trac.ffmpeg.org/wiki/AudioChannelManipulation
youtube-dl https://www.youtube.com/watch?v=xrIjfIjssLE
ffmpeg -i "Erlang - The Movie-xrIjfIjssLE.mp4" -map_channel 0.1.0 -c:v copy "Erlang - The Movie.mp4"

# concat files and trim start
ffmpeg -ss 1:38 -i MVI_0605.MOV -i MVI_0652.MOV -i MVI_0653.MOV -i MVI_0686.MOV -i MVI_0734.MOV -i MVI_0848.MOV -filter_complex "[0:0] [0:1] [1:0] [1:1] [2:0] [2:1] [3:0] [3:1] [4:0] [4:1] [5:0] [5:1] concat=n=6:v=1:a=1 [v] [a]" -map "[v]" -map "[a]" concat.mkv
# n=6 specifies the number of files. -filter_complex list must be modified when changing number of files.


# rip Apple HLS streams (.m3u8)
while true; do
 ffmpeg -i http://test.live.net.il/glz-a-zixief.m3u8 -c copy "infected-`date +%s`.mkv"
done
# to capture limited time, use -t 10

# example .m3u8 contents:
# #EXTM3U
# #EXT-X-VERSION:3
# #EXT-X-STREAM-INF:PROGRAM-ID=1,BANDWIDTH=113000
# glz-a-zixief/glz-a-zixief.m3u8?user=HTTP_Proxy_ny1lv4164_20730533&session=&hlsid=HLS_18879243

# fix mkv file after Ctrl-C
ffmpeg -i infected.mkv -c copy -bsf:a aac_adtstoasc infected2.mkv

# combine videos into mosaic
# audio from video 6 and 7 are used for left and right stereo channels
# note: use atrim to trim audio because -shortest doesn't work properly in this case (see https://trac.ffmpeg.org/ticket/3789)
ffmpeg \
    -i "recut1.wmv" -i "recut2.wmv" -i "recut3.wmv" -i "recut4.wmv" \
    -i "recut5.wmv" -i "recut6.wmv" -i "recut7.wmv" -i "recut8.wmv" \
    -i "recut9.wmv" -i "recut10.wmv" -i "recut11.wmv" -i "recut12.wmv" \
    -filter_complex "
        nullsrc=size=1920x1080 [base];
        [0:v] setpts=PTS-STARTPTS, scale=480x360 [a1];
        [1:v] setpts=PTS-STARTPTS, scale=480x360 [a2];
        [2:v] setpts=PTS-STARTPTS, scale=480x360 [a3];
        [3:v] setpts=PTS-STARTPTS, scale=480x360 [a4];
        [4:v] setpts=PTS-STARTPTS, scale=480x360 [b1];
        [5:v] setpts=PTS-STARTPTS, scale=480x360 [b2];
        [6:v] setpts=PTS-STARTPTS, scale=480x360 [b3];
        [7:v] setpts=PTS-STARTPTS, scale=480x360 [b4];
        [8:v] setpts=PTS-STARTPTS, scale=480x360 [c1];
        [9:v] setpts=PTS-STARTPTS, scale=480x360 [c2];
        [10:v] setpts=PTS-STARTPTS, scale=480x360 [c3];
        [11:v] setpts=PTS-STARTPTS, scale=480x360 [c4];
        [base][a1] overlay=shortest=1:x=0:y=0 [tmpa1];
        [tmpa1][a2] overlay=shortest=1:x=480:y=0 [tmpa2];
        [tmpa2][a3] overlay=shortest=1:x=960:y=0 [tmpa3];
        [tmpa3][a4] overlay=shortest=1:x=1440:y=0 [tmpa4];
        [tmpa4][b1] overlay=shortest=1:x=0:y=360 [tmpb1];
        [tmpb1][b2] overlay=shortest=1:x=480:y=360 [tmpb2];
        [tmpb2][b3] overlay=shortest=1:x=960:y=360 [tmpb3];
        [tmpb3][b4] overlay=shortest=1:x=1440:y=360 [tmpb4];
        [tmpb4][c1] overlay=shortest=1:x=0:y=720 [tmpc1];
        [tmpc1][c2] overlay=shortest=1:x=480:y=720 [tmpc2];
        [tmpc2][c3] overlay=shortest=1:x=960:y=720 [tmpc3];
        [tmpc3][c4] overlay=shortest=1:x=1440:y=720 [v];
        [5:a][6:a] amerge=inputs=2,pan=stereo|c0<c0+c1|c1<c2+c3,atrim=duration=90 [a]
    " -map "[v]" -map "[a]" \
    -shortest \
    -c:v libx264 mosaic.mkv

# the same as above, but using hstack and vstack
ffmpeg \
    -i "a1.mkv" -i "a2.mkv" -i "a3.mkv" -i "a4.mkv" \
    -i "b1.mkv" -i "b2.mkv" -i "b3.mkv" -i "b4.mkv" \
    -i "c1.mkv" -i "c2.mkv" -i "c3.mkv" -i "c4.mkv" \
    -filter_complex "
        [0:v][1:v][2:v][3:v] hstack=inputs=4 [a];
        [4:v][5:v][6:v][7:v] hstack=inputs=4 [b];
        [8:v][9:v][10:v][11:v] hstack=inputs=4 [c];
        [a][b][c] vstack=inputs=3 [video];
        [5:a] anull [audio]
    " -map "[video]" -map "[audio]" \
    -c:v libx264 mosaic.mkv

# from a single input file, cut out nine 4 minutes segments and assemble in a mosaic
ffmpeg \
    -i input.avi -filter_complex "
        [0:v] trim=420:duration=240,   setpts=PTS-STARTPTS, fifo [a1];
        [0:v] trim=840:duration=240,   setpts=PTS-STARTPTS, fifo [a2];
        [0:v] trim=1290:duration=240,  setpts=PTS-STARTPTS, fifo [a3];
        [0:v] trim=1800:duration=240,  setpts=PTS-STARTPTS, fifo [b1];
        [0:v] trim=2890:duration=240,  setpts=PTS-STARTPTS, fifo [b2];
        [0:a] atrim=2890:duration=240, asetpts=PTS-STARTPTS, afifo [audio];
        [0:v] trim=3000:duration=240,  setpts=PTS-STARTPTS, fifo [b3];
        [0:v] trim=4510:duration=240,  setpts=PTS-STARTPTS, fifo [c1];
        [0:v] trim=4740:duration=240,  setpts=PTS-STARTPTS, fifo [c2];
        [0:v] trim=5065:duration=240,  setpts=PTS-STARTPTS, fifo [c3];
        [a1][a2][a3] hstack=inputs=3 [a];
        [b1][b2][b3] hstack=inputs=3 [b];
        [c1][c2][c3] hstack=inputs=3 [c];
        [a][b][c] vstack=inputs=3 [video]
        " -map "[video]" -map "[audio]" \
    -c:v libx264 mosaic.mkv
