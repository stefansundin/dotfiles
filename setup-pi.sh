# http://pinout.xyz/
sudo raspi-config
# enable ssh on boot with Interfacing options -> ssh -> Enable

# do not wait forever for the network on boot
sudo vim /etc/systemd/system/network-online.targets.wants/networking.service
# lower TimeoutStartSec

# disable wifi power management (for more stable wifi)
sudo vim /etc/network/interfaces
iface wlan0 inet manual
    wireless-power off

# 7 inch display GPIO: https://www.modmypi.com/image/data/tutorials/raspberry-pi-7-touch-screen-assembly-guide/16.jpg
# Red    – 5V  - Pin 2
# Black  – GND - Pin 6
# Green  – SDA - Pin 3
# Yellow – SCL - Pin 5

# rotate display output
sudo vim /boot/config.txt
lcd_rotate=2

# change pi display brightness on boot
sudo vim /etc/rc.local
echo 90 > /sys/class/backlight/rpi_backlight/brightness

# RTC
sudo vim /boot/config.txt
dtoverlay=i2c-rtc,ds3231
sudo reboot
# optional:
echo i2c-dev | sudo tee -a /etc/modules
sudo modprobe i2c-dev
sudo apt install i2c-tools
sudo i2cdetect -y 1
# remove fake-hwclock
sudo apt-get -y remove fake-hwclock
sudo update-rc.d -f fake-hwclock remove
sudo vim /lib/udev/hwclock-set
# comment out the following:
#if [ -e /run/systemd/system ] ; then
# exit 0
#fi

# read from hwclock
sudo hwclock -r
# write system time to hwlock
sudo hwclock -w
