# Update and upgrade
apt-get -y --fix-missing update
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" upgrade
apt-get install -y build-essential git xauth gnome-terminal
