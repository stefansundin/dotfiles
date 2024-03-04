# Node - https://github.com/nodesource/distributions/blob/master/README.md
sudo apt-get install apt-transport-https curl gpg
curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/nodesource.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x bookworm main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install nodejs

# Install global packages without root (i.e. local to the user)
# https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
# Add to .bashrc:
export PATH=~/.npm-global/bin:$PATH

# Upgrade versions in package.json
npm install -g npm-check-updates
ncu
ncu -u

# Yarn
npm install -g yarn
