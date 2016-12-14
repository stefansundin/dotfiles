```
apm install atom-beautify auto-reveal-in-sidebar autocomplete-paths \
 blame color-picker cursor-blink-interval file-icons fonts git-time-machine highlight-nbsp highlight-selected \
 markdown-pdf merge-conflicts minimap minimap-find-and-replace minimap-git-diff minimap-highlight-selected \
 minimap-selection pretty-json regex-railroad-diagram show-origin todo-show trailing-spaces \
 travis-ci-status url-encode api-docs sort-lines
```

Mac package auto updater:
```
apm install auto-update-packages
```

Syntax highlighting:
```
apm install atom-jinja2 language-docker language-haskell language-lisp language-nginx language-nsis language-rust
```

Go packages:
```
apm install go-plus
```

Python packages:
```
pip install flake8
apm install linter-flake8
```

LaTeX packages:
```
apm install latex language-latex
```

Settings:
- Core → Ignored Names: `.git, .hg, .svn, .DS_Store, ._*, Thumbs.db, *.1, *.pyc, log, node_modules, coverage, .sass-cache, _site, public/assets, tmp/cache, venv`
- Editor → [x] Scroll Past End
- tree-view: [x] Hide Ignored Names
- bracket-matcher: Disable the package.
- autocomplete-plus: Set _Keymap For Confirming A Suggestion_ to _tab_.
- line-ending-selector: Set _Default line ending_ to _LF_.

Fix for "TypeError: Unable to watch path" in Ubuntu ([#2082](https://github.com/atom/atom/issues/2082)):
```
sudo sysctl fs.inotify.max_user_watches=32768
echo 32768 | sudo tee -a /proc/sys/fs/inotify/max_user_watches
```
Xubuntu File Manager (Thunar) right click entry on directories:
- Edit → Configure custom actions... → Add
- Name: Open Atom Here
- Command: atom %f
- Appearance Conditions: [x] Directories
