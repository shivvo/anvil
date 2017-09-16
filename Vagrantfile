# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-16.04"

  config.vm.provider "virtualbox" do |vb|
    
    vb.name = "linux-dev"
    vb.memory = "1024"
    vb.cpus = 2
    
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # Configure a private IP and use NFS for shared folders
  config.vm.network "private_network", ip: "192.168.99.100", nic_type: "virtio"
  config.vm.synced_folder ".", "/vagrant", type: "nfs"

  # Basic provisioning to update packages and install some "core" utilities
  config.vm.provision "shell", path: "setup/setup-default.sh"

  # Install a few programming languages
  config.vm.provision "shell", path: "setup/setup-java.sh"
  config.vm.provision "shell", path: "setup/setup-python2.sh"
  config.vm.provision "shell", path: "setup/setup-python3.sh"
  config.vm.provision "shell", path: "setup/setup-node-unpriv.sh", privileged: false
  config.vm.provision "shell", path: "setup/setup-opam-unpriv.sh", privileged: false

  # Install GUI applications
  config.vm.provision "shell", path: "setup/setup-atom.sh"

  # Configure SSH for faster X11 forwarding
  config.ssh.forward_agent = true   
  config.ssh.forward_x11 = true
  config.ssh.extra_args = ["-C", "-c", "aes128-gcm@openssh.com"]

end
