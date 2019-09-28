#!/bin/sh
qemubr=br0
device=$(ip route show default | grep src | awk '/.*/ {print $3}')
addr=$(ip route show default | grep src | awk '/.*/ {print $NF}')
mask=$(/sbin/ifconfig $device | grep Mask | cut -d":" -f4)
gw=$(ip route show default | grep via | awk '/.*/ {print $3}')
ipstr=$(echo $addr | cut -d"." -f-1,2,3).$(expr $(echo $addr | cut -d"." -f4) + 40)
iped=$(echo $addr | cut -d"." -f-1,2,3).$(expr $(echo $addr | cut -d"." -f4) + 44)

# add a new bridge interface
# set current default interface slave to the new bridge
sudo ip link add $qemubr type bridge
sudo ip link set dev $device master $qemubr

# add some info to /etc/network/interfaces
sudo echo -e "\n" >> /etc/network/interfaces
sudo echo "auto $qemubr" >> /etc/network/interfaces
sudo echo "iface $qemubr inet static" >> /etc/network/interfaces
sudo echo "address $addr" >> /etc/network/interfaces
sudo echo "netmask $mask" >> /etc/network/interfaces
sudo echo "gateway $gw" >> /etc/network/interfaces
sudo echo "bridge_ports $device" >> /etc/network/interfaces
sudo echo "bridge_stp off" >> /etc/network/interfaces
sudo echo "post-up echo 1 > /proc/sys/net/ipv4/ip_forward" >> /etc/network/interfaces
sudo echo "post-up iptables -A INPUT -i tap0 -j ACCEPT" >> /etc/network/interfaces
sudo echo "post-up iptables -A INPUT -i $qemubr -j ACCEPT" >> /etc/network/interfaces
sudo echo "post-up iptables -A FORWARD -i $qemubr -j ACCEPT" >> /etc/network/interfaces
sudo echo "post-up iptables -t nat -A POSTROUTING -o $qemubr -j MASQUERADE" >> /etc/network/interfaces
sudo echo "post-down iptables -D INPUT -i tap0 -j ACCEPT" >> /etc/network/interfaces
sudo echo "post-down iptables -D INPUT -i $qemubr -j ACCEPT" >> /etc/network/interfaces
sudo echo "post-down iptables -D FORWARD -i $qemubr -j ACCEPT" >> /etc/network/interfaces
sudo echo "post-down iptables -t nat -D POSTROUTING -o $qemubr -j MASQUERADE" >> /etc/network/interfaces
# sudo echo "dns-nameservers 8.8.8.8 8.8.4.4" >> /etc/network/interfaces


# flush current ip and restart network service and interfaces
sudo ip addr flush $device
sudo ifconfig $device down
sudo ifconfig $qemubr down
sudo ifconfig $device up
sudo ifconfig $qemubr up
sudo service networking restart


# set-up dhcp server
sudo echo "interface=$qemubr" >> /etc/dnsmasq.conf
sudo echo "dhcp-range=$qemubr,$ipstr,$iped,4h" >> /etc/dnsmasq.conf
sudo service dnsmasq stop
sleep 2
sudo dnsmasq -q --interface=$qemubr --dhcp-range=$qemubr,$ipstr,$iped,4h --conf-file=/etc/dnsmasq.conf --dhcp-broadcast
