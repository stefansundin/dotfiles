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
