# Vagrant Linux Development Environment

**Work in progress** This repository will be updated with useful features as time permits. Any and all feedback is appreciated.

Often times, developers would like to easily access a Unix/Linux environment to use the vast array of tools available on those platforms. The amount of power available from those tools allows developers to learn new things, disseminate knowledge, create more useful tools and libraries, and build rock-solid software. Unfortunately, developers with a Windows 10 computer might find it more difficult to access such an environment. There are plenty of solutions out there that can ameliorate the difficulty:
   - VirtualBox - create a virtual machine to use whenever you need a Unix/Linux environment
   - Vagrant - quickly provision a virtual machine to use for development
   - Cygwin - a collection of GNU and open source tools which provide functionality similar to a Linux distribution, plus a POSIX emulation layer
   - Windows Subsystem for Linux (Bash on Windows) - an implementation of Linux syscalls by Microsoft in order to run a full Linux bash

Each of these options has pros and cons, and probably the most preferred option is Bash on Windows. The danger, however, is that since its a work in progress by Microsoft, there's always a chance that it won't have the functionality a developer might need - simply because the Linux syscall hasn't been implemented yet. 

This project uses Vagrant to build a Linux Development Environment (LDE) for Windows 10 users and makes use of other open source tools to create a smooth workflow. It's streamlined for a workflow where:
   - the user writes code using a text editor directly on Windows*
   - the user can use Linux tools inside Vagrant to compile their code or perform other tasks

*It's possible to use an editor running inside the LDE that's forwarded using X11 to appear on the Windows desktop.

These goals are based off my experience writing side projects and as an undergrad at Cornell University, where some courses and project teams are, by nature, not geared towards Windows 10 users. Since this is based off of Vagrant, this solution should theoretically work on Windows 7, 8, and 8.1, but I have not tested on those platforms.

## What does this add?

This project aims to add to following to your Windows 10 computer:
   - VirtualBox - for running your LDE inside a virtual machine
   - Vagrant - to provision your LDE and manage some startup tasks
   - Hyper - a shell built with JavaScript, CSS, HTML, and Electron
   - Git for Windows - git is always useful, but this comes with a handy bash shell, too
   - VcXsrv - a Windows X-server based on the xorg sources

VirtualBox and Vagrant are two peas in a pod, and together build virtual machines where fine-tuning development environments can be kept separate from your main operating system install.

Hyper and Git for Windows together can build a versatile bash shell that supercedes Command Prompt.

VcXsrv allow Windows 10 to display GUI programs forwarded by the LDE using X11.

## Install
1. Install **VcXsrv** from [it's website](https://sourceforge.net/projects/vcxsrv/)
2. Install **Git for Windows** from [it's website](https://git-scm.com/download/win). As you click through the installer, be sure to select the following options:
   * Select the option *Use Git from Git Bash only* when it comes up
   * Select the option *Use the OpenSSL library* when it comes up
   * Select the option *Checkout Windows-style, commit Unix-style line endings* when it comes up
   * Select the option *Use MinTTY (the default terminal of MSYS2)* when it comes up
3. Install **Hyper** from [it's website](https://hyper.is/)
4. Configure Hyper to launch a bash shell
   * In your editor, open the **.hyper.js** file living in your home directory (e.g. C:\Users\shivr)
   * Edit the **shell** and **shellArgs** parameters in *.hyper.js*
    ```
    ...
    shell: 'C:\\Program Files\\Git\\git-cmd.exe',
    ...
    shellArgs: ['--command=usr/bin/bash.exe', '-l', '-i'],
    ...
    ```
5. Configure the bash shell
   * Open or create a **.bashrc** file in your home directory
   * Add these contents (mandatory)
    ```
    export TERM=cygwin
    export DISPLAY=localhost:0
    ```
6. Install **VirtualBox** and the **VirtualBox Extension Pack** as described by [it's website](https://www.virtualbox.org/wiki/Downloads)
7. Install **Vagrant** from [it's website](https://www.vagrantup.com/)
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
    vagrant halt
    vagrant up
    ```
## How do I use this?

Whenever after completing steps 1 - 8 of the install process, you can repeat steps 9 and 10 as often as you'd like to setup a new LDE for a new project.

Once the LDE is fully provisioned, simply `vagrant ssh` and use the machine as you please. If you would like to have files on your system available to the VM, drop them into the LDE's folder - the directory is automatically shared inside the LDE at the **/vagrant** folder.

If you would like to use a GUI program such as Atom or GNOME Terminal, make sure VcXsrv is running before trying to open it from inside the LDE's bash. It might be useful to set VcXsrv as a startup task in case you use this feature frequently.

## TODOS

It's not possibly to create symlinks on Windows systems without special permissions. I plan on adding some more provision to handle this problem seamlessly.

In addition, I'll probably add some more builtin features to make the VM more versatile.