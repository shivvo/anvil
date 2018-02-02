Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-16.04"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2

    # Enable GUI
    # vb.gui = true
    vb.customize ["modifyvm", :id, "--vram", "256"]
  end

  # Configure an IP and shared folders
  config.vm.network "public_network", use_dhcp_assigned_default_route: true
  config.vm.synced_folder ".", "/vagrant"#, type: "nfs"

  # Provision the machine
  config.vm.provision "main", type: "ansible_local" do |ansible|
    ansible.playbook = "provision/main.yml"
  end

  # Configure SSH for X11 forwarding
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

end
