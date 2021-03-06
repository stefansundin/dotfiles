```
apm install stop-cursor-blinking gz-opener \
 atom-beautify autocomplete-paths blame color-picker file-icons fonts \
 git-time-machine highlight-nbsp highlight-selected markdown-pdf merge-conflicts \
 minimap minimap-find-and-replace minimap-git-diff minimap-highlight-selected minimap-selection \
 pretty-json regex-railroad-diagram show-origin todo-show trailing-spaces \
 travis-ci-status url-encode api-docs sort-lines
```

Mac package auto updater:
```
apm install auto-update-packages
```

Syntax highlighting:
```
apm install atom-jinja2 language-docker language-haskell language-lisp language-nginx \
 language-rust language-terraform language-elixir language-jsonnet language-dotenv \
 language-gnuplot-5 language-lua language-regexp language-caddyfile
```

NSIS:
```
apm install language-nsis console-panel
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

- Core → Ignored Names: `.git, .hg, .svn, .DS_Store, ._*, Thumbs.db, desktop.ini, .pc, *.1, *.pyc, log, node_modules, coverage, .sass-cache, _site, public/assets, tmp/cache, venv`
- Editor → [x] Scroll Past End
- tree-view: [x] Hide Ignored Names
- autocomplete-plus: Set _Keymap For Confirming A Suggestion_ to _tab always, enter when suggestion explicitly selected_.
- line-ending-selector: Set _Default line ending_ to _LF_.
- Disable packages: background-tips, bracket-matcher
  - This requires a restart of Atom to take full effect.

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

Make Atom automatically use YAML syntax highlighting for `*.config` files:
- Unfortunately it doesn't look possible to restrict it to specific subdirectories, e.g. `.ebextensions/*.config`. :(
- Open `config.cson` using Atom → Config... menu item
  ```
  "*":
    core:
      customFileTypes:
        "source.yaml": [
          "config"
        ]
  ```
