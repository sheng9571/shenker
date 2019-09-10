#!/bin/sh

cd ~
mkdir iso && cd iso
wget -O install.iso https://mirrors.xtom.com/osdn//android-x86/65890/android-x86-6.0-r3.iso
cd ~
mkdir vm && cd vm
DISPLAY=:$DISPLAY /usr/local/bin/qemu-img create -f qcow2 hd.img 8G
