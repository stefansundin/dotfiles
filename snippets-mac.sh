# press ⌘⇧. (Cmd+Shift+.) to show dotfiles in Open/Save dialogs
# press ⌘^Space (Cmd+Ctrl+Space) to show the emoji keyboard

# remove quarantine flag from executables
sudo xattr -d -r com.apple.quarantine /Applications

# delete ._* files from sd card
dot_clean -m /Volumes/noname/

# Docker For Mac
screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty

# launch screensaver
/System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine

# launch screensaver from AppleScript
do shell script "/System/Library/CoreServices/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine"

# convert plist to XML
plutil -convert xml1 -o - org.TrueCryptFoundation.TrueCrypt.plist

# see what architectures a binary works with:
lipo -archs /Applications/VLC.app/Contents/MacOS/VLC

# see the minimum macOS version a binary was compiled for:
otool -l /Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt
# look for LC_VERSION_MIN_MACOSX:
otool -arch x86_64 -l /Applications/VLC-protocol.app/Contents/MacOS/vlc-protocol
# look for LC_BUILD_VERSION:
otool -arch arm64 -l /Applications/VLC-protocol.app/Contents/MacOS/vlc-protocol

# check who signed an application bundle:
codesign -dv --verbose=4 /Applications/VLC.app

# hide desktop icons:
defaults write com.apple.finder CreateDesktop false
killall Finder
# restore:
defaults write com.apple.finder CreateDesktop true
killall Finder
