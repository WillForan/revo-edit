BL=recovery-stock.img
#BL=recovery-cwm-pr1.img

sudo adb start-server
adb push $BL /sdcard/
adb shell "su -c 'cat /dev/zero > /dev/block/mmcblk0p14'"
adb shell "su -c 'cat /sdcard/$BL > /dev/block/mmcblk0p14'"
adb shell "su -c 'md5sum /dev/block/mmcblk0p14'"

#REVO STOCK
#0df0ee2ccf359945d8f0029a2ffa29cd  /dev/block/mmcblk0p14

#CWM pr1
#a1c61d06fa0f029411cf4cde44639b3f  /dev/block/mmcblk0p14



