#!/bin/bash
set -e

cd $HOME/hlserver/tf2/tf

mm_url=$(wget -q -O - "https://www.metamodsource.net/downloads.php?branch=master" | grep -oP -m1 "https://[a-z.]+/mmsdrop/[0-9.]+/mmsource-(.*)-linux.tar.gz")
sm_url=$(wget -q -O - "http://www.sourcemod.net/downloads.php?branch=master" | grep -oP -m1 "https://[a-z.]+/smdrop/[0-9.]+/sourcemod-(.*)-linux.tar.gz")
wget -nv $mm_url
wget -nv $sm_url

tar -xvzf mmsource-*-linux.tar.gz
tar -xvzf sourcemod-*-linux.tar.gz

rm *.tar.gz

# prevent automatic map switch
rm addons/sourcemod/plugins/{nextmap.smx,funcommands.smx,funvotes.smx}

# Remove useless maps and cfg
cd $SERVER/tf2/tf/maps
rm -f *.bsp || true

cd $SERVER/tf2/tf/cfg
rm -f * || true

cd $SERVER/tf2/tf
rm -f resource/tf_*.txt || true

# Install MGEmod and Maps
MGEMOD_VERSION="v3.0.9"
wget -nv "https://github.com/sapphonie/MGEMod/releases/download/${MGEMOD_VERSION}/mge.zip"
unzip -o mge.zip

rm mge.zip

# Advertisements
# AD_VERSION="2.1.2"
# wget -nv https://github.com/ErikMinekus/sm-advertisements/releases/download/${AD_VERSION}/advertisements.zip
# unzip -o advertisements.zip

# rm advertisements.zip

# tf2-comp-fixes
COMPFIX_VERSION="v1.16.19"
wget -nv https://github.com/ldesgoui/tf2-comp-fixes/releases/download/${COMPFIX_VERSION}/tf2-comp-fixes.zip
unzip -o tf2-comp-fixes.zip

rm tf2-comp-fixes.zip

# Sourcebans
wget -nv https://github.com/sbpp/sourcebans-pp/releases/download/Plugins-Latest/sourcebans-pp-Plugins-Latest.tar.gz
tar -xvzf sourcebans-pp-Plugins-Latest.tar.gz --strip-components=1 common/

rm sourcebans-pp-Plugins-Latest.tar.gz

# STAC
cd $HOME/hlserver/tf2/tf/addons/sourcemod

STAC_VERSION="v6.3.7"
wget -nv https://github.com/sapphonie/StAC-tf2/releases/download/${STAC_VERSION}/stac.zip
unzip -o stac.zip

rm stac.zip