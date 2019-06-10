nc -vz stefansundin.com 443
sudo tcpdump -i eth0 port not 22
ps aux --sort -rss
sudo du -h --max-depth=1
rsync -avrt --size-only --noatime --progress --exclude Thumbs.db --exclude .DS_Store --exclude '._*' --exclude '*.part' /home/user/dir/ /mnt/disk1/dir/

# listen on port and print information about who connected
netcat -v -l 9999
# connect to the above server from another computer
nc -vz 52.144.75.35 9999

# see what files a process is opening
ps aux | grep unicorn
sudo strace -s 1024 -e stat -p 2876

# print distro version
lsb_release -a
cat /etc/issue

# search
find . -not -readable
find . -not -user root
find . -type f | wc -l
find . -type f -size +10000k -exec ls -lh {} \; | awk '{ print $9 ": " $5 }'

# search and delete
find . -type f -name '._*' -delete
find . -type f -name 'Thumbs.db' -delete
find . -type f -name '.DS_Store' -delete

# find git repositories that need to run 'git gc'
find . -type f | grep .git/objects | grep -v pack

# grep log without phrase
cat /var/log/nginx/error.log | grep -v FastCGI | less
zcat /var/log/nginx/error.log.2.gz | grep -v FastCGI | less
zless /var/log/nginx/error.log.2.gz

# trigger logrotate
sudo logrotate --force /etc/logrotate.d/nginx

# find string inside directory
grep -nr Link* .

# find file with name
find / -iname '*truecrypt*'

# find files writable by user
sudo -u man find / -writable 2>/dev/null

# handy directories
/var/spool/cron/crontabs

# drop caches
echo 3 | sudo tee /proc/sys/vm/drop_caches

# streams
# use less on stderr
~/verify-sigs.sh 2>&1 | less
# output all streams to file
~/verify-sigs.sh &>signatures.txt
grep print context:
ifconfig | grep inet -C2

# scp
scp file.png user@example.com:www/
scp file.png server:www/
scp file.png server:
scp user@example.com:file.png .
scp -o ProxyJump=bastion.example.com file.zip 10.10.1.5:
rsync -av -e 'ssh -o ProxyJump=bastion.example.com' file.zip 10.10.1.5:
scp -r server:files/directory .
rsync -avt --size-only --append-verify --progress --bwlimit=4000 server:files/directory .

# print /proc/<pid>/environ with nice newlines
sudo cat /proc/7072/environ | xargs -n 1 -0

# source KEY=VALUE file and export variables
set -a
source file.env
set +a

# check SSH versions
ssh -V
sshd -V
telnet localhost 22

# list iptables rules
sudo iptables -L
# block access to 169.254.169.254 except by root
sudo iptables -A OUTPUT -d 169.254.169.254 -m owner \! --uid-owner root -j DROP
# flush iptables
sudo iptables -F

# bash script print each command
#!/bin/bash -ex

# bash ping loop
while true; do date; time curl -s -I http://example.com/ | grep real; echo; sleep 1; done

# mount Bitlocker encrypted drive
sudo apt-get install dislocker
sudo mkdir /media/{dislocker,bitlocker}
sudo dislocker -V /dev/sdc1 -u"password" -- /media/dislocker
sudo mount -o loop /media/dislocker/dislocker-file /media/bitlocker

# mount VirtualBox shared folder (create vboxshare on host and configure in settings)
mkdir share
sudo mount -t vboxsf -o uid=$UID vboxshare share

# smartctl
sudo apt install smartmontools
sudo smartctl -i /dev/sdb > sdb-info.txt
sudo smartctl -a /dev/sdb > sdb-smart.txt
sudo smartctl -c /dev/sdb > sdb-capabilities.txt
# read attributes, including Load_Cycle_Count (LCC)
sudo smartctl -A /dev/sdb > sdb-attributes.txt
# short test:
sudo smartctl -t short /dev/sdb
# check if test is done with: sudo smartctl -a /dev/sdb
sudo smartctl -a /dev/sdb > sdb-short-test.txt
# long test:
#sudo smartctl -t long /dev/sdb > sdb-long-test.txt # this will take a very long time (check sdb-capabilities.txt)!

# format partition as FAT32 with 64k cluster size (128*512)
sudo mkfs.fat /dev/sdXX -s 128 -F 32 -n "label"
# exFAT:
sudo mkfs.exfat /dev/sdXX -n "label"
sudo fsck.exfat /dev/sdXX

# create user wordpress
useradd wordpress
# add user wordpress to group www-data
usermod -a -G www-data wordpress
# list groups a user is in
groups wordpress
# list users in a group
getent group www-data

# debug daemons
strace -ff -ewrite -s200 lighttpd
-s determines how much to get.
# example
ps aux | grep python
root       912  1.5  2.3  55896  8828 ?        Sl   May21 696:36 python /home/stefan/card.py
sudo strace -ff -ewrite -s200 -p 912
# for some reason this does not seem to work...

# dd status
sudo killall -s USR1 dd

# reload inetd.conf
sudo killall -HUP inetd

# force ntp update
sudo service ntp stop
sudo ntpd -gq
sudo service ntp start

# find files newer than date
touch -t 201306011010 dummy
# YYYYMMDDHHII
find -newer dummy -type f

# convert *.z64 to n64
for f in *.z64; do zcat "$f" > "${f%.*}.n64"; done

# process monitoring
ps -C <program> -o %cpu,%mem,pid,cmd
top -p <pid>
# list processes based on memory usage
ps -e -orss=,args= | sort -b -k1,1n | pr -TW$COLUMNS

# redis auth
grep requirepass /etc/redis/redis.conf
redis-cli -a password

# make unified patch between directories
diff -urN truecrypt-7.1a-source truecrypt-7.1a-indicator > truecrypt-7.1a-indicator.patch
# apply patch
patch -p1 < truecrypt-7.1a-indicator.patch
# revert patch
patch -p1 -R < truecrypt-7.1a-indicator.patch

# use wget to mirror across domains
wget -r -m --restrict-file-names=windows --domains mastermind.atavist.com,atavist-assets.s3.amazonaws.com,atavist-static.s3.amazonaws.com,dh1rvgpokacch.cloudfront.net https://mastermind.atavist.com/

# use wget to download all linked 7z files
wget -r -l1 -H -t1 -nd -N -np -erobots=off -A 7z https://code.google.com/p/altdrag/downloads/list?can=1

# use wget to mirror website that needs login
wget --delete-after --keep-session-cookies --save-cookies cookies.txt --post-data 'user[email]=stefan@example.com&user[password]=test' http://legacy-app.dev/users/sign_in
wget -erobots=off --load-cookies cookies.txt -mk http://legacy-app.dev/

# to remove the x flag on every file recursive but not touching the directories
find -type f -exec chmod -x {} \;
# useful when trading files with an NTFS partition (so GNOME won't bug you every time you try to open a file)
# chmod rwx 421: 4+2+1=7

# remount filesystem as read-write
sudo mount -o remount,rw /media/test

# set default keyboard layout
sudo dpkg-reconfigure keyboard-configuration

# make Ctrl+D not exit terminal
vim .bashrc
export IGNOREEOF=5
# default editor
export EDITOR='subl -w'

# remap or disable Ctrl+C (for session)
# remap to Ctrl+_
stty intr '^_'
# disable Ctrl+C
stty -intr ''
# reset all settings to default
stty sane

# .bashrc
# Disable XOFF (Ctrl+S in PuTTY, XON is Ctrl+Q)
stty ixany
stty ixoff -ixon
stty stop undef
stty start undef

# kill pry-remote connections
lsof -i tcp:9876 | awk 'NR!=1 {print $2}' | xargs kill
# kill redis connections
lsof -i tcp:6379 | awk 'NR!=1 {print $2}' | xargs kill
# kill postgres connections
lsof -i tcp:5432 | awk 'NR!=1 {print $2}' | xargs kill


# gpg
gpg --gen-key
# enter,enter,enter,y,Stefan Sundin,stefan@example.com,enter,o,password,password
gpg --fingerprint
# pub   2048R/27642822 2013-06-24
#       Key fingerprint = 7301 7A35 249F 746F F6FF  91D2 7FA5 D4DA 2764 2822
# uid                  Stefan Sundin <stefan@example.com>
# sub   2048R/B33AD7AA 2013-06-24
gpg --export -a "Stefan Sundin" > stefansundin.asc
gpg --import TrueCrypt-Foundation-Public-Key.asc
gpg --edit-key "TrueCrypt Foundation" trust quit
# sign and verify a file
gpg -b SuperF4-1.1.exe
gpg -v SuperF4-1.1.exe.sig

# export keypair
gpg --output stefansundin_pub.gpg --armor --export "Stefan Sundin"
gpg --output stefansundin_sec.gpg --armor --export-secret-key "Stefan Sundin"
# import on another computer
gpg --import stefansundin_pub.gpg
gpg --allow-secret-key-import --import stefansundin_sec.gpg
gpg --edit-key "Stefan Sundin" trust quit

# print secret key with paperkey
gpg --no-armor --export-secret-key 27642822 | paperkey -o secret.txt
gpg --no-armor --export-secret-key 27642822 | paperkey --output-type raw | base64 | qrencode -lM -o secret.png
# import paperkey'd private key (requires public key)
gpg --recv-key 27642822
paperkey --pubring ~/.gnupg/pubring.gpg < secret.txt
cat qr.txt | base64 -D | paperkey --pubring ~/.gnupg/pubring.gpg

# decrypt message
gpg -d
# paste message, end with Ctrl+D (may be needed twice, be careful: one time too much will close the terminal).


# verify signatures with gpg
gpg --import < TrueCrypt-Foundation-Public-Key.asc
gpg --edit-key "TrueCrypt Foundation" trust quit
gpg --verify truecrypt-7.1a-linux-console-x64.tar.gz.sig truecrypt-7.1a-linux-console-x64.tar.gz
# script to mass-verify .sig files
#!/bin/bash -ex
for f in *.sig; do
  echo gpg --verify \"$f\" \"${f%.*}\"
  gpg --verify "$f" "${f%.*}"
  echo
done


# SSH keys
ssh-keygen -C "stefan@example.com"
# add new key
ssh-add
# copy key to remote SSH host
ssh-copy-id -i .ssh/id_rsa.pub stefan@example.com
ssh stefan@example.com
# copy id_rsa.pub to e.g. GitHub
sudo apt-get install xclip
xclip -sel clip < .ssh/id_rsa.pub
# add passphrase to unencrypted private key
ssh-keygen -p -f .ssh/id_rsa
# print key fingerprints
ssh-add -l
> 4096 SHA256:Ggh3YhpX3lSsAdfDW1/1e7gXNRmNZM9tCccXIWDCdN8 stefan@example.com (RSA)
# print MD5 fingerprint
ssh-add -l -E md5
> 4096 MD5:83:af:3d:0b:bf:f6:43:99:2c:47:32:4f:66:a7:33:b6 stefan@example.com (RSA)
# export card public key
ssh-add -L
# export public key from private key
ssh-keygen -yf private-key.pem > public-key.txt
# print fingerprint from public/private key file
ssh-keygen -lf public-key.txt -E md5

# unblock card PIN with PUK
gpg --card-edit
gpg/card> admin
gpg/card> passwd
Your selection? 2


# create restricted ssh user for SOCKS with keylogin only
# generate multiple keys for easy revoking
sudo useradd -m -s /bin/bash tunnel
sudo su tunnel
cd
ssh-keygen
echo -n 'no-pty,no-X11-forwarding,command="echo Hello!;read a;exit" ' | cat - .ssh/id_rsa.pub >> .ssh/authorized_keys
# copy id_rsa (private key), use PuTTYgen (Conversions → Import key), save PuTTY private key (tunnel.ppk)
# open PuTTY, setup key auth in Connection → SSH → Auth. Setup tunnel in SSH → Tunnel (Source port and Dynamic). Save 'tunnel' profile.
# shortcut to PuTTY: putty.exe @tunnel


# open SOCKS5 tunnel
# http://linux.die.net/man/5/ssh_config
sudo vim /etc/ssh/ssh_config
ServerAliveInterval 30

vim .ssh/config
# ssh -C -D 4045 stefan@example.com
Host example
  HostName example.com
  User stefan
  DynamicForward 4045

vim open-socks.sh && chmod +x open-socks.sh
#!/bin/bash
if ps aux | grep -q '[s]sh -f -N -C -D 4045 stefan@example.com'; then
  echo The SSH tunnel is already open.
  exit 1
fi
ssh -f -N -C -D 4045 stefan@example.com

# see failed SSH logins
cat /var/log/auth.log | grep 'sshd.*Invalid'
# successful logins
cat /var/log/auth.log | grep 'sshd.*opened'


# inspect ssl cert and csr
openssl x509 -in cert.crt -text -noout
openssl req -in cert.csr -text -noout


# create secure boot MOK key and sign kernel modules:
openssl req -new -x509 -newkey rsa:2048 -keyout MySecureBoot.priv -outform DER -out MySecureBoot.der -nodes -days 36500 -subj "/CN=MySecureBoot/"
sudo mokutil --import MySecureBoot.der
# the password it asks you for is simply the password you have to enter in your UEFI when accepting the new key. reboot and do that now. this is a one-time operation on the current machine.
# sign all the modules you need:
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MySecureBoot.priv ./MySecureBoot.der $(modinfo -n vboxdrv)
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MySecureBoot.priv ./MySecureBoot.der $(modinfo -n vboxnetflt)
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MySecureBoot.priv ./MySecureBoot.der $(modinfo -n vboxnetadp)
sudo /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 ./MySecureBoot.priv ./MySecureBoot.der $(modinfo -n vboxpci)
sudo modprobe vboxdrv vboxnetflt vboxnetadp vboxpci

# disable "Disable Secure Boot?" prompt
echo dkms dkms/disable_secureboot boolean false | sudo debconf-set-selections


# disable .bash_history and .lesshst
vim .bashrc
unset HISTFILE
export LESSHISTFILE=-
unset HISTFILE
export LESSHISTFILE=-
rm .bash_history .lesshst


# change hostname
sudo vim /etc/hostname
pi
sudo vim /etc/hosts


# add swapfile
cd /
sudo fallocate -l 2g swapfile
sudo chmod 600 swapfile
sudo mkswap swapfile
sudo swapon swapfile
sudo vim /etc/fstab
/swapfile  none  swap  sw  0 0


# temperature
sudo apt-get install lm-sensors
sudo sensors-detect
sudo vim /etc/modules
coretemp #or whatever it told you
sudo modprobe coretemp
sensors


# update grub resolution
# stop boot at grub, run command 'vbeinfo' and note appropriate resolution
sudo vim /etc/default/grub && sudo update-grub
GRUB_GFXMODE=1280x850

# when acpid does not fully shut down computer
sudo vim /etc/default/grub
GRUB_CMDLINE_LINUX="acpi=force"
sudo update-grub


# disable power button prompt in GNOME
gsettings set org.gnome.settings-daemon.plugins.power button-power 'shutdown'
# or configure in GNOME Tweak Tool
sudo apt-get install gnome-tweak-tool
gnome-tweak-tool


# TrueCrypt command line mount
# add devices to favorites first, then edit mount point manually
vim .TrueCrypt/Favorite\ Volumes.xml
vim mount-tc.sh
sudo truecrypt -t -k "" --protect-hidden=no --auto-mount=favorites
vim umount-tc.sh
sudo truecrypt -d
chmod +x {,u}mount-tc.sh


# fix time conflict between Linux and Windows
sudo vim /etc/default/rcS
UTC=no
# or in Windows (must run elevated!)
reg add HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /t REG_DWORD /d 1 /f & pause
# to revert
reg delete HKLM\SYSTEM\CurrentControlSet\Control\TimeZoneInformation /v RealTimeIsUniversal /f & pause


# mount CIFS
vim mount-lan.sh && chmod +x mount-lan.sh
#!/bin/sh -ex
mountpoint -q /home/stefan/watch || mount -t cifs //computer-PC/watch /home/stefan/watch -o ro,username=stefan,password=password
exit 0

vim /etc/network/if-up.d/cifs && chmod +x /etc/network/if-up.d/cifs
#!/bin/sh
(sleep 5 ; /home/stefan/mount-lan.sh)&
exit 0

vim mount-PC.sh && chmod +x mount-PC.sh
read -p "What share do you want to mount? " share
echo "//computer-PC/$share"
sudo mount -t cifs -o username=stefan,password=password "//computer-PC/$share" /home/stefan/watch


# wifi command line
sudo apt-get install wireless-tools
sudo iwlist wlan0 scan

wpa_passphrase "wifi name" password | sudo tee /etc/wpa_supplicant.conf
# network={
#       ssid="sundin router"
#       #psk="password"
#       psk=passwordhash
# }

sudo vim /etc/network/interfaces
auto wlan0
iface wlan0 inet dhcp
wpa-driver wext
wpa-conf /etc/wpa_supplicant.conf
allow-hotplug wlan0
#iface wlan0 inet manual
#wpa-roam /etc/wpa_supplicant/wpa_supplicant.conf
iface default inet dhcp


# mpd
mkdir -p .mpd/playlists
sudo vim /etc/mpd.conf && mpc update
music_directory "/home/stefan/music"
playlist_directory "/home/stefan/.mpd/playlists"
db_file "/home/stefan/.mpd/tag_cache"
log_file "/home/stefan/.mpd/mpd.log"
pid_file "/home/stefan/.mpd/pid"
state_file "/home/stefan/.mpd/state"
sticker_file "/home/stefan/.mpd/sticker.sql"
user "stefan"
bind_to_address "any"


# install Java from java.com
xdg-open http://www.oracle.com/technetwork/java/javase/downloads/index.html
# API docs
xdg-open http://www.oracle.com/technetwork/java/javase/documentation/java-se-7-doc-download-435117.html
sudo mkdir /usr/java
sudo tar xzf jre-7u55-linux-x64.tar.gz -C /usr/java
sudo tar xzf jdk-7u55-linux-x64.tar.gz -C /usr/java
sudo vim /etc/profile
# Java
JAVA_HOME=/usr/java/jdk1.7.0_55
JRE_HOME=/usr/java/jre1.7.0_55
PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
export JAVA_HOME
export JRE_HOME
export PATH

# if updating
sudo update-alternatives --remove-all java
sudo update-alternatives --remove-all javac
sudo update-alternatives --remove-all javaws

sudo update-alternatives --install /usr/bin/java java /usr/java/jre1.7.0_55/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/java/jdk1.7.0_55/bin/javac 1
sudo update-alternatives --install /usr/bin/javaws javaws /usr/java/jre1.7.0_55/bin/javaws 1
. /etc/profile
java -version

sudo mkdir /opt/google/chrome/plugins
sudo ln -sf /usr/java/jre1.7.0_55/lib/amd64/libnpjp2.so /opt/google/chrome/plugins/libnpjp2.so
sudo ln -sf /usr/java/jre1.7.0_55/lib/amd64/libnpjp2.so /usr/lib/mozilla/plugins/libnpjp2.so
