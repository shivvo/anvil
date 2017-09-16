curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo chown -R $(whoami) $(npm config get prefix)/{lib/node_modules,bin,share}