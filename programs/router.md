Tomato by Shibby: http://tomato.groov.pl/

### Block TWC NXDOMAIN hijacks

Advanced → DHCP/DNS → dnsmasq custom configuration:
```
# stupid time warner cable dns hijacking
bogus-nxdomain=198.105.244.228

# block Wii U updates
address=/nus.c.shop.nintendowifi.net/127.0.0.1
address=/nus.cdn.c.shop.nintendowifi.net/127.0.0.1
address=/nus.cdn.shop.wii.com/127.0.0.1
address=/nus.cdn.wup.shop.nintendo.net/127.0.0.1
address=/nus.wup.shop.nintendo.net/127.0.0.1
address=/c.shop.nintendowifi.net/127.0.0.1
address=/cbvc.cdn.nintendo.net/127.0.0.1
address=/cbvc.nintendo.net/127.0.0.1
address=/pushmore.wup.shop.nintendo.net/127.0.0.1
address=/gonintendo.us.intellitxt.com/127.0.0.1
address=/metrics.nintendo.com/127.0.0.1
address=/nintendo-gamers.com/127.0.0.1
address=/www.nintendo-gamers.com/127.0.0.1

# block ad-serving domain names
# upload file to pastebin and download with:
# ssh root@192.168.1.1
# wget -O /tmp/dnsmasq-adblock.conf http://pastebin.com/raw/mwnDATf5
conf-file=/tmp/dnsmasq-adblock.conf
```
