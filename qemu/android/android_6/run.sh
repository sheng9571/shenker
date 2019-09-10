#!/bin/sh
echo "setting up network environment ..."
/usr/local/bin/network.sh
echo "start vnc server ..."
/usr/local/bin/vnc_start.sh
echo "start android vm ..."
/usr/local/bin/vm_start.sh
