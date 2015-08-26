- https://yubico.com/pt
- https://developers.yubico.com/yubikey-neo-manager/Releases/
- https://developers.yubico.com/yubioath-desktop/Releases/
- https://developers.yubico.com/PGP/Importing_keys.html
- http://25thandclement.com/~william/YubiKey_NEO.html

# Setup SSH on new box

Create wrapper script `ssh-card`:
```
#!/bin/sh
exec gpg-agent --enable-ssh-support --daemon ssh "$@"
```

Then:
```
sudo apt-get install scdaemon
wget https://stefansundin.com/stefansundin-key.asc
gpg --import stefansundin-key.asc
gpg --card-status

# list keys:
gpg-agent --enable-ssh-support --daemon ssh-add -l
# list keys in authorized_keys format:
gpg-agent --enable-ssh-support --daemon ssh-add -L

chmod +x ssh-card
./ssh-card user@server.com
```

If you get a warning about the GNOME keyring ("gpg: WARNING: The GNOME keyring manager hijacked the GnuPG agent"), open Startup Applications and untick "GPG Password Agent", then run
```
killall gnome-keyring-daemon
```

