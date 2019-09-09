# Run Android VM in Docker
## Use noVNC to control VM via web interface
### Implementation:
1. First we create bridge interface called "br0", and set it as master to "eth0" ( default netowrk interface in  docker container).
2. Flush "eth0" IP address
3. Add some informations that belongs to "br0" to /etc/network/interfaces
4. Add iptables rules to /etc/network/interfaces
5. Stop interface "eth0" and "br0"
6. Start interace "eth0" and "br0"
7. Restart networkint service
8. Start DHCP server (dnsmasq) on "br0" and set dhcp-ip-range

All steps below are contain in [network.sh](https://github.com/sheng9571/shenker/blob/master/qemu/android/android_8.1/network.sh)
### Usage:
```
docker-compose up -d
```

### Connect to web interface:
```
# the port 9287 can edit it in docker-compose.yml file
xxx.xxx.xxx.xxx:9287
```


### Interactive with the container:
```
# xxxx represents the name of the container
docker exec -it xxxx /bin/bash
```
### Some useful tool-kits
* vnc service
    * start vnc service
        ``` vnc_start.sh ```
    * stop vnc service
        ``` vnc_stop.sh ```
    * restart vnc service
        ``` vnc_restart.sh ```
* DHCP service
    * start DHCP service
        ``` dhcp_start.sh ```
    * stop DHCP service
        ``` dhcp_stop.sh ```
    * restart DHCP service
        ``` dhcp_restart.sh ```
* VM
    * start VM
        ``` vm_start.sh ```
    * stop VM
        ``` vm_stop.sh ```
    * restart VM
        ``` vm_restart.sh ```
* Get IP that belogs to specific VM
    ```
    vm_ip
    ```
* Install specific APK to specific VM
    ```
    # install fackbook apk to android VM
    example:
    adbi facebook.apk

    # if privious commands failed, we can try another one:
    # xxx.xxx.xxx.xxx is the ip address belongs the VM
    adb kill-server
    adb connect xxx.xxx.xxx.xxx:5555
    adb install facebook.apk
    adb kill-server
    ```
