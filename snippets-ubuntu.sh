# screenshot from terminal
sudo apt-get install scrot
sleep 5 && scrot screenshot.png

# sudo forget password
sudo -K

# see available versions of package
apt-cache policy nginx

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
