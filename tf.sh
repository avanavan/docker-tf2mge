#!/bin/sh
cd $HOME/hlserver

bash cleandemo.sh
bash runtime.sh

tf2/srcds_run -game tf +sv_pure 1 +map ${MGE_MAP:-mge_training_v8_beta4b} +servercfgfile server.cfg +maxplayers 24