# Enable developer mode
- Hold Escape+F3 (Refresh) when powering up. Don't release power button too quickly.
- Then press Ctrl+D and enable developer mode.
- The device will be wiped on the next boot.

When in developer mode, access the shell by pressing Ctrl+Alt+F2 (Forward), login with `chronos`, then run:
```
sudo crossystem dev_boot_usb=1 dev_boot_legacy=1
```

You can now boot to USB devices. When the scary boot screen appears, boot normally using Ctrl+D, or press Ctrl+L to boot from another device.

# Misc

.Xmodmap:
https://gist.github.com/stefansundin/6987698

kbd-backlight.sh:
https://gist.github.com/stefansundin/7003429
