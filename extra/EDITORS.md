# Remote Editing Files in your LDE

It's easy to edit files locally in a folder shared with your LDE, but a few issues may arise while doing so. Windows 10 has a limit on the length of a file path, and does not allow creation of symbolic links. Thus, any project with a deep directory tree or a build setup that creates symlinks must live inside the LDE rather than in a shared folder. Working on such projects isn't a challenge for experienced Vim or Emacs users, but I'm sure there are a few users who don't have knowledge in either of those editors.

Some new file editors come with plugins that enable them to edit files on a remote host. This allows users to work on more complex projects inside their LDE from the comfort of a modern editor, and take advantage of the plugins that come with the editor. Some of these options likely won't handle projects with deep directory trees, but still offer remote development nonetheless.

## Atom

Facebook created and maintains a plugin for Atom called Nuclide - it comes with a host of utilities, including a fairly robust remote development feature. Given a username, server address, SSH port, your project's file path on the server, and the appropriate authentication, it can automatically mount the project inside Atom for quick editing. This information can be saved in a profile, and you can automatically load up a project from any saved profile.

For this to work, Nuclide's NPM package and Facebook's Watchman file watching service must be installed on the remote host. Together, they automatically serve files to Atom on your machine and sync file and directory changes. The LDE is provisioned to install these automatically for you, although you might have to update them occasionally.

### Install
1. Enable your LDE's private network to get an IP address assigned by DHCP.
   * Add this line to the Vagrantfile of your LDE:
   ```
   ...
   config.vm.network "private_network", type: "dhcp"
   ...
   ```
   * Reload your LDE for the changes to take effect.
2. Install Atom from [it's website](https://atom.io/).
3. Open Atom, and got to File > Settings > Install.
4. Install Nuclide. Search "nuclide" and it should be the first result.
   * The install might take a little while - this is normal.
5. SSH into your LDE and grab the IP address assigned by DHCP.
   * List the network interfaces.
   ```
   ifconfig
   ```
   * The IP address you're looking for will be listed. It should be easy to spot among the options - personally, it appears under the "enp0s8" interface.
6. In Atom, make sure the File Tree is open (View > Toggle File Tree).
7. Click on "Add Remote Project Folder" and add the remote project of your choice.
   * *Username* should be "vagrant".
   * *Server* should be the IP address assigned by DHCP (found in the last step) to your LDE.
   * *SSH Port* is 22 (the default SSH port).
   * *Initial Directory* should be the absolute file path of your project inside the LDE.
   * *Authentication method* should be *Password*, which is also "vagrant". (_dab_)

After starting up your LDE whenever, repeat steps 5 - 7 as often as you'd like. The IP address assigned to the LDE might differ across startups, so make sure when opening the remote project the *Server* field has the latest IP address.

### Version Mismatch

Nuclide is well maintained by Facebook and gets updates frequently. This can lead to a version mismatch between the Nuclide package installed in Atom and the Nuclide NPM package installed in your LDE. You'll have to manually update both.

1. In Atom, go to File > Settings > Updates.
   * If there is an update available for Nuclide, install it.
2. SSH into your LDE and update the Nuclide NPM package.
   ```
   sudo npm install -g nuclide
   ```
