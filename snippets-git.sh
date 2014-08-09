git config --global user.name "Stefan Sundin"
git config --global user.email stefansundin@users.noreply.github.com
git config --global core.autocrlf false
git config --global push.default simple
git config --global core.excludesfile ~/.gitignore
git config --global core.editor 'vim -c "set mouse="'
# git config --global core.editor vim
# git config --global core.editor "subl -w"
# git config --global core.editor "sublime_text.exe -w"

# git config --global alias.yolo '!git commit -am "DEAL WITH IT!" && git push -f origin master'
git config --global alias.aliases '!git config --list | grep -v alias.aliases | grep alias. | sed -e "s/alias\.//" | cut -c 1-50 | column -s= -t | sort'
git config --global alias.b 'checkout -b'
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.cim 'commit --allow-empty-message -m ""'
git config --global alias.co checkout
git config --global alias.con 'branch -a --contains'
git config --global alias.d '!git diff HEAD~${1:-1} HEAD~$((${1:-1}-1)) ${*:2} #'
# git config --global alias.d 'diff HEAD^..HEAD'
git config --global alias.da "!git add -N . && git diff"
git config --global alias.df 'diff-tree --no-commit-id --name-only -r'
git config --global alias.di '!git diff $1^..$1 ${*:2} #'
git config --global alias.gist '!gist=$(echo $1 | sed -e "s/.*\///" -e "s/\.git$//" -e "s/#.*$//"); git clone git@gist.github.com:$gist.git "${2:-$gist}" #'
git config --global alias.kal 'difftool -y -t Kaleidoscope'
git config --global alias.l "log --pretty=format:'%C(yellow)%h%Creset %ci %<|(50)%Cred%cr%Creset %<|(70)%cn%d%n%s%n' master..HEAD"
# git config --global alias.l 'log --oneline'
git config --global alias.li '!git log $1^..$1 ${*:2} #'
git config --global alias.lo "log --pretty=format:'%C(yellow)%h%Creset %ci %<|(50)%Cred%cr%Creset %<|(70)%cn%d%n%s%n'"
git config --global alias.lom '!git fetch && git log --pretty=format:"%C(yellow)%h%Creset %ci %<|(50)%Cred%cr%Creset %<|(70)%cn%d%n%s%n" --merges HEAD..origin/`git rev-parse --abbrev-ref HEAD`'
git config --global alias.recent '!git for-each-ref --sort=-committerdate refs/heads/ | head -${*-10} #'
git config --global alias.rollback '!git reset --hard HEAD^ && git clean -fd'
git config --global alias.st status

git remote add upstream git@github.com:DrWhax/truecrypt-archive.git
git pull upstream master
git config --global --unset core.editor
git config --local user.email stefan@
git lo --before='2014-01-01'
git lo --shortstat --reverse
git log --pretty=oneline
git log --pretty=fuller
git pull --rebase
git ci --amend --author "Stefan Sundin <stefansundin@users.noreply.github.com>"
git ci --date '2013-12-26 14:30:12'

# commit with ' inside ''
git ci -m 'It'\''s annoying with quote problems.'

# see when file was deleted
git log -1 --stat -- app/assets/stylesheets/patterns/promote-video-playlist.css.scss

# search code
git lo --reverse -p -G csv_link
grep -nr --exclude-dir .git --exclude-dir log --exclude-dir tmp csv_link . | less

# view latest stashed diff without applying
git stash show -p stash@{0}

# create new orphan branch (no history)
git co --orphan license
git rm -rf *

# revert commit
git revert <hashish>
# revert merge commit
git revert -m 1 <hashish>

# gists
https://gist.github.com/stefansundin/9059706#install-pre-commit.sh
https://gist.github.com/stefansundin/d465f1e331fc5c632088#install-pre-push.sh
https://gist.github.com/stefansundin/4dbd0c4cfb75ff44ff14#git-status-rec
https://gist.github.com/stefansundin/82051ad2c8565999b914#git-bundle-hook

# vim ~/.ssh/config
# Host github
#   HostName github.com
#   User git
#   RequestTTY no
git clone github:stefansundin/altdrag.git

# create SSH key
ssh-keygen
cat .ssh/id_rsa.pub
# Windows Git Bash
# PuTTYGen → Generate → Conversions → Export OpenSSH Key → Save as %USERPROFILE%\.ssh\id_rsa
# copy public key in text box into a new SSH key on GitHub

# remove msysgit context menu entries
regsvr32 /u "C:\Program Files (x86)\Git\git-cheetah\git_shell_ext64.dll"

# diff UTF-16 files
git config --global diff.tool vimdiff
git config --global alias.dt difftool
git dt AltDrag.ini

# vimattributes; does not really work well for UTF-16 ini files, but might work for other things
# vim .vimattributes
# *.ini set diff

git diff --check --cached
# tabs as indent
git config --local core.whitespace trailing-space,space-before-tab
# spaces as indent
git config --global core.whitespace trailing-space,space-before-tab,tab-in-indent

# check if remote contains commit
git fetch -p
git fetch staging
git branch -r --contains f6a1cd7e

# regexp for lines with spaces or tabs at the end: [ \t]+$

# you committed stuff to develop which you want to branch off to master instead
git config --global alias.rebranch '!if [ $# -lt 2 ];then echo "Usage: git rebranch <new parent branch> <previous parent branch>"; exit 0; fi; git rebase --onto $1 $2 $(git rev-parse --abbrev-ref HEAD) #'
# git rebranch <new parent ancestor> <previous parent branch>
# git rebase --onto master develop feature/tooltips
# git config --global alias.rebranch 'rebase --onto $1 $2 $(git rev-parse --abbrev-ref HEAD)'

# put last commit in its own branch and reset current branch (if branching was forgotten before commit)
git br feature/fix
git reset --hard HEAD^
git co feature/fix

# if --rebase is forgotten and a merge commit happens, this is how to undo it (please backup first!)
git br rebase-backup
git reset --hard HEAD^

# get back after resetting too hard
git reflog
b3ef18e HEAD@{0}: reset: moving to HEAD^
94fb731 HEAD@{1}: reset: moving to HEAD^
git reset --hard 94fb731


# git clone specific branch
git clone -b glass-omap-xrr02 https://android.googlesource.com/kernel/omap.git
git clone -b gh-pages git@github.com:stefansundin/altdrag.git altdrag-pages

# show file from another branch
git show master:lib/tasks/deploy.rake

# show file on remote
git fetch upstream
git show upstream/master:README.md

# checkout single file from another branch
git co origin/release/v2.1.1 README.md

# list branches on remote
git ls-remote --heads production

# your branch and 'origin/feature/tooltips' have diverged,
git reset --hard origin/feature/tooltips

# working on detached branch and can't get away
git co --track -b master origin/master

# split out a subdirectory to its own branch
git checkout -b windowfinder
git filter-branch --prune-empty --subdirectory-filter windowfinder windowfinder
git push --set-upstream origin windowfinder

# delete branch
git co develop
git br -d feature/fix
git push origin :feature/fix

# delete all local branches except master
for b in `git branch | cut -b3-`; do [ "$b" == "master" ] && continue; git branch -D "$b"; done


# tags
git tag v2.1.0
git push origin v2.1.0

# create branch from tag
git checkout -b feature/v2.1.1 v2.1.0

# delete remote tag
git tag -d v2.1
git push origin :refs/tags/v2.1

# delete all local tags
for t in `git tag`; do git tag -d "$t"; done


# Rewrite history

# update all authors
NAME="Stefan Sundin" EMAIL="stefan@.com" git filter-branch --env-filter 'GIT_AUTHOR_NAME="$NAME" GIT_COMMITTER_NAME="$NAME" GIT_AUTHOR_EMAIL="$EMAIL" GIT_COMMITTER_EMAIL="$EMAIL"'

# update one author's email
NAME="Stefan Sundin" EMAIL="stefan@.com" git filter-branch --env-filter 'if [ "$GIT_AUTHOR_NAME" = "$NAME" ]; then GIT_AUTHOR_EMAIL="$EMAIL"; fi; if [ "$GIT_COMMITTER_NAME" = "$NAME" ]; then GIT_COMMITTER_EMAIL="$EMAIL"; fi'

# rebase from root
git rebase -i --root


# cleanup
du -hs .
git count-objects -vH
git fetch -p
git gc --aggressive
du -hs .
git count-objects -vH


# Hooks

# client hooks: pre-commit, prepare-commit-msg, commit-msg, post-commit, applypatch-msg, pre-applypatch, post-applypatch, pre-rebase, post-checkout, post-merge, pre-push, pre-auto-gc, post-rewrite
# server hooks: pre-receive, post-receive, update, post-update

# server post-receive hook
vim app.git/hooks/post-receive
cd /home/recover/app && env -i git pull
chmod +x app.git/hooks/post-receive

# check behind/forward in post-checkout hook
#!/bin/sh
LOCAL=$(git rev-parse @)
REMOTE=$(git rev-parse @{u})
BASE=$(git merge-base @ @{u})
if [ $LOCAL = $REMOTE ]; then
  echo "Up-to-date"
elif [ $LOCAL = $BASE ]; then
  echo "Need to pull"
elif [ $REMOTE = $BASE ]; then
  echo "Need to push"
else
  echo "Diverged"
fi


# Git errors

# failed to lock
# $ git push --set-upstream origin gorilla/cache-bug
# remote: error: failed to lock refs/heads/gorilla/cache-bug
# To git@github.com:Fullscreen/Tools.git
#  ! [remote rejected] gorilla/cache-bug -> gorilla/cache-bug (failed to lock)
# error: failed to push some refs to 'git@github.com:Fullscreen/Tools.git'
# Reason: there is a 'gorilla' branch, and thus you cannot have 'gorilla/...' branches.

# fix 'error: branch 'origin/HEAD' does not point at a commit'
# git remote set-head origin master
# Reason: this error occurs if the remote main branch is changed and the old branch is deleted (e.g. develop -> master)


# Heroku
git remote add heroku git@heroku.com:app.git
heroku run rails console

# push current branch to heroku
git push heroku HEAD:master


# SVN color diff
svn diff | view -


# convert Google Code to GitHub
# https://github.com/nirvdrum/svn2git
# list authors
svn log --quiet http://altdrag.googlecode.com/svn/ | grep -E "r[0-9]+ \| .+ \|" | cut -d'|' -f2 | sed 's/^ *//' | sort | uniq
vim ~/.svn2git/authors

mkdir altdrag
cd altdrag
svn2git -v http://altdrag.googlecode.com/svn/
cd ..
git svn clone http://altdrag.googlecode.com/svn/wiki altdrag.wiki --authors-file=$HOME/.svn2git/authors --no-metadata

# add wiki directory to master
cd altdrag
git subtree add --prefix=wiki file:///path/to/altdrag.wiki master

# setup git-subtree if you don't have it (tested on Ubuntu)
sudo chmod +x /usr/share/doc/git/contrib/subtree/git-subtree.sh
sudo ln -s /usr/share/doc/git/contrib/subtree/git-subtree.sh /usr/lib/git-core/git-subtree

# rename tags
git tag v0.1 altdrag-0.1
git tag v0.2 altdrag-0.2
git tag -d altdrag-0.1 altdrag-0.2

# push
git remote add origin git@github.com:stefansundin/altdrag.git
git push -u origin --all
git push --tags
