#! /bin/bash

# Requires no sudo

BASEDIR=$(dirname "$0")
cd $BASEDIR
sudo bash /vagrant/setup/setup-default.sh
sudo bash /vagrant/setup/setup-java.sh
sudo bash /vagrant/setup/setup-python2.sh
sudo bash /vagrant/setup/setup-python3.sh
bash /vagrant/setup/setup-node-unpriv.sh
bash /vagrant/setup/setup-opam-unpriv.sh
