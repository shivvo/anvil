#! /bin/bash

# Requires sudo

# Update and upgrade
apt-get --fix-missing update -y
DEBIAN_FRONTEND=noninteractive apt-get --fix-missing -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
