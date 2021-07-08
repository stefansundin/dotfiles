# Node - https://github.com/nodesource/distributions/blob/master/README.md
curl -sL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
echo 'deb https://deb.nodesource.com/node_16.x buster main' | sudo tee /etc/apt/sources.list.d/nodesource.list
echo 'deb-src https://deb.nodesource.com/node_16.x buster main' | sudo tee -a /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install nodejs

# Install global packages without root (i.e. local to the user)
# https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
# Add to .bashrc:
export PATH=~/.npm-global/bin:$PATH

# Yarn
npm install -g yarn
