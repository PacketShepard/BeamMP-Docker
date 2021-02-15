#!/bin/sh

cat <<EOF >Server.cfg
# This is the BeamMP Server Configuration File v0.60
Debug = ${Debug} # true or false to enable debug console output
Private = ${Private} # Private?
Port = ${Port} # Port to run the server on UDP and TCP
Cars = ${Cars} # Max cars for every player
MaxPlayers = ${MaxPlayers} # Maximum Amount of Clients
Map = "${Map}" # Default Map
Name = "${Name}" # Server Name
Desc = "${Desc}" # Server Description
use = "${use}" # Resource file name
AuthKey = "${AuthKey}" # Auth Key
EOF

exec ./BeamMP-Server
