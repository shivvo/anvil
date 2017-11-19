# X11 Forwarding

Some applications can take advantage X11 forwarding, a feature of some Linux systems where an application can be started on a remote Linux system (X11 client) but rendered locally (X11 server). For example, using OCaml tools like `utop` will not render correctly on Windows 10 when using them inside the LDE. You could use X11 forwarding to run a Bash terminal from within Vagrant and display it on Windows 10, and run `utop` from there.

Any LDE can install the client software, and an X11 server implementation is available on Windows 10.

## Install
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