#!/bin/sh

cd ~
mkdir iso && cd iso
wget -O install.iso https://dotsrc.dl.osdn.net/osdn/android-x86/69704/android-x86-8.1-r2.iso
cd ~
mkdir vm && cd vm
DISPLAY=:$DISPLAY /usr/local/bin/qemu-img create -f qcow2 hd.img 8G
