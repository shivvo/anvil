#! /bin/bash

# Requires no sudo

sudo bash /vagrant/setup/setup-default.sh
sudo bash /vagrant/setup/setup-java.sh
sudo bash /vagrant/setup/setup-python2.sh
sudo bash /vagrant/setup/setup-python3.sh

# DISABLED: These extend the build times of the Vagrantfile, enable as you wish

# bash /vagrant/setup/setup-node-unpriv.sh
# bash /vagrant/setup/setup-opam-unpriv.sh
