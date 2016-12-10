# Good Xposed Framework modules:
# Hide Carrier Label, Always Expandable Notifications, YouTube AdAway, YouTube Background Playback, RootCloak.

# see free disk space on device
adb shell df
# capture screenshot
adb shell screencap -p | sed 's/\r$//' > screen.png
# get device ip
adb shell ls /sys/class/net
# get package name from apk
~/android-studio/sdk/build-tools/android-4.2.2/aapt dump badging apk-compass-sample.apk | grep package
# get current activity name
adb shell dumpsys window windows | grep -E 'mCurrentFocus|mFocusedApp'

.nomedia file prevents indexing media files in directory

# Disable camera shutter sound. Enable root first.
adb shell
su
mount -o remount,rw /system
cd /system/media/audio/ui/
mv camera_click.ogg camera_click.ogg.backup
mv camera_focus.ogg camera_focus.ogg.backup
mount -o remount,ro /system
# You can now disable root.

Speed up animations:
Enable developer mode, go to Developer options:
- Window animation scale: 0.1x
- Transition animation scale: 0.1x
- Animator duration scale: 1.0x

Download only platform tools:
https://dl.google.com/android/repository/platform-tools_r25.0.1-windows.zip

Android Studio
Ubuntu:
- Tools -> Create Desktop Entry…
Windows
- PATH: C:\Users\user\AppData\Local\Android\android-studio\sdk\platform-tools

# log text through adb
Log.d("stefan", "My string");
adb logcat -s stefan

# prepare release apk
keytool -genkey -v -keystore appname-release.keystore -alias appname-release -keyalg RSA -keysize 2048 -validity 10000
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -storepass password -keystore appname-release.keystore appname-release-unaligned.apk appname-release
jarsigner -verify myapp-release-unaligned.apk
zipalign -v 4 myapp-release-unaligned.apk myapp-release.apk

# rooting
adb reboot bootloader
fastboot devices
fastboot oem unlock
# re-enable dev options
adb reboot bootloader
fastboot flash recovery recovery-clockwork-6.0.4.7-maguro.img
# boot recovery mode
adb push cm-11-20140804-SNAPSHOT-M9-maguro.zip /sdcard/0/
adb push gapps-kk-20140606-signed.zip /sdcard/0/
# install zip: /sdcard/0/cm-11-20140804-SNAPSHOT-M9-maguro.zip

# ADT-1 enable casting from all apps (http://blakemesdag.com/blog/2014/12/08/enable-third-party-casting-on-the-adt-1/)
adb reboot bootloader
fastboot boot twrp-2.8.7.0-molly.img
adb shell mkdir /main_system
adb shell mount -o rw /dev/block/platform/sdhci-tegra.3/by-name/system /main_system
adb pull /main_system/build.prop
# change ro.build.type=eng in build.prop
adb push build.prop /main_system/build.prop
adb shell chmod 0644 /main_system/build.prop
adb reboot

# Install SuperSU on ADT-1
adb reboot bootloader
fastboot boot twrp-3.0.2-0-molly.img
adb push UPDATE-SuperSU-v2.65-20151226141550.zip /sdcard/
# now flash in TWRP using USB mouse

# Install AdAway on ADT-1 (requires root)
adb install org.adaway_54.apk
adb shell monkey -p org.adaway -c android.intent.category.LAUNCHER 1

Distance units:
px: Pixels - corresponds to actual pixels on the screen.
in: Inches - based on the physical size of the screen.
mm: Millimeters - based on the physical size of the screen.
pt: Points - 1/72 of an inch based on the physical size of the screen.
dp: Density-independent Pixels - an abstract unit that is based on the physical density of the screen. These units are relative to a 160 dpi screen, so one dp is one pixel on a 160 dpi screen. The ratio of dp-to-pixel will change with the screen density, but not necessarily in direct proportion. Note: The compiler accepts both "dip" and "dp", though "dp" is more consistent with "sp".
sp: Scale-independent Pixels - this is like the dp unit, but it is also scaled by the user's font size preference. It is recommend you use this unit when specifying font sizes, so they will be adjusted for both the screen density and user's preference.
