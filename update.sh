#!/bin/bash
set -e

cd $HOME/hlserver

# Download and install TF2 server
steamcmd.sh +force_install_dir tf2 +login anonymous +app_update 232250 validate +quit