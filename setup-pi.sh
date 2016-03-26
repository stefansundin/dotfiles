# http://pinout.xyz/
sudo raspi-config

# rotate display output
sudo vim /boot/config.txt
lcd_rotate=2

# change pi display brightness on boot
sudo vim /etc/rc.local
echo 90 > /sys/class/backlight/rpi_backlight/brightness 
