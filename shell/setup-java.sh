#! /bin/bash

# Requires sudo

# Install Java 8 and Ant
apt-get install -y openjdk-8-jdk ant

# Remove any reference to JAVA_HOME environment variable in .bashrc
sed -i '/export JAVA_HOME=\/usr\/lib\/jvm\/java-1.8.0-openjdk-amd64/ d' /home/vagrant/.bashrc
# Add JAVA_HOME environment variable in .bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64" >> /home/vagrant/.bashrc
