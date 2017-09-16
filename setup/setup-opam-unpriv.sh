sudo apt-get install -y m4 opam
opam init -a -y --comp 4.05.0
eval `opam config env`
opam install -y utop ounit qtest yojson lwt menhir ansiterminal lambda-term merlin ocp-indent user-setup
opam user-setup install
