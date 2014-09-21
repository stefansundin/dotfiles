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
