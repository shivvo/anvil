#! /bin/bash

# Requires no sudo

# Install OPAM
sudo apt-get install -y m4 opam
# Initialize OCaml 4.05.0
opam init -a -y --comp 4.05.0
eval `opam config env`

# Install useful OPAM packages
opam install -y utop ounit qtest yojson lwt menhir ansiterminal lambda-term

# DISABLED: Will wait until some remote text editor setup makes this useful
# OPAM Packages for improving text editor user experience
# opam install -y merlin ocp-indent user-setup
# opam user-setup install
