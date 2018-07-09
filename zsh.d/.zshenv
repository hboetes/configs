if [[ -d ~/.configs/zsh.d ]]; then
    export ZDOTDIR=~/.configs/zsh.d
elif [[ -d /etc/zsh/zsh.d ]]; then
    export ZDOTDIR=/etc/zsh/zsh.d
else
    return 0
fi
# Prevent loading /etc/zshrc etc.
unsetopt GLOBAL_RCS
