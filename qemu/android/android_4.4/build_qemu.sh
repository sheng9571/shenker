#!/bin/sh

sudo apt-get update && sudo apt-get install -y binfmt-support pkg-config libglib2.0-dev libpixman-1-dev flex bison libgtk-3-dev libepoxy-dev libgbm-dev libglu1-mesa-dev freeglut3-dev mesa-common-dev libsdl2-dev gnutls-dev libssh2-1-dev libvte-dev
cd ~ && mkdir qemu && cd qemu
wget -O qemu.tar.xz https://download.qemu.org/qemu-2.9.0.tar.xz
tar -Jxvf qemu.tar.xz
mv qemu-2.9.0 qemu
cd qemu
./configure --prefix=$(cd ..; pwd)/qemu-system --enable-debug --enable-system --enable-kvm --enable-gtk --enable-opengl --enable-sdl --enable-vte --enable-libssh2 --enable-gnutls --audio-drv-list=alsa,pa,oss,sdl --target-list=i386-softmmu
sudo make -j8
sudo make install
cd ~
sudo mv /root/qemu/qemu-system /root/
sudo ln -fs /root/qemu-system/bin/* /usr/local/bin/
sudo rm -rf /root/qemu/
# cp /root/qemu-ifup /etc/
# cp /root/qemu-ifdown /etc/
