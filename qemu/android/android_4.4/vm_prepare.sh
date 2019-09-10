#!/bin/sh

cd ~
mkdir iso && cd iso
wget -O install.iso http://rwthaachen.dl.osdn.jp/android-x86/65695/android-x86-4.4-r5.iso
cd ~
mkdir vm && cd vm
DISPLAY=:$DISPLAY /usr/local/bin/qemu-img create -f qcow2 hd.img 8G
