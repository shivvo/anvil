# XFCE Desktop Environment

Although LDEs are designed to allow you to develop on Windows 10 and run on Linux, some projects may be difficult to work on across operating systems in this fashion (due to limits on remote editing, IDE configuration, etc.). It would simply be more preferable to do all the work on the LDE itself. Equipping your LDE with a graphical desktop environment solves this issue, allowing you to use it as you would Windows 10, but can be difficult to set up with Vagrant.

In case you need your LDE to have a full desktop environment, the Ansible playbook and Vagrantfile comes with some configuration to set up the XFCE desktop environment. Once properly configured, bringing up your LDE will bring up a fully graphical, easy-to-use desktop every time you boot up your LDE - no extra work necessary.

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
3. Run `vagrant up` to setup an LDE with a graphical desktop environment. Your LDE should now pop up as a Virtualbox window.