# add user to sudo group and add group to sudoers
su
/sbin/usermod -aG sudo stefan
/sbin/visudo -f /etc/sudoers.d/sudo
%sudo   ALL=(ALL:ALL) ALL
# then reboot (logging out and in does not work!)

# downgrade openssl SECLEVEL to allow connecting to servers with bad security
sudo sed -i.orig 's/DEFAULT@SECLEVEL=2/DEFAULT@SECLEVEL=1/' /etc/ssl/openssl.cnf

# prevent audio crackle/pop when not playing audio for a while
sudo sed -i.bak 's/^load-module module-suspend-on-idle/#&/' /etc/pulse/default.pa
pulseaudio -k

# enable backports
echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee /etc/apt/sources.list.d/backports.list
sudo apt update
sudo apt-get -t buster-backports install keepassxc

# get apt-get suggestions when attempting to run missing binaries (like Ubuntu)
sudo apt install command-not-found
sudo apt update
sudo update-command-not-found

# ppas
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:git-core/ppa
sudo add-apt-repository ppa:stefansundin/truecrypt
sudo add-apt-repository ppa:nginx/stable
sudo add-apt-repository ppa:ondrej/php5-5.6
# sudo add-apt-repository ppa:langemeijer/php5-ssh2
sudo apt-add-repository --remove ppa:langemeijer/php5-ssh2

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
