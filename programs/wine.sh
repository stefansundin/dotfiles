# lutris - https://lutris.net/downloads/
# debian
echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_10/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list
wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_10/Release.key -O- | sudo apt-key add -
sudo apt update
sudo apt install lutris
# ubuntu
sudo add-apt-repository ppa:lutris-team/lutris
sudo apt update
sudo apt install lutris

# winetricks - https://wiki.winehq.org/Winetricks
# install DLLs and stuff
winetricks corefonts vcrun6 vb5run native_oleaut32 vcrun2010 richtx32
