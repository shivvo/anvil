# Desktop Forwarding

Some applications can take advantage X11 forwarding, a feature of some Linux systems where an application can be started on a remote Linux system (X11 client) but rendered locally (X11 server). For example, using OCaml tools like `utop` will not render correctly on Windows 10 when using them inside the LED. You could use X11 forwarding to run a Bash terminal from within Vagrant and display it on Windows 10, and run `utop` from there. 

In addition, the LED is capable of streaming the entire desktop to a client machine using a VNC server for X11 displays. A VNC client, such as [TightVNC](https://www.tightvnc.com/) or [bVNC Secure](https://play.google.com/store/apps/details?id=com.iiordanov.freebVNC&hl=en), can be used to remotely connect to your machine and use as a full desktop.

Any LED can install the client software, and an X11 server implementation is available on Windows 10.

## Install
1. Install some Bash terminal from [one of these options](editors.md), or one of your own.
2. Install **VcXsrv** from [it's website](https://sourceforge.net/projects/vcxsrv/).
3. Add the following line to your `.bashrc`
   ```
   export DISPLAY=localhost:0
   ```
5. Start **VcXsrv**. It will run as a daemon, and any GUI program you run inside the LED will now be displayed on your Windows 10 host. Try it out with `gnome-terminal`!