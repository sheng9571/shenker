#!/bin/sh
qemubr=br0
device=$(ip route show default | grep src | awk '/.*/ {print $3}')
addr=$(ip route show default | grep src | awk '/.*/ {print $NF}')
mask=$(/sbin/ifconfig $device | grep Mask | cut -d":" -f4)
gw=$(ip route show default | grep via | awk '/.*/ {print $3}')
ipstr=$(echo $addr | cut -d"." -f-1,2,3).$(expr $(echo $addr | cut -d"." -f4) + 40)
iped=$(echo $addr | cut -d"." -f-1,2,3).$(expr $(echo $addr | cut -d"." -f4) + 44)

echo "Start DHCP server on $qemubr and ip address range is: $ipstr ~ $iped"

#sudo dnsmasq -q --interface=$qemubr --dhcp-range=$qemubr,$ipstr,$iped,4h --conf-file=/etc/dnsmasq.conf --dhcp-broadcast
