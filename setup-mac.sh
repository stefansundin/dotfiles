brew install readline openssl@1.1 jemalloc
brew install rbenv ruby-build rbenv-gem-rehash rbenv-binstubs
rbenv install 2.6.0
rbenv global 2.6.0

ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
ln -s "/Applications/Sublime Merge.app/Contents/SharedSupport/bin/smerge" /usr/local/bin/smerge
ln -s "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" /usr/local/bin/code
ln -s /Applications/TrueCrypt.app/Contents/MacOS/TrueCrypt /usr/local/bin/truecrypt
ln -s /Applications/Gimp.app/Contents/MacOS/gimp-2.8 /usr/local/bin/gimp
ln -s /Applications/VLC.app/Contents/MacOS/VLC /usr/local/bin/vlc
# ln -s /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome /usr/local/bin/google-chrome
# alias google-chrome='/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'

sudo xattr -d -r com.apple.quarantine /Applications
grep -nr paginator .
find . -name "*.css" | xargs -l10 grep ".ir"

# flush DNS
dscacheutil -flushcache && sudo killall -HUP mDNSResponder

# path of PID
ps xuwww -p <PID>

# convert tiff files to png
for f in *.tiff; do sips -s format png "$f" --out "${f%.*}.png"; done


# brew multi-user setup
sudo dseditgroup -o create brew
sudo dseditgroup -o edit -a stefansundin -t user brew
sudo dseditgroup -o edit -a home -t user brew
sudo chgrp -R brew /usr/local /Library/Caches/Homebrew
sudo chmod -R g+w /usr/local /Library/Caches/Homebrew
sudo chmod -R +a "brew allow list,search,add_file,add_subdirectory,delete_child,readattr,writeattr,readextattr,writeextattr,readsecurity,file_inherit,directory_inherit" /usr/local /Library/Caches/Homebrew

# if 'brew doctor' complains that locale files aren't writable
sudo chown -R stefansundin /usr/local /Library/Caches/Homebrew
sudo chmod -R g+w /usr/local /Library/Caches/Homebrew
cp /usr/local/Library/LinkedKegs/redis/homebrew.mxcl.redis.plist ~/Library/LaunchAgents/homebrew.mxcl.redis.plist

# change shells
brew install bash
# add to /etc/shells:
/usr/local/bin/bash
/usr/local/bin/zsh
# then use:
chsh -s /usr/local/bin/bash

# turn off notification bubble for System Preferences
defaults write com.apple.systempreferences AttentionPrefBundleIDs 0

# keyboard key-repeat
defaults write -g ApplePressAndHoldEnabled -bool false
defaults read -g ApplePressAndHoldEnabled

# fix Home/End on full-size keyboards
mkdir ~/Library/KeyBindings/
vim ~/Library/KeyBindings/DefaultKeyBinding.dict
{
    "\UF729"  = "moveToBeginningOfLine:";                   /* Home */
    "\UF72B"  = "moveToEndOfLine:";                         /* End  */
    "$\UF729" = "moveToBeginningOfLineAndModifySelection:"; /* Shift + Home */
    "$\UF72B" = "moveToEndOfLineAndModifySelection:";       /* Shift + End  */
    /* Stop Mac from beeping when pressing Ctrl+Cmd+Down */
    /* https://github.com/atom/atom/issues/1669#issuecomment-135503562 */
    "^@\UF701" = "noop:";
    "^@\UF702" = "noop:";
    "^@\UF703" = "noop:";
}


# NSUserKeyEquivalents
# @    Command (Apple)  CMD
# ~    Option           OPT
# $    Shift            SHIFT
# ^    Control          CTRL

# this will print an error if there's a problem with Xcode
xcodebuild -version
# install Xcode command line tools
xcode-select --install
# accept Xcode EULA
sudo xcodebuild -license

# enable "Anywhere" option for Gatekeeper ("Allow apps downloaded from" in "Security & Privacy" settings)
sudo spctl --master-disable
# prevent Gatekeeper from re-enabling itself after 30 days ("Allow apps downloaded from" in "Security & Privacy")
sudo defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool false
# disable “VLC.app is an application downloaded from the Internet. Are you sure you want to open it?”
sudo defaults delete com.apple.LaunchServices LSQuarantine
defaults write com.apple.LaunchServices LSQuarantine -bool false
sudo xattr -d -r com.apple.quarantine /Applications
# set hostname
sudo scutil --set HostName sundin
# disable Adobe Creative Cloud from starting on startup
launchctl unload -w /Library/LaunchAgents/com.adobe.AdobeCreativeCloud.plist
# put note on login/lock screen
sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText "If lost, please call XXX-XXX-XXXX."
# Finder.app
# preferences (⌘,)
#  General → New Finder windows show: stefansundin
#  Advanced → [x] Show all filename extensions
# show the ~/Library directory
chflags nohidden ~/Library
# show dotfiles
defaults write com.apple.finder AppleShowAllFiles -bool true
# don't warn when renaming file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# don't create .DS_Store on network drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# sort by Kind by default
#  show view options (⌘J) → Sort By: Kind. [Use as Defaults]
#  remove .DS_Store files to remove custom directory settings
# QuickLook plugins
brew cask install qlstephen qlmarkdown qlprettypatch qlimagesize qlcolorcode quicknfo betterzipql suspicious-package quicklook-json quicklook-csv
qlmanage -r
https://github.com/whomwah/qlstephen
## Note: Don't enable text selection in QuickLook as that will cause blank images to be shown in quicklook when going back and forth between images!
# sort Folders on top
cd /System/Library/CoreServices/Finder.app/Contents/Resources/English.lproj/
sudo plutil -convert xml1 InfoPlist.strings
sudo vim InfoPlist.strings
 <key>Folder</key>
 <string> Folder</string>
sudo plutil -convert binary1 InfoPlist.strings
## backspace to go up, delete key to move files to trash
defaults write com.apple.finder NSUserKeyEquivalents -dict-add 'Back' '\U232B'
defaults write com.apple.finder NSUserKeyEquivalents -dict-add 'Move to Trash' '\U007F'
## WARNING: DELETE KEY WILL NOW DELETE FILES AND FOLDERS IF YOU ARE ATTEMPTING TO RENAME THEM!! USE BACKSPACE!
defaults read com.apple.finder NSUserKeyEquivalents
killall Finder

# add 'Open with VLC' to Finder right-click list
# - Open Automator
# - Create new Service
# - Service receives selected: [files or folders] in [Finder.app]
# - Action: Open Finder Items
#   - Open with: [VLC.app]
# - Save service as: Open with VLC

# alternative method
# - Open Automator
# - Create new Quick Action
# - Workflow receives selected: [files or folders] in [Finder.app]
# - Image: Play
# - Action: Open Finder Items
#   - Open with: [VLC.app]
# - Save service as: Open with VLC

# disable fullscreen swoosh
defaults write -g NSWindowResizeTime -float 0.01
defaults read -g NSWindowResizeTime

# disable two-finger back/forward navigation in Chrome only
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
# disable dark mode in Chrome only
defaults write com.google.Chrome NSRequiresAquaSystemAppearance -bool true

# disable bonjour advertising
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool true

# Calendar.app: ignore alerts from specific calendars
# Right-click calendar → Get Info → [x] Ignore alerts

# Terminal.app Home/End keys
# preferences (⌘,) → Profiles → Keyboard
# [+] → Key: [↖ Home] → Modifier: [None] → Action: [Send Text:] <Ctrl-a>
# [+] → Key: [↘ End]  → Modifier: [None] → Action: [Send Text:] <Ctrl-e>

# disable iTunes automatically copying files to iTunes directory
# iTunes → Preferences → Advanced → [ ] Copy files to iTunes Music folder when adding to library

# system shortcuts
# Mission Control: F3
# Application windows: ⇧F3
# Tip: Drag a window when pressing ^← and ^→ to move that window too.

# remove dashboard
# System Preferences → Mission Control
# [ ] Show Dashboard as a Space
# Show Dashboard: [ - ]

# enable SSH server
# System Settings → Sharing → [x] Remote Login

# share files between Mac and PC
# System Settings → Network → Advanced → WINS
# Workgroup: WORKGROUP
# System Settings → Sharing → [x] File Sharing → Options
# [x] Share files and folders using SMB (Windows)

# mute startup chime (does not work every time)
sudo nvram SystemAudioVolume=%80
sudo vim /etc/rc.common
 # mute startup chime
 nvram SystemAudioVolume=%80
# re-enable
sudo nvram -d SystemAudioVolume
# print setting
nvram -p | grep SystemAudioVolume

# show advanced printer settings
cupsctl WebInterface=yes
# http://localhost:631/

# hidden startup items
# (/System)/Library/Launch{Agents,Daemons}
# /Library/StartupItems

# upgrade Postgres.app
# first stop the postgres server and kill all connections
powder stop
# then rename the old Postgres.app, copy over the new one, and copy the old binaries which are needed for the upgrade
cd /Applications
mv Postgres.app Postgres-9.3.app
# move over new Postgres.app
cp -r Postgres-9.3.app/Contents/Versions/9.3 Postgres.app/Contents/Versions/
# now update your PATH to use 9.4 and restart terminal
cd "$HOME/Library/Application Support/Postgres"
mkdir var-9.4
# if var-9.4 already exists, rename it (you may delete it later)
initdb var-9.4 -E utf8
pg_upgrade -d var-9.3 -D var-9.4 -b /Applications/Postgres.app/Contents/Versions/9.3/bin/ -B /Applications/Postgres.app/Contents/Versions/9.4/bin/ -v
# delete old files after verifying new database works
rm -rf var-9.3

# iTerm 2 key bindings
# add Profile shortcuts since they have highest priority

# Key Combination | Action               | Key
# --------------- | -------------------- | ------
# ⌥←              | Send Escape Sequence | Esc+ b
# ⌥→              | Send Escape Sequence | Esc+ f
# ⌥Del→           | Send Escape Sequence | Esc+ d
# ⌥←Delete        | Send Hex Code        | 0x1b 0x08
# ⌘←Delete        | Send Hex Code        | 0x15
# Del→            | Send Hex Code        | 0x04

# iTerm 2 Smart Selection
# Regular expression: story #(\d+)
# Action: Open URL...
# Parameter: https://www.pivotaltracker.com/story/show/\1

# use `read` to get keyboard input sequences. Press C-v to bypass terminal parsing (verbatim mode).


# additional apps
# SteerMouse: http://plentycom.jp/en/steermouse/
# FinderPath: http://bahoom.com/finderpath/
# MagicPrefs to customize Apple mice
# USB Overdrive
#  Button 4/5:
#  → Press Key: Command+[ / Command+]
#  → Note: Using 'Keyboard Shortcut' and Back/Forward does not work when text fields are selected!
#  Wheel up/down
#  → Direction: [down/up]
#  → Speed: [5 lines]
# MacUtil: https://russellsayshi.com/MacUtil/home
# iStat Menus
# CheatSheet
# Android:
#  File Transfer: https://www.android.com/filetransfer/
#  HoRNDIS (USB Tethering): https://joshuawise.com/horndis
# prevent local .DS_Store files: https://asepsis.binaryage.com/#installation


# global SteamApps
mv Library/Application\ Support/Steam/SteamApps/ /Library/
rm -r Library/Application\ Support/Steam/SteamApps/
ln -s /Library/SteamApps Library/Application\ Support/Steam/

# wireshark permissions
sudo dseditgroup -o edit -a stefansundin -t user access_bpf
sudo dseditgroup -o edit -a home -t user access_bpf


# file extension associations
# http://duti.org/
brew install duti
# get current associations
open ~/Library/Preferences/com.apple.LaunchServices.plist
# only LSHandlerContentType can be used
for type in public.mpeg-4 public.avi public.mp3 public.mp2 com.apple.quicktime-movie com.microsoft.waveform-audio com.apple.m4a-audio; do duti -s org.videolan.vlc $type all; done
for type in conf ini public.plain-text public.m3u-playlist public.php-script public.shell-script public.ruby-script public.xml com.apple.log public.comma-separated-values-text com.netscape.javascript-source net.daringfireball.markdown com.barebones.bbedit.ini-configuration; do duti -s com.sublimetext.3 $type all; done
duti -s com.adobe.reader com.adobe.pdf all
duti -s com.googlecode.iTerm2 com.apple.terminal.shell-script shell


# uninstall heroku toolbelt
gem uninstall heroku -a -x --force
brew uninstall heroku
sudo rm -rf /usr/local/heroku /usr/bin/heroku
# remove heroku from PATH in .profile, .bashrc or .bash_profile
