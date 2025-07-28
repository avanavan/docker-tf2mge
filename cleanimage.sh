#!/bin/bash

#
# Responsible for reducing the image size
#

set -e 

cd $SERVER/tf2/tf/maps
rm -f *.bsp || true

cd $SERVER/tf2/tf/cfg
rm -f * || true

cd $SERVER/tf2/tf
rm -f resource/tf_*.txt || true