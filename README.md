# Vagrant Linux Development Environment

**Work in progress** This repository will be updated with useful features as time permits. Any and all feedback is appreciated.

Often times, developers would like to easily access a Unix/Linux environment to use the vast array of tools available on those platforms. The amount of power available from those tools allows developers to learn new things, disseminate knowledge, create more useful tools and libraries, and build rock-solid software. Unfortunately, developers with a Windows computer might find it more difficult to access such an environment. There are plenty of solutions out there that can ameliorate the difficulty:
* VirtualBox - create a virtual machine to use whenever you need a Unix/Linux environment
* Vagrant - quickly provision a virtual machine to use for development
* Cygwin - a collection of GNU and open source tools which provide functionality similar to a Linux distribution, plus a POSIX emulation layer
* Windows Subsystem for Linux (Bash on Windows) - an implementation of Linux syscalls by Microsoft in order to run a full Linux bash

Each of these options has pros and cons, and probably the most preferred option is Bash on Windows. The danger, however, is that since its a work in progress by Microsoft, there's always a chance that it won't have the functionality a developer might need - simply because the Linux syscall hasn't been implemented yet. 

This project uses Vagrant to build Linux Development Environments (LDEs) for Windows 10 users and makes use of other open source tools to create a smooth workflow. It's streamlined for a workflow where:
* the user writes code using a text editor directly on Windows
* the user can use Linux tools inside Vagrant to compile their code or perform other tasks

These goals are based off my experience writing side projects and as an undergrad at Cornell University, where some courses and project teams are, by nature, not geared towards Windows 10 users. Since this is based off of Vagrant, this solution should work on Windows 7, 8,  8.1 and 10. Known differences have been accumulated in the **Install** section, based off of user feedback. In addition, there's install steps for macOS/OS X users who are looking for something similar to what this offers.

## What does this add?

This project adds (at minimum) to following to your Windows computer:
* VirtualBox - for running your LDE inside a virtual machine
* Vagrant - to provision your LDE and manage some startup tasks

VirtualBox and Vagrant together build virtual machines where fine-tuning development environments can be kept separate from your main operating system install.

## Install

1. Install **VirtualBox** and the **VirtualBox Extension Pack** from [it's website](https://www.virtualbox.org/wiki/Downloads)
2. Install **Vagrant** from [it's website](https://www.vagrantup.com/)
   * **Note**: On Windows 7, Vagrant will hang during usage if PowerShell is not up to date. There's two options to alleviate the issue
      * You can upgrade PowerShell to it's most recent version before installing Vagrant (the most recent version). (*preferred*)
      * You can install Vagrant 1.9.6.
3. Open your terminal and run the following
   ```
   vagrant plugin install vagrant-vbguest
   vagrant plugin install vagrant-ansible-local
   ```
4. Clone this repository
5. `cd` into the repository and run the following commands:
   ```
   vagrant up
   vagrant reload
   ```
## How do I use this?

After completing steps 1 - 3 of the install process, you can repeat steps 4 and 5 as often as you'd like to setup a new LDE for a new project.

Once the LDE is fully provisioned, simply `vagrant ssh` and use the machine as you please. If you would like to have files on your system available to the VM, drop them into the LDE's folder - the directory is automatically shared inside the LDE at the **/vagrant** folder.

## What comes with it?

The Ansible playbook used to provision the LDE can install several build tools, version control tools, and utilities. Not all of them are enabled, but can be by uncommenting the corresponding task in the playbook. By default, the Ansible playbook:

* updates package sources and upgrades installed packages
* installs X11 forwarding functionality and GNOME Terminal
* installs commonly used build tools (`build-essential`, `cmake`, etc.)
* installs commonly used version control tools (`git`)
* installs Python 2, Python 3, and Java

Some of the disabled tasks in the playbook can install:
* an XFCE desktop environment
* Node.js 6 and NPM, with Nuclide support
* OCaml and OPAM

## Bash Terminals

The default terminals in Windows 10 (Command Prompt, PowerShell) might not suit your needs as a developer who works mostly in a Linux environment. There are alternative terminals that provide a Bash-like environment in Windows 10 (other than Bash on Windows).

### Hyper and Git

Hyper is a minimal shell developed with JavaScript, HTML and CSS. Although the startup time is occasionally slow, it does its job well, is easily customizable, and (with Unix tools integrated) a solid Bash terminal. Git is a powerful version control tool, and optionally comes with Unix command line utilities that can be used on Windows 10. With Git and Unix tools integrated into Hyper, you'll be able to navigate Windows 10 mostly as you would a Linux system.

#### Install

1. Install **Git for Windows** from [it's website](https://git-scm.com/download/win). As you click through the installer, be sure to select the following options:
   * Select the option **Use Git from Git Bash only** when it comes up.
   * Select the option **Use the OpenSSL library** when it comes up.
   * Select the option **Checkout as-is, commit as-is** when it comes up.
      * This means you'll have to make sure to develop with Unix line endings when working on a Git repo on Windows. While this adds some extra setup overhead, errors relating to line endings inside the LDE will be minimized (and those are a lot tougher to handle). 
   * Select the option **Use MinTTY (the default terminal of MSYS2)** when it comes up.
2. Install **Hyper** from [it's website](https://hyper.is/).
3. Configure Hyper to launch a bash shell.
   * In your editor, open the **.hyper.js** file living in your home directory (e.g. C:\Users\shivr).
   * Edit the **shell** and **shellArgs** parameters in *.hyper.js*:
      ```
      ...
      shell: 'C:\\Program Files\\Git\\git-cmd.exe',
      ...
      shellArgs: ['--command=usr/bin/bash.exe', '-l', '-i'],
      ...
      ```
4. Configure the bash shell.
   * Open or create a **.bashrc** file in your home directory.
   * Add these contents (mandatory):
      ```
      export TERM=cygwin
      ```

## X11 Forwarding

Some applications can take advantage X11 forwarding, a feature of some Linux systems where an application can be started on a remote Linux system (X11 client) but rendered locally (X11 server). For example, using OCaml tools like `utop` will not render correctly on Windows 10 when using them inside the LDE. You could use X11 forwarding to run a Bash terminal from within Vagrant and display it on Windows 10, and run `utop` from there.

Any LDE can install the client software, and an X11 server implementation is available on Windows 10.

### Install
1. Install some Bash terminal from [one of these options](SHELL.md), or one of your own.
2. Install **VcXsrv** from [it's website](https://sourceforge.net/projects/vcxsrv/).
3. Add the following line to your `.bashrc`
   ```
   export DISPLAY=localhost:0
   ```
4. Inside your LDE, install X11 software and a Bash terminal.
   * SSH into your LDE
   ```
   vagrant ssh
   ```
   * Install packages for X11 forwarding, and GNOME Terminal
   ```
   sudo apt install -y xauth gnome-terminal
   ```
5. Start **VcXsrv**. It will run as a daemon, and any GUI program you run inside the LDE will now be displayed on your Windows 10 host. Try it out with `gnome-terminal`!

## Remote Editing Files in your LDE

It's easy to edit files locally in a folder shared with your LDE, but there are some limitations to that approach. Windows 10 has a limit on the length of a file path, and does not allow creation of symbolic links. Thus, any project with a deep directory tree, a build setup that creates symlinks, or generally is heavily dependent on the Linux environment must live inside the LDE rather than in a shared folder. Working on such projects isn't a challenge for experienced Vim or Emacs users, but I'm sure there are a few users who don't have knowledge in either of those editors.

There are some tools that enable remote development on Windows 10. This allows users to work on more complex projects inside their LDE from the comfort of a modern editor, complete with all the plugins their hearts desire. Some of these options likely won't handle projects with deep directory trees, but still offer remote development for Linux-bound projects nonetheless.

### First Step: Set up a Private Network

To take advantage of remote development, your LDE will need an IP address accessible to the network you're on. You'll need to enable a Vagrant private network, which will give your LDE an IP address accessible within the network you're on, but not to the public internet. The IP address will be assigned by DHCP - this eliminates the hassle of finding an available address, but means you'll have to check your LDE's IP address after booting it up.

#### Install
1. Enable your LDE's private network to get an IP address assigned by DHCP.
   * Add this line to the Vagrantfile of your LDE:
   ```
   ...
   config.vm.network "private_network", type: "dhcp"
   ...
   ```
   * Reload your LDE for the changes to take effect.
2. SSH into your LDE and check the IP address assigned by DHCP.
   * List the network interfaces.
   ```
   ifconfig
   ```
   * The IP address you're looking for will be listed, under one of the network interfaces. Usually, there's a loopback interface and one with IP address 10.0.X.X - the third is probably the one with the IP address assigned by DHCP.

You can use step 2 to refer back to the IP address - it will be used in most remote development tools to connect to your LDE.

### Atom

Facebook created and maintains a plugin for Atom called Nuclide - it comes with a host of utilities, including a fairly robust remote development feature. Given a username, server address, SSH port, your project's file path on the server, and the appropriate authentication, it can automatically mount the project inside Atom for quick editing. Some of this information can be saved in a profile, and you can automatically load up a project from any saved profile.

For this to work, Nuclide's NPM package and Facebook's Watchman file watching service must be installed on the remote host. Together, they automatically serve files to Atom on your machine and sync file and directory changes. The LDE is provisioned to install these automatically for you, although you might have to update them occasionally.

#### Install
1. Install Atom from [it's website](https://atom.io/).
2. Open Atom, and got to File > Settings > Install.
3. Install Nuclide. Search "nuclide" and it should be the first result.
   * The install might take a little while - this is normal.
4. In Atom, make sure the File Tree is open (View > Toggle File Tree).
5. Click on "Add Remote Project Folder" and add the remote project of your choice.
   * *Username* should be "vagrant".
   * *Server* should be the IP address assigned by DHCP (found in the last step) to your LDE.
   * *SSH Port* is 22 (the default SSH port).
   * *Initial Directory* should be the absolute file path of your project inside the LDE.
   * *Authentication method* should be *Password*, which is also "vagrant". (_dab_)

After starting up your LDE whenever, repeat steps 4 - 5 as often as you'd like. The IP address assigned to the LDE might differ across startups, so make sure when opening the remote project the *Server* field has the latest IP address.

#### Version Mismatch

Nuclide is well maintained by Facebook and gets updates frequently. This can lead to a version mismatch between the Nuclide package installed in Atom and the Nuclide NPM package installed in your LDE. You'll have to manually update both.

1. In Atom, go to File > Settings > Updates.
   * If there is an update available for Nuclide, install it.
2. SSH into your LDE and update the Nuclide NPM package.
   ```
   sudo npm install -g nuclide
   ```

### SSHFS

SSHFS is a filesystem client that can mount files and directories living on a remote host over SSH. You be able to share files from your LDE to your host machine - the folders you choose to mount will be mounted as a new drive, and you can browse through it with File Explorer as you would with any folder living directly on your machine. The benefit is that you can take advantage of any development environment you wish, but it's likely that you can't have deep directories or long file paths in your project.

SSHFS is not native to Windows 10, but some saintly developers have ported [FUSE](https://github.com/billziss-gh/winfsp) and [SSHFS](https://github.com/billziss-gh/sshfs-win) to Windows 10 and made it easy to add an SSHFS network drive to mount files on a remote machine.

#### Install
1. Install WinFsp and SSHFS-Win from [it's website](http://www.secfs.net/winfsp/download/).
2. In File Explorer, right click on "This PC" and click "Map network drive.."
3. To mount a remote folder with SSHFS, type in the *Folder* field:
   ```
   \\sshfs\[local]=vagrant@[host]\[folder]
   ```
   * The `local` is the local user (the one you're signed into on the host machine).
   * The `host` is the IP address assigned by DHCP.
   * Optionally, the `folder` is the path of the project you'd like to mount relative to the Vagrant home directory in your LDE.
   * For example, consider a Windows 10 user `shivr` who has an LDE with DHCP-assigned IP 172.28.128.3 and a project living at `/home/vagrant/foobar`. You'd put `\\sshfs\shivr=vagrant@172.28.128.3\foobar` in the *Folder* field of the dialog.
   * To mount the Vagrant home directory, you can leave out `folder` and the trailing slash.
4. Click Finish. Enter the password to your LDE ("vagrant") when asked.

A network drive should pop up on the sidebar, pointing to the folder you've mounted.
