
cat <<EOF
[*] LG Revolution Root & CWM Install Script
[*] Exploit copyright (C) 2011 Revolutionary
[*] Scripting for LG Esteem by Dan Rosenberg (@djrbliss)
[*] Re-Done for LG Revolution with CWM by Matt Michaelson (@mtmichaelson)
[*] Before continuing, ensure USB debugging is enabled, that you
[*] have the latest LG drivers installed, and that your phone is
[*] connected via USB.
[*]
[*] Press enter to root your phone...
EOF
read
#echo "[*] Waiting for device..."
#adb kill-server
#adb wait-for-device 
#echo "[*] Device found."


#echo "[*] Pusing clockwork recovery"
#adb push cwmrecovery.img /data/local/tmp/cwmrecovery.img




sudo adb start-server

echo "[*] Pushing exploit binary..."
adb shell mkdir /data/local/tmp/
adb push zergrush /data/local/tmp/zergrush

echo "[*] Setting as executable..."
adb shell "chmod 755 /data/local/tmp/zergrush"


echo "[*] Running exploit..."
adb shell "echo exit | /data/local/tmp/zergrush"

echo "[*] Installing root tools..."
adb shell /data/local/tmp/sh -c "mount -orw,remount /dev/block/system /system"
adb shell /data/local/tmp/sh -c "mount -orw,remount /dev/block/data /data"
adb shell /data/local/tmp/sh -c "rm /system/bin/su"
adb shell /data/local/tmp/sh -c "rm /system/xbin/su"
adb shell /data/local/tmp/sh -c "rm /system/app/Superuser.apk"
adb shell /data/local/tmp/sh -c "rm /system/xbin/busybox"
adb shell /data/local/tmp/sh -c "rm /system/tmp/su"
adb shell /data/local/tmp/sh -c "rm /system/tmp/busybox"
adb shell /data/local/tmp/sh -c "rm /system/tmp/Superuser.apk"
adb shell /data/local/tmp/sh -c "rm /system/etc/install-recovery.sh"
adb shell /data/local/tmp/sh -c "rm /system/recovery-from-boot.p"
adb shell /data/local/tmp/sh -c "rmdir /system/tmp"
adb shell /data/local/tmp/sh -c "mkdir /system/tmp"
adb shell /data/local/tmp/sh -c "chmod 777 /system/tmp"
adb push su /system/tmp/su
adb push busybox /system/tmp/busybox
adb push Superuser.apk /system/tmp/Superuser.apk
adb shell /data/local/tmp/sh -c "mv /system/tmp/su /system/xbin/su"
adb shell /data/local/tmp/sh -c "mv /system/tmp/Superuser.apk /system/app/Superuser.apk"
adb shell /data/local/tmp/sh -c "mv /system/tmp/busybox /system/xbin/busybox"
adb shell /data/local/tmp/sh -c "chown root /system/xbin/su"
adb shell /data/local/tmp/sh -c "chmod 4755 /system/xbin/su"
adb shell /data/local/tmp/sh -c "ln -s /system/xbin/su /system/bin/su"
adb shell /data/local/tmp/sh -c "chmod 755 /system/xbin/busybox"
adb shell /data/local/tmp/sh -c "/system/xbin/busybox --install /system/xbin/"

#opps already lost this!
#echo "[*] Backing Up Stock Recovery.img to SDCard..."
#adb shell /data/local/tmp/sh -c "dd if=/dev/block/mmcblk0p14 of=/sdcard/mmcblk0p14.backup bs=4096"

#already installed
#echo [*] Installing CWM...
#adb shell /data/local/tmp/sh -c "dd if=/data/local/tmp/cwmrecovery.img of=/dev/block/mmcblk0p14 bs=4096"

echo "[*] Cleaning up..."
adb shell /data/local/tmp/sh -c "rmdir /system/tmp"
adb shell "rm /data/local/tmp/* 2>/dev/null"

echo "[*] Rebooting..."
adb reboot

adb wait-for-device
adb kill-server
echo "[*] Root complete, enjoy!"
