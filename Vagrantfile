# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-16.04"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2

    # Enable GUI
    #vb.gui = true

    # Enable faster performance - found these online :)
    #vb.customize ["modifyvm", :id, "--ioapic", "on"]
    #vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    #vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
  end

  # Configure a private IP and shared folders
  config.vm.network "private_network", type: "dhcp"
  config.vm.synced_folder ".", "/vagrant"#, type: "nfs"

  # Provision the machine
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "provision/playbook.yml"
  end

  # Start login manager upon booting up
  #config.vm.provision "shell", inline: "systemctl start gdm", run: "always"

  # Configure SSH for X11 forwarding
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

end
