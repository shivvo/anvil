# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-16.04"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2

    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # Configure a private IP and use NFS for shared folders
  # config.vm.network "private_network", ip: "192.168.99.100", nic_type: "virtio", virtualbox__intnet: true
  config.vm.synced_folder ".", "/vagrant"#, type: "nfs"

  config.vm.provision "shell", path: "setup/update.sh"
  config.vm.provision "shell", path: "setup/setup.sh", privileged: false

  # Configure SSH for faster X11 forwarding
  # config.ssh.forward_agent = true
  # config.ssh.forward_x11 = true
  # config.ssh.extra_args = ["-C", "-c", "aes128-gcm@openssh.com"]

end
