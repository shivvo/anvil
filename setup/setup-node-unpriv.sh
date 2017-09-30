#! /bin/bash

# Requires no sudo

# Pull the Node.js 6 source
curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh

# Install Node.js 6
sudo apt-get install -y nodejs
# Update NPM
sudo npm install -g npm

# DISABLED: Will wait until a Atom-Nuclide tutorial has been set up
# Install Nuclide - it's pretty great!
# sudo npm install -g nuclide
