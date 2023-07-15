sudo apt install vim curl git apt-transport-https

sudo apt install dconf-editor

# add user to sudo group and add group to sudoers
su
/sbin/usermod -aG sudo stefan
/sbin/visudo -f /etc/sudoers.d/sudo
%sudo   ALL=(ALL:ALL) ALL
# then reboot (logging out and in does not work!)

# make vim the default editor (select vim.basic)
sudo update-alternatives --set editor /usr/bin/vim.basic
# some tools use select-editor (saves to ~/.selected_editor)
select-editor
sudo -H select-editor

# install flatpak
sudo apt install flatpak gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# KeePassXC
flatpak install --user flathub org.keepassxc.KeePassXC

# syncthing - https://apt.syncthing.net/
sudo apt install syncthing
systemctl --user enable syncthing.service
systemctl --user start syncthing.service
systemctl --user status syncthing.service
# WebUI: http://127.0.0.1:8384/


# downgrade openssl SECLEVEL to allow connecting to servers with bad security
sudo sed -i.orig 's/DEFAULT@SECLEVEL=2/DEFAULT@SECLEVEL=1/' /etc/ssl/openssl.cnf

# prevent audio crackle/pop when not playing audio for a while
sudo sed -i.bak 's/^load-module module-suspend-on-idle/#&/' /etc/pulse/default.pa
pulseaudio -k

# enable backports
echo "deb http://deb.debian.org/debian bookworm-backports main" | sudo tee /etc/apt/sources.list.d/backports.list
sudo apt update

# get apt-get suggestions when attempting to run missing binaries (like Ubuntu)
sudo apt install command-not-found
sudo apt update
sudo update-command-not-found

# put package on hold (prevent automatic upgrade)
sudo apt-mark hold cassandra dsc21
# undo hold
sudo apt-mark unhold cassandra dsc21

# debianization
sudo apt-get install devscripts
tar xzf truecrypt_7.1a.orig.tar.gz
cd truecrypt-7.1a-source
tar xzf ../truecrypt_7.1a-3.debian.tar.gz
cat debian/control | grep Build-Depends
sudo apt-get install debhelper pkg-config libgtk2.0-dev libwxgtk2.8-dev libfuse-dev libwxbase2.8-dev nasm libappindicator-dev
debuild

# don't run clean and don't sign, useful for faster building:
debuild -nc -i -us -uc -b

# use debchange to add entry to changelog
# to upload to ppa, only build source:
debuild -S
cd ..
dput ppa:stefansundin/truecrypt truecrypt_7.1a-4_source.changes

# java
sudo apt install default-jre
# add ability to double click on jar files
cat <<EOF > java.desktop
[Desktop Entry]
Name=Java
Comment=Java
GenericName=Java
Keywords=java
Exec=java -jar %f
Terminal=false
X-MultipleArgs=false
Type=Application
MimeType=application/x-java-archive
StartupNotify=true
EOF
xdg-desktop-menu install --novendor java.desktop
rm java.desktop
