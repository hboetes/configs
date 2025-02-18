if [[ -e ~/.zshenv ]]; then
    export ZDOTDIR=~/.config/zsh.d
elif [[ -d /etc/zsh/zsh.d ]]; then
    export ZDOTDIR=/etc/zsh/zsh.d
else
    return 0
fi
# Prevent loading /etc/zshrc etc.
unsetopt GLOBAL_RCS
[[ -e ~/.zlocal ]] && source ~/.zlocal
