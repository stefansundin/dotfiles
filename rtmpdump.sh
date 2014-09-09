# rtmpsrv
sudo iptables -t nat -A OUTPUT -p tcp --dport 1935 -j REDIRECT
sudo rtmpsrv
# visit the streams you want, rtmpsrv will print appropriate rtmpdump commands
sudo iptables -t nat -D OUTPUT -p tcp --dport 1935 -j REDIRECT
# run all the rtmpdump commands

# rtmpsuck
sudo useradd rtmp
sudo iptables -t nat -A OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner rtmp  -j REDIRECT
sudo su rtmp
rtmpsuck
sudo iptables -t nat -D OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner rtmp  -j REDIRECT


# app: cfx/st
# flashVer: LNX 11,7,700,203
# swfUrl: http://static2.cdn.be-at.tv/Embed/v2.48.swf?site=true&p=351441&t=0&ap=1
# tcUrl: rtmp://media.cdn.be-at.tv/cfx/st
# pageUrl: http://www.be-at.tv/brands/global-gathering/global-gathering-2013-day-2
# Playpath: Session003131/Audio003811/128
# Saving as: 128
rtmpdump -a "app" -f "LNX 11,7,700,203" -W "swfUrl" -r "tcUrl" -p "pageUrl" -y "playpath" -o rtmp.flv -V

rtmpdump -a "cfx/st" -f "LNX 11,7,700,203" -W "http://static2.cdn.be-at.tv/Embed/v2.48.swf?site=true&p=351441&t=0&ap=1" -r "rtmp://media.cdn.be-at.tv/cfx/st" -p "http://www.be-at.tv/brands/global-gathering/global-gathering-2013-day-2" -y "Session003131/Audio003811/128" -o 128.flv -V
