# screenshot from terminal
sudo apt-get install scrot
sleep 5 && scrot screenshot.png

# sudo forget password
sudo -K

# search for a package
apt-cache search vim

# show package information
apt-cache show vim
dpkg -s vim

# list files in a package
dpkg -L nginx

# show package containing path
dpkg -S /usr/lib/evolution/

# see available versions of package
apt-cache policy nginx

# clean up dpkg stuff
sudo apt-get autoremove
sudo apt-get clean
sudo apt-get autoclean

# get list of installed and uninstalled packages
dpkg --get-selections

# see progress of unattended-upgrades
tail -f /var/log/unattended-upgrades/unattended-upgrades-dpkg.log

# mount encrypted home directory on another disk
# get mount passphrase (this is what it tells you to save after you encrypt your home directory):
ecryptfs-unwrap-passphrase /media/ubuntu/long-uuid/home/.ecryptfs/username/.ecryptfs/wrapped-passphrase
# add mount passphrase to keyring:
sudo ecryptfs-add-passphrase --fnek
# this will print two tokens, you need to use the second one as the "Filename Encryption Key (FNEK) Signature"
mkdir ecryptfs
sudo mount -t ecryptfs /media/ubuntu/long-uuid/home/.ecryptfs/username/.Private ecryptfs
# Selection: aes
# Selection: 16
# Enable plaintext passthrough: n
# Enable filename encryption: y
# Filename Encryption Key (FNEK) Signature: <the second key you got from ecryptfs-add-passphrase>
# If you get a warning that you have never mounted with this key before, that is fine, just continue.
