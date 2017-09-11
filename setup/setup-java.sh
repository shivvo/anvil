# Install Java 8
apt-get install -y openjdk-8-jdk 
sed -i '/export JAVA_HOME=\/usr\/lib\/jvm\/java-1.8.0-openjdk-amd64/ d' /home/vagrant/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64" >> /home/vagrant/.bashrc