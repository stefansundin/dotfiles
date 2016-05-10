```
apm install activate-power-mode atom-beautify auto-reveal-in-sidebar auto-update-packages autocomplete-paths blame color-picker \
 cursor-blink-interval file-icons fonts git-time-machine highlight-nbsp highlight-selected markdown-pdf merge-conflicts \
 minimap minimap-find-and-replace minimap-git-diff minimap-highlight-selected minimap-selection pretty-json regex-railroad-diagram \
 remote-edit show-origin todo-show trailing-spaces travis-ci-status url-encode
```

Syntax highlighting:
```
apm install atom-jinja2 language-docker language-haskell language-lisp language-nginx language-nsis language-rust
```

Settings:
- Ignored Names: `log, .git, .hg, .svn, .DS_Store, Thumbs.db, node_modules, *.1, ._*, coverage, .sass-cache, _site, public/assets, tmp/cache, venv, *.pyc`
- autocomplete-plus: Set _Keymap For Confirming A Suggestion_ to _tab_.
- atom-ending-selector: Set _Default line ending_ to _LF_.

Fix for "TypeError: Unable to watch path" in Ubuntu ([#2082](https://github.com/atom/atom/issues/2082)):
```
sudo sysctl fs.inotify.max_user_watches=32768
echo 32768 | sudo tee -a /proc/sys/fs/inotify/max_user_watches
```
