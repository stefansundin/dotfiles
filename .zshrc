# Put custom stuff on top


# https://github.com/stefansundin/dotfiles/blob/master/.zshrc
export PATH="$HOME/bin:/Applications/Firefox.app/Contents/MacOS:/Applications/Postgres.app/Contents/Versions/9.4/bin:/usr/local/bin:$HOME/.rbenv/versions/2.1.2/bin:$PATH"
setopt IGNOREEOF
export LESSHISTFILE=-
export EDITOR='subl -w'
export TERM=xterm-color
export PGHOST=localhost
export PGDATA="$HOME/Library/Application Support/Postgres/var-9.4"

# wget https://raw.githubusercontent.com/bagder/ca-bundle/master/ca-bundle.crt
export SSL_CERT_FILE="$HOME/ca-bundle.crt"

alias gpg="gpg2"
alias ls="ls -G"
alias pc="pngcrush -rem gAMA -rem cHRM -rem iCCP -rem sRGB -brute"

fpath=(/usr/local/share/zsh-completions $fpath)
autoload -U colors && colors

c() {
  echo $* | pbcopy
  echo "Copied '$*' to clipboard!"
}


# Key bindings

if [ "$TERM" = "xterm-color" ]; then
  bindkey '^[[H'  beginning-of-line       # Home
  bindkey '^[[F'  end-of-line             # End
fi

bindkey '^R' history-incremental-search-backward

# Alt+left/right moves vi-style (breaks at .()" and other things)
bindkey "^[b" vi-backward-word
bindkey "^[f" vi-forward-word

# Alt+Shift+left/right moves whole words
bindkey "^[[1;10D" backward-word
bindkey "^[[1;10C" forward-word

# Alt+Cmd+left/right moves to beginning/end of line
bindkey "^[[1;9D" beginning-of-line
bindkey "^[[1;9C" end-of-line

# Cmd+Backspace delete what's left to the cursor, not whole line
bindkey '^U' backward-kill-line


# Git

chpwd() { print -Pn "\e]0;$(git config --get remote.origin.url | sed -e 's/.*[\/|:]//' -e 's/\.git$//')\a" }

function git_branch {
  git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -e 's/\(.*\)/ \[\1\]/'
}

setopt PROMPT_SUBST
PROMPT='%{$fg[green]%}%n:%m:%{$fg[red]%}%c%{$fg[blue]%}$(git_branch) %{$reset_color%}%# '


# Ruby

eval "$(rbenv init - zsh)"
# export RAILS_ENV=development
# export RACK_ENV=development

alias rsetup="RAILS_ENV=test bundle && RAILS_ENV=test bundle exec rake db:migrate"
alias rspec="RAILS_ENV=test bundle exec rspec"
alias resquework="bundle exec rake resque:work QUEUE=*"
alias log="tail -f -n2500 log/development.log"
alias schemadump="bundle exec rake db:schema:dump db:structure:dump"


# auto bundle exec
use_bundler() {
  if [ -r ./Gemfile ]; then
    bundle exec $@
  else
    $@
  fi
}

for cmd in rake spec cucumber cap watchr rails rackup guard etl compass jasmine-headless-webkit thor sidekiq parallel_rspec zeus spring knife; do
  alias $cmd="use_bundler $cmd"
done
