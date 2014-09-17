# Put custom stuff on top


# https://gist.github.com/stefansundin/cebce4a26a32ede58a16#file-profile
export PATH="$HOME/bin:/Applications/Firefox.app/Contents/MacOS:/Applications/Postgres.app/Contents/Versions/9.3/bin:/usr/local/bin:$HOME/.rbenv/versions/2.1.2/bin:$PATH"
export IGNOREEOF=5
export LESSHISTFILE=-
export EDITOR='subl -w'
export TERM=xterm-color
export PGHOST=localhost
export PGDATA="/Users/stefansundin/Library/Application Support/Postgres93/var"


alias ls="ls -G"
alias reload_profile=". ~/.profile"
alias pc="pngcrush -rem gAMA -rem cHRM -rem iCCP -rem sRGB -brute"

function c {
  echo $* | pbcopy
  echo "Copied '$*' to clipboard!"
}


# Git

source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash

function cd {
  builtin cd "$@"
  echo -n -e "\033]0;$(git config --get remote.origin.url | sed -e 's/.*[\/|:]//' -e 's/\.git$//')\007";
}

function git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \[\1\]/'
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
  PS1="$LIGHT_GREEN\h:\u:$RED\W$BLUE\$(git_branch) $DEFAULT\$ "
}
proml


# Ruby

eval "$(rbenv init -)"
export RAILS_ENV=development
export RACK_ENV=development

alias rsetup="RAILS_ENV=test bundle && RAILS_ENV=test bundle exec rake db:migrate"
alias rtest="RAILS_ENV=test bundle exec rspec"
alias resquework="bundle exec rake resque:work QUEUE=*"
alias log="tail -f -n2500 log/development.log"
alias schemadump="bundle exec rake db:schema:dump db:structure:dump"

# auto bundle exec
function use_bundler {
  if [ -r ./Gemfile ]; then
    bundle exec $@
  else
    $@
  fi
}

for cmd in rake spec rspec cucumber cap watchr rails rackup guard etl compass jasmine-headless-webkit thor sidekiq parallel_rspec zeus spring knife; do
  alias $cmd="use_bundler $cmd"
done
