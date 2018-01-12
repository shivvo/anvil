# XFCE Desktop Environment

Although LEDs are designed to allow you to develop on Windows 10 and run on Linux, some projects may be difficult to work on across operating systems in this fashion (due to limits on remote editing, IDE configuration, etc.). It would simply be more preferable to do all the work on the LED itself. Equipping your LED with a graphical desktop environment solves this issue, allowing you to use it as you would Windows 10, but can be difficult to set up with Vagrant.

In case you need your LED to have a full desktop environment, the Ansible playbook and Vagrantfile comes with some configuration to set up the XFCE desktop environment. Once properly configured, bringing up your LED will bring up a fully graphical, easy-to-use desktop every time you boot up your LED - no extra work necessary.

## Install

1. In your Vagrantfile, uncomment the following lines:
   ```
   config.vm.provider "virtualbox" do |vb|
     vb.gui = true
   end

   config.vm.provision "ansible_local" do |ansible|
     ansible.playbook = "provision/desktop.yml"
   end
   ...
   ```
3. Run `vagrant up` to setup an LED with a graphical desktop environment. Your LED should now pop up as a Virtualbox window.