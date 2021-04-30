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

USER_NAME=${USER_NAME:-beammp}

PUID=${PUID:-811}
PGID=${PGID:-811}

useradd -M -r -s /usr/sbin/nologin "$USER_NAME"
groupmod -o -g "$PGID" "$USER_NAME"
usermod -o -u "$PUID" "$USER_NAME"

chown "$USER_NAME":"$USER_NAME" /beammp

exec s6-setuidgid ${USER_NAME} ./BeamMP-Server
