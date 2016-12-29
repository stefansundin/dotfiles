# http://pinout.xyz/
sudo raspi-config

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
