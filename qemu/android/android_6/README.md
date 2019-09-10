# [Android_x86_6_r3](https://mirrors.xtom.com/osdn//android-x86/65890/android-x86-6.0-r3.iso)
### Installation tutorial
1. Choose Installation ...
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_01.png)
2. Choose "Create/Modify partitions"
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_02.png)
3. Choose "No", do not use GPT
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_03.png)
4. Create "New" to create a new partition
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_04.png)
5. Set partition as Primary
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_05.png)
6. Set partiton size
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_06.png)
7. Set as bootable
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_07.png)
8. Write to partition
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_08.png)
9. Enter yes to confirm
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_09.png)
10. Click "Quit" button
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_10.png)
11. Choose sda1 that we just create
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_11.png)
12. Format it as ext4
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_12.png)
13. Install system
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_13.png)
14. Install GRUB
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_14.png)
15. Set /system to read-write permission
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_15.png)
16. Reboot
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_16.png)
17. Skip network setting
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_17.png)
18. Click "SKIP ANYWAY". (If there is no network, we can restart DHCP service and VM.)
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_18.png)
