mkdir -p ~/.local/share/vlc/lua/playlist/
mkdir -p ~/.local/share/vlc/lua/extensions/

# update youtube.lua
curl -L -o ~/.local/share/vlc/lua/playlist/youtube.lua https://github.com/videolan/vlc/raw/master/share/lua/playlist/youtube.lua
# update youtube.lua on macOS
curl -L -o "$HOME/Library/Application Support/org.videolan.vlc/lua/playlist/youtube.lua" https://github.com/videolan/vlc/raw/master/share/lua/playlist/youtube.lua

# install twitch.lua - https://addons.videolan.org/p/1167220/
curl -o ~/.local/share/vlc/lua/playlist/twitch.lua https://gist.githubusercontent.com/stefansundin/c200324149bb00001fef5a252a120fc2/raw/twitch.lua
curl -o ~/.local/share/vlc/lua/extensions/twitch-extension.lua https://gist.githubusercontent.com/stefansundin/c200324149bb00001fef5a252a120fc2/raw/twitch-extension.lua

# install vlc-protocol - https://github.com/stefansundin/vlc-protocol
sudo curl -L -o /usr/local/bin/vlc-protocol https://github.com/stefansundin/vlc-protocol/raw/master/linux/vlc-protocol
sudo chmod +x /usr/local/bin/vlc-protocol
curl -L -o vlc-protocol.desktop https://github.com/stefansundin/vlc-protocol/raw/master/linux/vlc-protocol.desktop
xdg-desktop-menu install vlc-protocol.desktop
rm vlc-protocol.desktop

# install "Open with VLC" browser extension:
# https://github.com/stefansundin/open-with-vlc
# https://chrome.google.com/webstore/detail/open-with-vlc/jcccmhdgkfinhddlhpahoeofmdlljglh
