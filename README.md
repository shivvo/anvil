# Vagrant Linux Development Environment

**Work in progress** This repository will be updated with useful features as time permits. Any and all feedback is appreciated.

Often times, developers would like to easily access a Unix/Linux environment to use the vast array of tools available on those platforms. The amount of power available from those tools allows developers to learn new things, disseminate knowledge, create more useful tools and libraries, and build rock-solid software. Unfortunately, developers with a Windows computer might find it more difficult to access such an environment. There are plenty of solutions out there that can ameliorate the difficulty:
   - VirtualBox - create a virtual machine to use whenever you need a Unix/Linux environment
   - Vagrant - quickly provision a virtual machine to use for development
   - Cygwin - a collection of GNU and open source tools which provide functionality similar to a Linux distribution, plus a POSIX emulation layer
   - Windows Subsystem for Linux (Bash on Windows) - an implementation of Linux syscalls by Microsoft in order to run a full Linux bash

Each of these options has pros and cons, and probably the most preferred option is Bash on Windows. The danger, however, is that since its a work in progress by Microsoft, there's always a chance that it won't have the functionality a developer might need - simply because the Linux syscall hasn't been implemented yet. 

This project uses Vagrant to build a Linux Development Environment (LDE) for Windows 10 users and makes use of other open source tools to create a smooth workflow. It's streamlined for a workflow where:
   - the user writes code using a text editor directly on Windows
   - the user can use Linux tools inside Vagrant to compile their code or perform other tasks

These goals are based off my experience writing side projects and as an undergrad at Cornell University, where some courses and project teams are, by nature, not geared towards Windows 10 users. Since this is based off of Vagrant, this solution should work on Windows 7, 8,  8.1 and 10. Known differences have been accumulated in the **Install** section, based off of user feedback. In addition, there's install steps for macOS/OS X users who are looking for something similar to what this offers.

## What does this add?

This project aims to add (at minimum) to following to your Windows computer:
   - VirtualBox - for running your LDE inside a virtual machine
   - Vagrant - to provision your LDE and manage some startup tasks
   - VcXsrv - a Windows X-server based on the xorg sources

VirtualBox and Vagrant together build virtual machines where fine-tuning development environments can be kept separate from your main operating system install. Hyper and Git for Windows together can build a versatile bash shell that supercedes Command Prompt. VcXsrv allow Windows to display GUI programs running from within the LDE using X11 forwarding.

## Install
1. Install **VcXsrv** from [it's website](https://sourceforge.net/projects/vcxsrv/).
6. Install **VirtualBox** and the **VirtualBox Extension Pack** from [it's website](https://www.virtualbox.org/wiki/Downloads)
7. Install **Vagrant** from [it's website](https://www.vagrantup.com/)
   * **Note**: On Windows 7, Vagrant will hang during usage if PowerShell is not up to date. There's two options to alleviate the issue
      * You can upgrade PowerShell to it's most recent version before installing Vagrant (the most recent version). (*preferred*)
      * You can install Vagrant 1.9.6.
8. Open your terminal (Hyper) and run the following
   ```
   vagrant plugin install vagrant-vbguest
   vagrant plugin install sahara
   vagrant plugin install vagrant-winnfsd
    ```
9. Clone this repository
10. `cd` into the repository and run the following commands:
    ```
    vagrant up
    vagrant reload
    ```

## How do I use this?

After completing steps 1 - 8 of the install process, you can repeat steps 9 and 10 as often as you'd like to setup a new LDE for a new project.

Once the LDE is fully provisioned, simply `vagrant ssh` and use the machine as you please. If you would like to have files on your system available to the VM, drop them into the LDE's folder - the directory is automatically shared inside the LDE at the **/vagrant** folder.

If you would like to use a GUI program such as Atom or GNOME Terminal, make sure VcXsrv is running before trying to open it from inside the LDE's bash. It might be useful to set VcXsrv as a startup task in case you use this feature frequently.

## Can I skip some steps?

The core functionality of this project is to create a better Windows 10 developer experience - that being said, you can strip away things you don't need or have a preferred alternative for:
* If you don't need an X11 forwarding for GUI programs, you can skip step 1.
* If you don't need a better shell, you can skip steps 2 - 5.
   * If you still need X11 forwarding, add **DISPLAY = localhost:0** to the Windows environment variables. You can learn how to do that [here](https://kb.wisc.edu/cae/page.php?id=24500).



## Install for macOS/OS X

This project can be adapted to Apple operating systems fairly easily. Here are the install steps:
1. Install **XQuartz** from [it's website](https://www.xquartz.org/)
2. Edit your **.bashrc** in your home directory to include the following:
    ```
    ...
    export DISPLAY=localhost:0
    ...
    ```
    You'll probably want to reload the .bashrc or restart the terminal after this change.
3. Install **VirtualBox** and the **VirtualBox Extension Pack** from [it's website](https://www.virtualbox.org/wiki/Downloads)
4. Install **Vagrant** from [it's website](https://www.vagrantup.com/)
5. Open your terminal and run the following
   ```
   vagrant plugin install vagrant-vbguest
   vagrant plugin install sahara
    ```
6. Clone this repository
7. `cd` into the repository and run the following commands:
    ```
    vagrant up
    vagrant reload
    ```

## TODOS

It's not possibly to create symlinks on Windows systems without special permissions. I plan on adding some more provision to handle this problem seamlessly.
