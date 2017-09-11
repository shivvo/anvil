# Install Atom
until add-apt-repository ppa:webupd8team/atom
do sleep 3
done
apt-get -y update
apt-get install -y atom
apt-get install -y libxss1