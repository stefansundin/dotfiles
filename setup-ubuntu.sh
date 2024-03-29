# Terminal emulators: gnome-terminal, terminator, yakuake, guake, tilda, mrxvt
# http://askubuntu.com/questions/30334/what-application-indicators-are-available/

sudo apt-get install vim curl synaptic apt-transport-https

sudo apt-get install ssh vlc git filezilla rar gimp gparted uptimed pngcrush exfat-fuse exfat-utils gnome-font-viewer
sudo apt-get install indicator-cpufreq ghex flac lm-sensors rtmpdump deluge xchat mplayer ubuntu-restricted-extras
sudo apt-get install *wallpapers

# rbenv dependencies
sudo apt-get install libreadline-dev libxml2-dev libxslt1-dev libpq-dev libsqlite3-dev libssl-dev

# flux equivalent
sudo apt-get install redshift-gtk

# make vim the default editor (select vim.basic)
sudo update-alternatives --set editor /usr/bin/vim.basic
# some tools use select-editor (saves to ~/.selected_editor)
select-editor
sudo -H select-editor

# disable sleep/suspend/hibernate
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

# disable clearing of tty on logout
rm ~/.bash_logout

# disable clearing of boot log
sudo systemctl edit getty@tty1
# write the following:
[Service]
TTYVTDisallocate=no
# remove quiet and splash from boot options
sudo vim /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT=""
sudo update-grub

# increase scrollback buffer
sudo vim /etc/default/grub
GRUB_CMDLINE_LINUX="fbcon=scrollback:1024k"
sudo update-grub

# disable X at boot
sudo vim /etc/default/grub
GRUB_CMDLINE_LINUX_DEFAULT="text"
GRUB_TERMINAL=console
sudo update-grub
vim startx.sh
sudo service lightdm start
chmod +x startx.sh

# make grub menu visible
sudo vim /etc/default/grub
# comment out GRUB_HIDDEN_TIMEOUT
sudo update-grub

# increase max number of inotify watchers
$ sysctl fs.inotify.max_user_watches
fs.inotify.max_user_watches = 8192
$ echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

# disable system error popups
sudo vim /etc/default/apport
enabled=0
sudo rm /var/crash/*

# disable whoopsie (Ubuntu Error Reporting) on server
sudo vim /etc/default/whoopsie
  report_crashes=false
sudo service whoopsie stop

# fix sound crackling after not playing any sound for a while
echo 0 | sudo tee /sys/module/snd_hda_intel/parameters/power_save
# permanently
cat << 'EOF' | sudo tee /etc/rc.local
#!/bin/bash
echo 0 > /sys/module/snd_hda_intel/parameters/power_save
exit 0
EOF
sudo chmod +x /etc/rc.local

# remove annoying volume change popping sound
find /usr/share/sounds/ -type f -name audio-volume-change.oga | sudo xargs rm

# use Alt key to drag windows
gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier '<Alt>'

# add back minimize and maximize buttons to window controls
gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'

# minimize when clicking open dash icons
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

# disable lightdm sound
gsettings set com.canonical.unity-greeter play-ready-sound "false"
# old: sudo mv /usr/share/sounds/ubuntu/stereo/dialog-question.ogg{,-disabled}

# move launcher to bottom
gsettings set com.canonical.Unity.Launcher launcher-position Bottom

# disable remote search lenses
# start "Privacy" and disable "Include online search results" in "Search" tab.
gsettings set com.canonical.Unity.Lenses disabled-scopes \
  "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope',
  'more_suggestions-populartracks.scope', 'music-musicstore.scope',
  'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope',
  'more_suggestions-skimlinks.scope']"

# use DSLR as webcam
sudo apt-get install gphoto2 v4l2loopback-utils v4l2loopback-dkms ffmpeg
gphoto2 --auto-detect --summary --abilities
sudo modprobe v4l2loopback exclusive_caps=1 max_buffers=2
# start webcam (it should appear automatically in applications -- use VLC to test, Media -> Open Capture Device -> /dev/video0)
gphoto2 --stdout --capture-movie | ffmpeg -c:v mjpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0
# automate modprobe
cat << EOF | sudo tee /etc/modprobe.d/dslr-webcam.conf
alias dslr-webcam v4l2loopback
options v4l2loopback exclusive_caps=1 max_buffers=2
EOF
echo dslr-webcam | sudo tee -a /etc/modules

# install apt version of Software Store
sudo snap remove snap-store
sudo apt-get install --no-install-recommends gnome-software
# remove snap packages from Ubuntu Software (can still install with `snap install ...`)
sudo apt-get remove gnome-software-plugin-snap
f
# vscodium
sudo apt-get install apt-transport-https curl gpg
curl -s https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/vscodium-archive-keyring.gpg > /dev/null
echo 'deb [signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg] https://download.vscodium.com/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list
sudo apt-get update
sudo apt-get install codium

# vscode
sudo apt-get install apt-transport-https curl gpg
curl -s https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/packages.microsoft.gpg > /dev/null
echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list
sudo apt-get update
sudo apt-get install code

# Sublime Text - https://www.sublimetext.com/docs/3/linux_repositories.html
# Sublime Merge - https://www.sublimemerge.com/docs/linux_repositories
sudo apt-get install apt-transport-https curl gpg
curl -s https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/sublimehq-archive.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/sublimehq-archive.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text sublime-merge

# Git
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install git

# syncthing - https://apt.syncthing.net/
sudo curl -s -o /usr/share/keyrings/syncthing-archive-keyring.gpg https://syncthing.net/release-key.gpg
echo "deb [signed-by=/usr/share/keyrings/syncthing-archive-keyring.gpg] https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
sudo apt-get update
sudo apt-get install syncthing
systemctl --user enable syncthing.service
systemctl --user start syncthing.service
# WebUI: http://127.0.0.1:8384/

# Resilio Sync - https://help.resilio.com/hc/en-us/articles/206178924
wget -O- https://linux-packages.resilio.com/resilio-sync/key.asc | sudo apt-key add -
echo "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free" | sudo tee /etc/apt/sources.list.d/resilio-sync.list
sudo apt-get update
sudo apt-get install resilio-sync
# post install - https://help.resilio.com/hc/en-us/articles/206178924-Installing-Sync-package-on-Linux
# WebUI: http://localhost:8888/gui/
# user install:
sudo systemctl stop resilio-sync.service
sudo systemctl disable resilio-sync.service
sudo sed -i 's/WantedBy=multi-user.target/WantedBy=default.target/g' /usr/lib/systemd/user/resilio-sync.service
sudo systemctl daemon-reload
systemctl --user enable resilio-sync
systemctl --user start resilio-sync
# system install:
sudo usermod -a -G rslsync stefan

# https://mpv.io/installation/
sudo add-apt-repository ppa:mc3man/mpv-tests
sudo apt-get install mpv

# Slack - After installing deb from https://slack.com/downloads/linux, it creates /etc/cron.daily/slack which will set up this apt repository
wget -O- https://packagecloud.io/slacktechnologies/slack/gpgkey | sudo apt-key add -
echo "deb https://packagecloud.io/slacktechnologies/slack/debian/ jessie main" | sudo tee /etc/apt/sources.list.d/slack.list
sudo apt-get update
sudo apt-get install slack-desktop

# Flirc - https://flirc.tv/ubuntu-software-installation-guide
sudo apt-get install apt-transport-https
echo "deb [trusted=yes] https://apt.fury.io/flirc/ /" | sudo tee /etc/apt/sources.list.d/flirc_fury.list
sudo apt-get update
sudo apt-get install flirc

# Yubikey
sudo add-apt-repository ppa:yubico/stable
sudo apt-get update
sudo apt-get install yubikey-neo-manager yubikey-personalization-gui yubikey-piv-manager

# Tor browser
sudo add-apt-repository ppa:webupd8team/tor-browser
sudo apt-get update
sudo apt-get install tor-browser

# unetbootin
sudo add-apt-repository ppa:gezakovacs/ppa
sudo apt-get update
sudo apt-get install unetbootin

# Dolphin-emu
sudo add-apt-repository ppa:dolphin-emu/ppa
sudo apt-get update
sudo apt-get install dolphin-emu-master

# nginx
sudo add-apt-repository ppa:nginx/stable

# Amazon Prime Video
sudo add-apt-repository ppa:mjblenner/ppa-hal
sudo apt-get update
sudo apt-get install hal
# Does NOT work in Chrome, use Firefox.

# official nvidia drivers
sudo apt-get purge nvidia*
sudo apt-get autoremove
sudo systemctl stop lightdm.service
# Ubuntu 16.04 + NVIDIA-Linux-x86_64-364.19.run
# after the installer creates /etc/modprobe.d/nvidia-installer-disable-nouveau.conf
# run this:
sudo update-initramfs -u
# then reboot and run the installer again
# to uninstall, rerun installer with --uninstall
# you should uninstall before upgrading Ubuntu!!!!!
# add more options to control panel:
sudo nvidia-xconfig --cool-bits=4

# install Adobe Reader
# download .bin file from http://get.adobe.com/reader/
sudo apt-get install ia32-libs
cd Downloads
chmod +x AdbeRdr9.5.5-1_i486linux_enu.bin
sudo ./AdbeRdr9.5.5-1_i486linux_enu.bin

# uninstall kernel headers
sudo apt-get remove linux-headers-generic
sudo apt-mark manual linux-image-generic

# update to mainline kernel
# https://wiki.ubuntu.com/Kernel/MainlineBuilds

# brightness control in systray
sudo add-apt-repository ppa:indicator-brightness/ppa
sudo apt-get update
sudo apt-get install indicator-brightness
# then start "Brightness Indicator"

# install caffeine to disable screensaver
sudo add-apt-repository ppa:caffeine-developers/ppa
sudo apt-get update
sudo apt-get install caffeine
# start "Caffeine", go to Preferences and check 'Start Caffeine on login', 'Activate for Flash video' and 'Activate for Quake Live'.

# indicator with system info
sudo add-apt-repository ppa:alexeftimie/ppa
sudo apt-get update
sudo apt-get install indicator-sysmonitor
# cpu: {cpu} mem: {mem} swap: {swap}

# create wireless access point
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt-get update
sudo apt-get install ap-hotspot
sudo ap-hotspot start
sudo ap-hotspot configure
sudo vim /etc/rc.local
(sleep 10 && ap-hotspot start)&

# LaTeX: install native TeXLive with installer from website
wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
tar xzf install-tl-unx.tar.gz
cd install-tl-20221101
sudo mkdir -p /usr/local/texlive
sudo chown $USER:$USER /usr/local/texlive
# launch installer: (change scheme to "small scheme" for much faster install)
./install-tl
# add to /etc/profile or ~/.bashrc: (update year first)
PATH="/usr/local/texlive/2022/bin/x86_64-linux:$PATH"
MANPATH="/usr/local/texlive/2022/texmf-dist/doc/man"
INFOPATH="/usr/local/texlive/2022/texmf-dist/doc/info"
# log out and back in
# install packages:
tlmgr install moderncv
# compile tex:
xelatex cv.tex

# setup wireshark for normal users
sudo apt-get install wireshark
sudo dpkg-reconfigure wireshark-common
# select <Yes>
sudo usermod -a -G wireshark stefan
# log out and in

# mount LVM volumes
sudo apt-get install lvm2
sudo modprobe dm-mod
sudo vgchange -a y

# purge PPA
sudo apt-get install ppa-purge
sudo ppa-purge ppa:webupd8team/sublime-text-2
sudo apt-get autoremove

# touchpad
# setup two-finger scroll in mouse settings, check "Content sticks to fingers".
# enable two-finger horizontal scroll:
dconf write /org/gnome/settings-daemon/peripherals/touchpad/horiz-scroll-enabled true
# enable three-finger middle click by adding this to Startup Applications:
#   Name: Three-finger middle click
#   Command: sh -c "/usr/bin/synclient TapButton3=2"
# to make it work after sleep and resume, use this:
sudo vim /etc/pm/sleep.d/80-synaptics-three-finger
#!/bin/sh
# Restore three finger middle click tapping
case "$1" in
    resume|thaw)
        sleep 5;
        /bin/su stefan -c "/usr/bin/synclient TapButton3=2"
        ;;
esac
sudo chmod +x /etc/pm/sleep.d/80-synaptics-three-finger

# bluetooth device name
sudo vim /etc/machine-info
PRETTY_HOSTNAME=pixel

# Xubuntu File Manager (Thunar) right click entries:
- Edit → Configure custom actions... → Add
- Name: Open with VLC
- Command: vlc %F
- Appearance Conditions: [x] Directories, [x] Audio Files, [x] Video Files

# make Nautilus ask when double-clicking executables
Menu → Files → Preferences → Behavior → [x] Ask each time

# nautilus backspace key to go up one directory
vim .config/nautilus/accels
(gtk_accel_path "<Actions>/ShellActions/Up" "BackSpace")
killall nautilus

# firefox backspace key to go back in history
about:config
browser.backspace_action = 0

# make Chrome open magnet links
xdg-mime default deluge.desktop x-scheme-handler/magnet
xdg-mime default qBittorrent.desktop x-scheme-handler/magnet

# make Ctrl+Alt+L also turn off the screen
# disable the ordinary 'Lock screen' shortcut in the System category.
# create a new custom shortcut:
#   Name: Lock screen
#   Command: bash -c "gnome-screensaver-command --lock; xset dpms force off"
#   Shortcut: Ctrl+Alt+L

# disable automatic browsing on automount
gsettings set org.gnome.desktop.media-handling automount-open false

# synaptic without password prompt (first add to sudoers)
sudo vim /usr/share/applications/synaptic.desktop
Exec=sudo synaptic
Software center:
sudo vim /usr/share/polkit-1/actions/org.debian.apt.policy
<action id="org.debian.apt.install-or-remove-packages">
…
<allow_any>yes</allow_any>
<allow_inactive>yes</allow_inactive>
<allow_active>yes</allow_active>

# default CPU governor
sudo apt-get install gnome-applets
# Add to Startup Applications:
#   Name: CPU governor
#   Command: cpufreq-selector -g conservative

# Apple Magic Mouse
sudo apt-get install blueman
# pair using PIN 0000
vim fix-magic-mouse.sh
xinput set-float-prop "Stefan Sundin’s Mouse" "Device Accel Constant Deceleration" 1.5
xinput set-button-map "Stefan Sundin’s Mouse" 1 2 3 5 4 7 6
chmod +x fix-magic-mouse.sh

# start xkill from TTY
xkill -display :0
# print list of X displays:
w

# Android Studio
sudo apt-get update
objdump -x android-studio/sdk/build-tools/android-4.2.2/aapt | grep NEEDED
# NEEDED               librt.so.1
# NEEDED               libdl.so.2
# NEEDED               libpthread.so.0
# NEEDED               libz.so.1
# NEEDED               libstdc++.so.6
# NEEDED               libm.so.6
# NEEDED               libgcc_s.so.1
# NEEDED               libc.so.6
sudo apt-get install libc6:i386 libstdc++6:i386 zlib1g:i386

# apt-get is locked
sudo apt-get update
# E: Could not get lock /var/lib/apt/lists/lock - open (11: Resource temporarily unavailable)
# E: Unable to lock directory /var/lib/apt/lists/
# E: Could not get lock /var/lib/dpkg/lock - open (11: Resource temporarily unavailable)
# E: Unable to lock the administration directory (/var/lib/dpkg/), is another process using it?
sudo rm /var/lib/apt/lists/lock /var/cache/apt/archives/lock

# Alt+Shift to change keyboard layout
# System Settings → Keyboard Layout → Options → Key(s) to change layout

# Ctrl+Alt+Backspace to restart X
# System Settings → Keyboard Layout → Options → Key sequence to kill the X server

# Keyboard shortcuts
# Launch help browser:                         Disabled
# Move window one workspace to the left:       Shift+Super+Left
# Move window one workspace to the right:      Shift+Super+Right
# Move window one workspace up:                Shift+Super+Up
# Move window one workspace down:              Shift+Super+Down
# Hide all normal windows:                     F5
# Switch to workspace left:                    Super+Left
# Switch to workspace right:                   Super+Right
# Switch to workspace above:                   Super+Up
# Switch to workspace below:                   Super+Down
# Take a screenshot:                           Ctrl+F5
# Take a screenshot of a window:               Alt+F5
# Take a screenshot of an area:                Shift+F5
# Copy a screenshot to clipboard:              Ctrl+Super+F5
# Copy a screenshot of a window to clipboard:  Alt+Super+F5
# Copy a screenshot of an area to clipboard:   Shift+Super+F5
# Volume mute:                                 F8
# Volume down:                                 F9
# Volume up:                                   F10
# Play (or play/pause):                        Ctrl+F8
# Previous track:                              Ctrl+F9
# Next track:                                  Ctrl+F10
# Log out:                                     Disabled (important on Chromebook!!)
# Toggle maximization state:                   F4

# Terminal → Edit → Keyboard Shortcuts...
# File
#   New Tab:                                   Ctrl+T
#   New Window:                                Ctrl+N
#   Close Tab:                                 Ctrl+W
# Tabs
#   Switch to Previous Tab:                    Ctrl+Left
#   Switch to Next Tab:                        Ctrl+Right
