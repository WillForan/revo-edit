sudo adb start-server

echo "[*] Pushing exploit binary..."
adb push zergrush /data/local/tmp/zergrush
adb shell "chmod 755 /data/local/tmp/zergrush"

echo "[*] Running exploit..."
adb shell "echo exit | /data/local/tmp/zergrush"

echo [*] Removing root tools... 
adb shell /data/local/tmp/sh -c "mount -orw,remount /dev/block/system /system"
adb shell /data/local/tmp/sh -c "mount -orw,remount /dev/block/data /data"
adb shell /data/local/tmp/sh -c "rm /system/bin/su"
adb shell /data/local/tmp/sh -c "rm /system/xbin/su"
adb shell /data/local/tmp/sh -c "rm /system/app/Superuser.apk"
adb shell /data/local/tmp/sh -c "rm /system/xbin/busybox"
adb shell /data/local/tmp/sh -c "rm /system/tmp/su"
adb shell /data/local/tmp/sh -c "rm /system/tmp/busybox"
adb shell /data/local/tmp/sh -c "rm /system/tmp/Superuser.apk"
adb shell /data/local/tmp/sh -c "rmdir /system/tmp"
adb shell /data/local/tmp/sh -c "rmdir /system/tmp"
adb shell "rm /data/local/tmp/* 2>/dev/null"

#echo [*] Installing Stock Recovery...
#adb push stockrecovery.img /data/local/tmp/stockrecovery.img
#adb shell /data/local/tmp/sh -c "dd if=/data/local/tmp/stockrecovery.img of=/dev/block/mmcblk0p14 bs=4096"

echo [*] Rebooting...
adb reboot

adb wait-for-device
echo "[*] Unroot finished!"
EOF
