# Keysbinds
# Use ^v to find out the keynames
bindkey '^[[2~' overwrite-mode
bindkey '^[[3~' delete-char
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey '^[[7~' beginning-of-line
bindkey '^[[8~' end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[,'   insert-last-word # I always hit m-, instead if m-. for some reason

do-nothing() {}; zle -N do-nothing

# If we are in tmux
if [[ $TERM == screen ]]; then
    bindkey '^[OA'   do-nothing
    bindkey '^[OB'   do-nothing
    bindkey '^[OC'   emacs-forward-word
    bindkey '^[OD'   emacs-backward-word
else
    bindkey '^[[1;5A'   do-nothing
    bindkey '^[[1;5B'   do-nothing
    bindkey '^[[1;5C'   emacs-forward-word
    bindkey '^[[1;5D'   emacs-backward-word
fi

bindkey -e                 # emacs key bindings
bindkey ' '  magic-space   # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand

# Unbind c-s and c-q
stty -ixon

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line
