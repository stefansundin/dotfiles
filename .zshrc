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


# Git

chpwd() { print -Pn "\e]0;$(git config --get remote.origin.url | sed -e 's/.*[\/|:]//' -e 's/\.git$//')\a" }

function git_branch {
  git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -e 's/\(.*\)/ \[\1\]/'
}

setopt PROMPT_SUBST
PROMPT='%{$fg[green]%}%n:%m:%{$fg[red]%}%c%{$fg[blue]%}$(git_branch) %{$reset_color%}%# '


# Ruby

eval "$(rbenv init - zsh)"
