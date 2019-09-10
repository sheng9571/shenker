#!/bin/sh

# generate a random MAC address for vm
mac=$(dd if=/dev/urandom bs=1024 count=1 2>/dev/null|md5sum|sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\)\(..\).*$/\1:\2:\3:\4:\5:\6/')

echo "Generate random MAC address for VM: $mac"

DISPLAY=:$DISPLAY /usr/local/bin/qemu-system-i386 -enable-kvm -m 2048 -soundhw sb16 -display sdl -cdrom /root/iso/install.iso -hda /root/vm/hd.img -boot order=cd -device virtio-net,netdev=net0,mac=$mac -netdev tap,id=net0,ifname=tap0
