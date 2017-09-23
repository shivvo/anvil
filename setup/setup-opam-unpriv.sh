#! /bin/bash

# Requires no sudo

# Install OPAM
sudo apt-get install -y m4 opam
# Initialize OCaml 4.05.0
opam init -a -y --comp 4.05.0
eval `opam config env`

# Install a bunch of useful stuff
opam install -y utop ounit qtest yojson lwt menhir ansiterminal lambda-term merlin ocp-indent user-setup
opam user-setup install
