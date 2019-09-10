# [Android_x86_6_r3](https://mirrors.xtom.com/osdn//android-x86/65890/android-x86-6.0-r3.iso)
### Installation tutorial
1. Choose Installation ...<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_01.png)
2. Choose "Create/Modify partitions"<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_02.png)
3. Choose "No", do not use GPT<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_03.png)
4. Create "New" to create a new partition<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_04.png)
5. Set partition as Primary<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_05.png)
6. Set partiton size<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_06.png)
7. Set as bootable<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_07.png)
8. Write to partition<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_08.png)
9. Enter yes to confirm<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_09.png)
10. Click "Quit" button<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_10.png)
11. Choose sda1 that we just create<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_11.png)
12. Format it as ext4<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_12.png)
13. Install system<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_13.png)
14. Install GRUB<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_14.png)
15. Set /system to read-write permission<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_15.png)
16. Reboot<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_16.png)
17. Skip network setting<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_17.png)
18. Click "SKIP ANYWAY". (If there is no network, we can restart DHCP service and VM.)<br />
![image](https://github.com/sheng9571/shenker/blob/master/qemu/android/image/android_6_18.png)
