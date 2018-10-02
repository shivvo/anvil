Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 4

    # Enable GUI
    # vb.gui = true
    vb.customize ["modifyvm", :id, "--vram", "256"]
  end

  # Configure an IP and shared folders
  config.vm.network "public_network", use_dhcp_assigned_default_route: true
  config.vm.synced_folder ".", "/vagrant"

  # Provision the VM to run Ansible
  config.vm.provision "shell", inline: <<-SHELL
    apt update -y
    apt upgrade -y
    apt install -y python3-pip
    pip3 install ansible
    cd /vagrant
    ansible-playbook main.yml
  SHELL

  # Configure SSH for X11 forwarding
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

end
