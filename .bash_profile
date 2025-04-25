start=`gdate +%s.%N`

# Put custom stuff here:



##########################

# https://github.com/stefansundin/dotfiles/blob/master/.bash_profile
ulimit -Sn 4096
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export IGNOREEOF=5
unset HISTFILE
export LESSHISTFILE=-
HISTCONTROL=ignoredups
export TERM=xterm-256color
# export PS0='Command started: \t\n'

# xterm-256color removes the color over ssh on some machines
alias ssh='TERM=xterm-color ssh'
alias gpg="gpg2"
alias ls="ls -G"
alias pc="pngcrush -rem gAMA -rem cHRM -rem iCCP -rem sRGB -brute"
alias truecrypt='truecrypt -t'
alias yt=yt-dlp
alias upgrade-yt='pip3 install --upgrade yt-dlp'
alias reload_profile="source ~/.profile"

#export EDITOR='subl -w'
export EDITOR=vim
export VISUAL=vim
export BUNDLER_EDITOR=subl
export HOMEBREW_EDITOR=subl
# Ubuntu:
# sudo update-alternatives --config editor
# Select vim.basic (which is normal vim)

function rs {
  # --bwlimit=10000
  rsync -avrt \
    --size-only \
    --progress \
    --partial \
    --exclude Thumbs.db --exclude .DS_Store --exclude Sample \
    --exclude '._*' --exclude '*.part' --exclude '*.meta' \
    "$@"
}

# Bash completion
[[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && source "/opt/homebrew/etc/profile.d/bash_completion.sh"
# _complete_alias support:
# wget -O ~/.bash_completion https://raw.githubusercontent.com/cykerway/complete-alias/master/completions/bash_completion.sh


# Mac
# eval "$(/opt/homebrew/bin/brew shellenv)"
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_BOTTLE_SOURCE_FALLBACK=1
export HOMEBREW_DEVELOPER=1 # enables "unknown" status in "brew services"
alias brew-clean='brew cleanup --prune=0'
alias flushdns='dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias ls="/usr/local/opt/coreutils/libexec/gnubin/ls -G -N --color=auto --quoting-style=escape"
alias cal='gcal --starting-day=1'
eval "$(/usr/local/opt/coreutils/libexec/gnubin/dircolors ~/.dircolors)"
alias dircolors="/usr/local/opt/coreutils/libexec/gnubin/dircolors"
# Docker
source /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion
source /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion
export DOCKER_CLI_HINTS=false

export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
# export PATH="$HOME/Library/Android/sdk/platform-tools:$HOME/Library/Android/sdk/tools:$PATH"


# Git

function cd {
  builtin cd "$@"
  echo -n -e "\033]0;$(git config --get remote.origin.url | sed -e 's/.*[\/|:]//' -e 's/\.git$//')\007";
}

function git_branch {
  git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -e 's/\(.*\)/ \[\1\]/'
}

function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local     DEFAULT="\[\033[0m\]"
  # PS1="$LIGHT_GREEN\h:\u:$RED\W$BLUE\$(git_branch) $DEFAULT\$ "
  PS1="$LIGHT_GREEN\u$DEFAULT:$RED\W$BLUE\$(git_branch) $DEFAULT\$ "
}
proml


# PostgreSQL
# https://www.postgresql.org/docs/current/libpq-envars.html
export PGTZ=PST8PDT
export PGSERVICE=localhost


# Python
# Set up pip venv by running:
# python3 -m venv ~/.pip --system-site-packages
export PATH="$HOME/.pip/bin:$PATH"


# Go
export PATH="$HOME/go/bin:$PATH"


# Ruby
# eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
# export RAILS_ENV=development
# export RACK_ENV=development

# auto bundle exec
function use_bundler {
  if [ -r ./Gemfile ]; then
    bundle exec $@
  else
    $@
  fi
}

for cmd in rake rspec cucumber cap unicorn puma thin rackup guard compass thor sidekiq jekyll middleman airbrake honeybadger; do
  alias $cmd="use_bundler $cmd"
done


# JavaScript
export PATH="node_modules/.bin:$PATH"
export NODE_OPTIONS="--trace-deprecation --trace-warnings"
export BROWSERSLIST_IGNORE_OLD_DATA=1
export STORYBOOK_DISABLE_TELEMETRY=1
# screw yarn - it sets GIT_SSH_COMMAND internally and thus doesn't respect sshCommand from git config (e.g. ssh keys)
# https://github.com/yarnpkg/yarn/blob/v1.12.3/src/util/git/git-spawn.js
# function yarn {
#   # run in a subshell to avoid setting GIT_SSH_COMMAND outside of this function
#   (
#     export GIT_SSH_COMMAND='ssh -i ~/.ssh/id_ed25519 -F /dev/null'
#     command yarn "$@"
#   )
# }
# function prettier-diff {
#   prettier "$1" | diff "$1" -
# }


# Kubernetes
alias k=kubectl
complete -F _complete_alias k


# Rust
source "$HOME/.cargo/env"


# AWS
export AWS_EB_PROFILE=personal
export SAM_CLI_TELEMETRY=0
complete -C aws_completer aws

function aws {
  if [[ "$@" == *"--help"* ]]; then
    command aws "${@/--help/help}"
  elif [[ "$1" == "elasticbeanstalk" || "$1" == "cloudformation" ]] && [[ "$@" != *"--profile"* ]]; then
    AWS_DEFAULT_PROFILE=$AWS_EB_PROFILE command aws "$@"
  else
    command aws "$@"
  fi
}


# SSH auth using gpg key
# echo "enable-ssh-support" >> ~/.gnupg/gpg-agent.conf
# to restart:
# killall gpg-agent scdaemon shutdown-gpg-agent
# eval $(gpg-agent --daemon)
# export GPG_TTY=$(tty)
# export SSH_AUTH_SOCK=~/.gnupg/S.gpg-agent.ssh
# gpgconf --launch gpg-agent



end=`gdate +%s.%N`
printf 'Shell initialization time: %1.4f seconds.\n' $(bc <<< "$end-$start")
# Initialization time should be around 0.0025 seconds.
