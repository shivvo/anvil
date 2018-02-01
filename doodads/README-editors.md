# Remote Editing Files in your LED

It's easy to edit files locally in a folder shared with your LED, but there are some limitations to that approach. Windows 10 has a limit on the length of a file path, and does not allow creation of symbolic links. Thus, any project with a deep directory tree, a build setup that creates symlinks, or generally is heavily dependent on the Linux environment must live inside the LED rather than in a shared folder. Working on such projects isn't a challenge for experienced Vim or Emacs users, but I'm sure there are a few users who don't have knowledge in either of those editors.

There are some tools that enable remote development on Windows 10. This allows users to work on more complex projects inside their LED from the comfort of a modern editor, complete with all the plugins their hearts desire. Some of these options likely won't handle projects with deep directory trees, but still offer remote development for Linux-bound projects nonetheless.

## First Step: Set up a Private Network

To take advantage of remote development, your LED will need an IP address accessible to the network you're on. You'll need to enable a Vagrant private network, which will give your LED an IP address accessible from your host machine (laptop). The IP address will be assigned by DHCP - this eliminates the hassle of finding an available address, but means you'll have to check your LED's IP address after booting it up.

### Install
1. Enable your LED's private network to get an IP address assigned by DHCP.
   * Add this line to the Vagrantfile of your LED:
   ```
   ...
   config.vm.network "private_network", type: "dhcp"
   ...
   ```
   * Reload your LED for the changes to take effect.
2. SSH into your LED and check the IP address assigned by DHCP.
   * List the network interfaces.
   ```
   ifconfig
   ```
   * The IP address you're looking for will be listed, under one of the network interfaces. Usually, there's a loopback interface and one with IP address 10.0.X.X - one of the other options is probably the one with the IP address assigned by DHCP.

You can use step 2 to refer back to the IP address - it will be used in most remote development tools to connect to your LED.

## SSHFS

SSHFS is a filesystem client that can mount files and directories living on a remote host over SSH. You be able to share files from your LED to your host machine - the folders you choose to mount will be mounted as a new drive, and you can browse through it with File Explorer as you would with any folder living directly on your machine. The benefit is that you can take advantage of any development environment you wish, but it's likely that you can't have deep directories or long file paths in your project.

SSHFS is not native to Windows 10, but some saintly developers have ported [FUSE](https://github.com/billziss-gh/winfsp) and [SSHFS](https://github.com/billziss-gh/sshfs-win) to Windows 10 and made it easy to add an SSHFS network drive to mount files on a remote machine.

### Install
1. Install WinFsp and SSHFS-Win from [it's website](http://www.secfs.net/winfsp/download/).
2. In File Explorer, right click on "This PC" and click "Map network drive.."
3. To mount a remote folder with SSHFS, type in the *Folder* field:
   ```
   \\sshfs\[local]=vagrant@[host]\[folder]
   ```
   * The `local` is the local user (the one you're signed into on the host machine).
   * The `host` is the IP address assigned by DHCP.
   * Optionally, the `folder` is the path of the project you'd like to mount relative to the Vagrant home directory in your LED.
   * For example, consider a Windows 10 user `shivr` who has an LED with DHCP-assigned IP 172.28.128.3 and a project living at `/home/vagrant/foobar`. You'd put `\\sshfs\shivr=vagrant@172.28.128.3\foobar` in the *Folder* field of the dialog.
   * To mount the Vagrant home directory, you can leave out `folder` and the trailing slash.
4. Click Finish. Enter the password to your LED ("vagrant") when asked.

A network drive should pop up on the sidebar, pointing to the folder you've mounted.

## Atom

Facebook created and maintains a plugin for Atom called Nuclide - it comes with a host of utilities, including a fairly robust remote development feature. Given a username, server address, SSH port, your project's file path on the server, and the appropriate authentication, it can automatically mount the project inside Atom for quick editing. Some of this information can be saved in a profile, and you can automatically load up a project from any saved profile.

For this to work, Nuclide's NPM package and Facebook's Watchman file watching service must be installed on the remote host. Together, they automatically serve files to Atom on your machine and sync file and directory changes. The LED is provisioned to install these automatically for you, although you might have to update them occasionally.

### Install
1. Install Atom from [it's website](https://atom.io/).
2. Open Atom, and got to File > Settings > Install.
3. Install Nuclide. Search "nuclide" and it should be the first result.
   * The install might take a little while - this is normal.
4. In Atom, make sure the File Tree is open (View > Toggle File Tree).
5. Click on "Add Remote Project Folder" and add the remote project of your choice.
   * *Username* should be "vagrant".
   * *Server* should be the IP address assigned by DHCP (found in the last step) to your LED.
   * *SSH Port* is 22 (the default SSH port).
   * *Initial Directory* should be the absolute file path of your project inside the LED.
   * *Authentication method* should be *Password*, which is also "vagrant". (_dab_)

After starting up your LED whenever, repeat steps 4 - 5 as often as you'd like. The IP address assigned to the LED might differ across startups, so make sure when opening the remote project the *Server* field has the latest IP address.

### Version Mismatch

Nuclide is well maintained by Facebook and gets updates frequently. This can lead to a version mismatch between the Nuclide package installed in Atom and the Nuclide NPM package installed in your LED. You'll have to manually update both.

1. In Atom, go to File > Settings > Updates.
   * If there is an update available for Nuclide, install it.
2. SSH into your LED and update the Nuclide NPM package.
   ```
   sudo npm install -g nuclide
   ```