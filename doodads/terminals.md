# Bash Terminals

The default terminals in Windows 10 (Command Prompt, PowerShell) might not suit your needs as a developer who works mostly in a Linux environment. There are alternative terminals that provide a Bash-like environment in Windows 10 (other than Bash on Windows).

## Hyper and Git

Hyper is a minimal shell developed with JavaScript, HTML and CSS. Although the startup time is occasionally slow, it does its job well, is easily customizable, and (with Unix tools integrated) a solid Bash terminal. Git is a powerful version control tool, and optionally comes with Unix command line utilities that can be used on Windows 10. With Git and Unix tools integrated into Hyper, you'll be able to navigate Windows 10 mostly as you would a Linux system.

### Install

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