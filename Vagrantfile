# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-16.04"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--vram", "128"]
  end

  #config.vm.network :private_network, ip: "10.11.12.13"
  config.vm.synced_folder ".", "/vagrant" #, nfs: true

  config.vm.provision "shell", path: "setup/setup-default.sh"
  config.vm.provision "shell", path: "setup/setup-x11.sh"
  config.vm.provision "shell", path: "setup/setup-terminal.sh"

  config.vm.provision "shell", path: "setup/setup-opam-0.sh"
  config.vm.provision "shell", path: "setup/setup-opam-1.sh", privileged: false
  config.vm.provision "shell", path: "setup/setup-java.sh"
  
  config.vm.provision "shell", path: "setup/setup-atom.sh"

#config.vm.provision "shell", path: "setup/setup-unison.sh", privileged: false
#config.vm.provision "shell", path: "startup/startup-unison.sh", run: "always", privileged: false

  config.ssh.forward_agent = true   
  config.ssh.forward_x11 = true 

end
