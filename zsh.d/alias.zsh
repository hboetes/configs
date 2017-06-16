if ! id -u |\grep -q '^0$'; then
    alias vipw='EDITOR=sudoedit sudo vipw'
    alias visudo='VISUAL=sudoedit EDITOR=sudoedit sudo visudo'
fi

alias rsync='rsync -avzP'
alias vsync='rsync --modify-window=1 -rtv --delete --no-p --no-g'

# My shells often last longer than the settings.
alias r="rehash"
alias rr="(cd ~/.configs && git pull); source $ZDOTDIR/.zshrc"
alias mv='mv -i'
alias cp='cp -i'
alias p='cd -'

alias ls='ls --color=auto'
alias l='ls -lvha'
alias t='l -rt'
alias s='l -rS'

alias df='df -h | grep -v \^tmpfs'
alias cvsup='cvs -q up -PAd'
alias c='cd; clear'

command -v htop   > /dev/null && alias top='htop'
command -v geeqie > /dev/null && alias gqview='geeqie'
command -v wcalc  > /dev/null && alias calc='wcalc'
command -v pwgen  > /dev/null && alias pwgen='pwgen -y 12 1'

# Global aliases
alias -g L='|less'
alias -g G='|grep'
alias -g H='|head'
alias -g T='|tail'

alias genpasswd='< /dev/urandom tr -dc "a-zA-Z0-9" | dd count=1 bs=12 2> /dev/null; echo'
alias genpasswd2='< /dev/urandom tr -dc "[:graph:]" | dd count=1 bs=12 2> /dev/null; echo'

# To check which compiler was used to compile a binary.
alias which_compiler='objdump --full-contents --section=.comment'
