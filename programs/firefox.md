`about:config` tweaks:
- Disable Pocket:
  ```
  extensions.pocket.enabled = false
  ```
- Tor Browser open magnet links:
  ```
  network.protocol-handler.external-default = true
  ```
- Always show `http://` in browser URL field:
  ```
  browser.urlbar.trimURLs = false
  ```
- Disable Ctrl+Q / Command+Q shortcut: (requires restart)
  ```
  browser.quitShortcut.disabled = true
  ```

Block websites from asking to allow notifications:
1. `about:preferences#privacy`
2. Scroll down to Permissions. For Notifications, click `Settings...`.
3. Check _Block new requests asking to allow notifications_
