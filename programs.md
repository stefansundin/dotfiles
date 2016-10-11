Userscripts:
- https://github.com/gantt/downloadyoutube/blob/master/script/yt.user.js
- https://github.com/stefansundin/youtube-copy-annotations/blob/gh-pages/youtube_auth_token.user.js
- https://gist.github.com/stefansundin/65e3d6db697636d8e7f1#file-youtube-global-shortcuts-user-js
- https://gist.github.com/stefansundin/f1e81a8f5281f6f4cac4#file-sourceforge-bigger-filename-column-user-js
- https://gist.github.com/stefansundin/f9df6c5e0fd184c60709#file-launchpad-download-count-user-js

Wireshark + Chrome/Firefox SSL:
> Open terminal and run:
> ```
> export SSLKEYLOGFILE=$HOME/sslkeylogfile
> # Start Firefox/Chrome from that terminal
> ```
> Start Wireshark, then put the same path in Preferences → Protocols → SSL → (Pre)-Master-Secret log filename.
> In Firefox, disable spdy and gzip in about:config because they are not supported in Wireshark (`network.http.spdy.enabled=false` and `network.http.accept-encoding=""`)

Chrome `--disable-web-security`:
- `"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" --disable-web-security`
- `open -a 'Google Chrome' --args --disable-web-security`

Chrome SOCKS:
> ```
> google-chrome --proxy-server="socks5://localhost:4045"
> ```

Chrome free up disk space after downloading from Mega:

1. Go to chrome://settings/cookies
2. Search for "mega".
3. Click on the mega.nz line, then choose _File System_.
4. Click _Remove_.

Firefox multiple profiles:
> ```
> firefox -P default -no-remote
> firefox -P infected -no-remote
> sudo vim /usr/share/applications/firefox.desktop
> ```
> ```
> Exec=firefox -P default -no-remote %u
> Actions=NewWindow;NewPrivateWindow;Infected
>
> [Desktop Action Infected]
> Name=Open infected session
> Exec=firefox -P infected -no-remote
> ```

Firefox Adblock remove Ctrl+Shift+V shortcut:
> 1. `about:config` → `extensions.adblockplus.sidebar_key`
> 1. Remove ~~`Accel Shift V,`~~
> 1. Restart Firefox

Firefox allow mixed content by default:
> `security.mixed_content.block_active_content = false`

Firefox corrupted text (old AMD cards only?):
> `gfx.content.azure.enabled = false`

Firefox black background (maybe hardware acceleration):
> Options → Advanced → General → `[ ] Use hardware acceleration when available`

Tor Browser open magnet links:
> `network.protocol-handler.external-default = true`

YouTube channel playlist:
> Add `&feature=mfu_in_order&list=UL`, e.g.
> ```
> https://www.youtube.com/watch?v=_xLnsbUviuk&feature=mfu_in_order&list=UL
> ```

Docker:
> ```
> docker kill $(docker ps -aq)
> docker rm $(docker ps -aq)
> docker rmi $(docker images | grep -v 'ubuntu\|redis' | awk {'print $3'})
> ```

NPM (comes with [Node.js](http://nodejs.org/download/)):
> ```
> npm install -g keybase-installer
> ```

Clipboard:
> - Mac: `pbcopy` / `pbpaste`
> - Windows: `clip` / [`clop`](https://gist.github.com/stefansundin/9d95826a712096b24ae2/raw/clop.exe) [[1](https://gist.github.com/stefansundin/9d95826a712096b24ae2)]
>  - Windows EOF: `^Z ENTER`
>  - Cygwin: `/dev/clipboard`
> - Linux: `xclip -selection c` / `xclip -selection c -o`
>  - `alias pbcopy="xclip -selection c"`
>  - `alias pbpaste="xclip -selection c -o"`
>
> Examples:
> ```
> gpg -aser dstokes | pbcopy
> echo "pipe to gpg" | gpg -aser dstokes | pbcopy
> keybase encrypt -s dstokes | pbcopy
> pbpaste | gpg -d
> pbpaste | keybase decrypt
> pbpaste | gpg -d && gpg -aser dstokes | pbcopy
> ```

pngcrush:
> ```
> pngcrush -rem gAMA -rem cHRM -rem iCCP -rem sRGB -brute
> pngcrush -rem gAMA -rem cHRM -rem iCCP -rem sRGB -brute -d crushed *.png
> ```

PuTTY:
> Color terminal string:
>> Connection → Data → Terminal-type string: `xterm-color`
>
> SOCKS:
>> Connection → SSH → Tunnels → Source port: `4000` → `(x) Dynamic` → `Add`

uTorrent ads:
> ```
> offers.left_rail_offer_enabled = false
> offers.sponsored_torrent_offer_enabled = false
> gui.show_plus_upsell = false
> gui.show_notorrents_node = false
> bt.enable_pulse = false
> ```
> 
> Options →
> - [ ] `Show Sidebar [F7]`
> - [ ] `Show Bundles [F8]`
> - [ ] `Show Devices`
>
> Restart to remove yellow bar.

DVD:
> - RipBot264 rips to .mp4 and .mkv.
> - Handbrake has defaults for devices (e.g. iPod). Use DVD Decrypter first if DVD is encrypted.
> - Use DVD Decrypter to remove multiple angles in beforehand.
> - Use [ChapterGrabber](http://chapterdb.org/software) to extract DVD chapters.

VLC midi:
> Download [fluidsynth soundfont](http://ftp.us.debian.org/debian/pool/main/f/fluid-soundfont/fluid-soundfont-gm_3.1-5_all.deb).
> Extract `FluidR3_GM.sf2`.
> Go to VLC preferences, advanced mode, Inputs / Codecs → Audio codecs → FluidSynth and browse for `FluidR3_GM.sf2`.

Git over ssh on server:
> Requires git to be installed on server. SCP syntax automatically uses user's home directory as default, `ssh://` syntax does not.
> ```
> sudo apt-get install git
> git clone stefan@example.com:altdrag.git
> ```

Pipe decode FLAC and encode MP3:
> ```
> flac -c -d track.flac | lame -h -V 4 - track.mp3
> ```

Rip Adobe HDS streams (`.f4m`):
> ```
> wget https://raw.githubusercontent.com/K-S-V/Scripts/master/AdobeHDS.php
> php AdobeHDS.php --delete --manifest "http://ynethd-f.akamaihd.net/z/0214/170214_ulpan_dag_and_infected_768Kbps_360p.mp4/manifest.f4m?g=JBQPFZYYQDVJ&hdcore=3.0.3"
> ```

Spotify Proxy Login:
> Unplug ethernet cable / disable internet connection to enable proxy login.

MPC-HC takes ages to start (NVIDIA):
> Go to `C:\Program Files (x86)\NVIDIA Corporation` and rename `3D Vision` directory. It loads some shit even if you haven't opted in.
