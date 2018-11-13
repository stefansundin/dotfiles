It does not seem to matter if `metadata.json` lists your `gnome-shell -version`.
What does matter is that the directory name exactly matches the `uuid` in `metadata.json`.

For errors, check `sudo journalctl /usr/bin/gnome-shell`.

Reload the shell by pressing Alt+F2, type `r` and then enter.

After reloading, enable the extension in _GNOME Tweaks_.
