#!/bin/bash

#
#   Responsible for cleaning the containers' generated STV demos on runtime
#

set -e

rm -f $HOME/hlserver/tf2/tf/*.dem || true